create or replace package body bars.sgn_mgr is

  g_body_version constant varchar2(64) := 'version 1.1 14/03/2017';

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header sgn_mgr' || ' ' || g_header_version || '.';
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body sgn_mgr' || ' ' || g_body_version || '.';
  end body_version;

  --------------------------------------------------------------------------------
  -- set_sign_data - создание подписи в хранилище
  --
  function set_sign_data(p_sign_type in sgn_data.sign_type%type, -- тип ЕЦП
                         p_key_id    in sgn_data.key_id%type, -- идентификатор ключа
                         p_sign_hex  in sgn_data.sign_hex%type -- подпись в HEX формате
                         ) return sgn_data.id%type is
    l_id sgn_data.id%type;
  begin
    insert into sgn_data
      (id, creating_date, sign_type, key_id, sign_hex)
    values
      (s_sgndata.nextval, sysdate, p_sign_type, p_key_id, p_sign_hex)
    returning id into l_id;
    return l_id;
  end set_sign_data;

  --------------------------------------------------------------------------------
  -- del_sign_data - удаление подписи из хранилища
  --
  procedure del_sign_data(p_id in sgn_data.id%type) is
  begin
    delete from sgn_data sd where sd.id = p_id;
  end del_sign_data;

  --------------------------------------------------------------------------------
  -- get_sign_data - получение данных о подписи их хранилища
  --
  procedure get_sign_data(p_id        in sgn_data.id%type,
                          p_sign_type out sgn_data.sign_type%type, -- тип ЕЦП
                          p_key_id    out sgn_data.key_id%type, -- идентификатор ключа
                          p_sign_hex  out sgn_data.sign_hex%type -- подпись в HEX формате
                          ) is
  begin
    select sd.sign_type, sd.key_id, sd.sign_hex
      into p_sign_type, p_key_id, p_sign_hex
      from sgn_data sd
     where sd.id = p_id;
  exception
    when no_data_found then
      raise_application_error(-20000,
                              g_trace_module ||
                              'get_sign_data: Не знайдено запис з ідентифікатором id = [' ||
                              to_char(p_id) || ']',
                              true);
  end get_sign_data;

  --------------------------------------------------------------------------------
  -- store_sep_sign - хранение СЕП-овской подписи на документе
  --
  procedure store_sep_sign(p_ref       oper.ref%type, -- ref документа из oper 
                           p_sign_type in sgn_data.sign_type%type, -- тип ЕЦП
                           p_key_id    in sgn_data.key_id%type, -- идентификатор ключа
                           p_sign_hex  in sgn_data.sign_hex%type -- подпись в HEX формате
                           ) is
    l_id      sgn_data.id%type;
    l_id_prev sgn_data.id%type;
  begin
    -- put signature in store
    l_id := sgn_mgr.set_sign_data(p_sign_type, p_key_id, p_sign_hex);
    -- check if already exist
    begin
      select s.sign_id
        into l_id_prev
        from sgn_ext_store s
       where s.ref = p_ref;
      -- find, then replace sign
      update sgn_ext_store s set s.sign_id = l_id where s.ref = p_ref;
      del_sign_data(l_id_prev);
    exception
      when no_data_found then
        insert into sgn_ext_store (ref, sign_id) values (p_ref, l_id);
    end;
  end;

  --------------------------------------------------------------------------------
  -- set_ext_rec - устновка для внешней подписи rec из arc_rrp - вариант без BIS-ов
  --
  procedure set_ext_rec(p_ref    oper.ref%type, -- ref документа из oper
                        p_rec_id sgn_ext_store.rec_id%type) is
  begin
    update sgn_ext_store set rec_id = p_rec_id where ref = p_ref;
  end;

  --------------------------------------------------------------------------------
  -- store_int_sign - хранение внутренней подписи на документе (визы)
  --
  procedure store_int_sign(p_ref       oper.ref%type, -- ref документа из oper 
                           p_rec_id    oper_visa.sqnc%type, -- номер записи из oper_visa
                           p_sign_type in sgn_data.sign_type%type, -- тип ЕЦП
                           p_key_id    in sgn_data.key_id%type, -- идентификатор ключа
                           p_sign_hex  in sgn_data.sign_hex%type -- подпись в HEX формате
                           ) is
    l_id sgn_data.id%type;
  begin
    -- put signature in store
    l_id := sgn_mgr.set_sign_data(p_sign_type, p_key_id, p_sign_hex);
    -- put link between oper_visa and sign
    insert into sgn_int_store
      (ref, rec_id, sign_id)
    values
      (p_ref, p_rec_id, l_id);
  end;

  --------------------------------------------------------------------------------
  -- del_int_sign - удаление внутренней подписи (при возврате на одну визу)
  --
  procedure del_int_sign(p_ref    oper.ref%type, -- ref документа из oper                           
                         p_rec_id oper_visa.sqnc%type -- номер записи из oper_visa
                         ) is
    l_id sgn_data.id%type;
  begin
    select sis.sign_id
      into l_id
      from sgn_int_store sis
     where sis.ref = p_ref
       and sis.rec_id = p_rec_id;
  
    -- delete from int store
    delete from sgn_int_store sis
     where sis.ref = p_ref
       and sis.rec_id = p_rec_id;
    -- delete sign from store
    del_sign_data(l_id);
  exception
    when no_data_found then
      null;
  end;

  --------------------------------------------------------------------------------
  -- toggle_trace - включить\отключить отладки
  --
  procedure toggle_trace is
  begin
    bc.subst_branch('/');
    update web_barsconfig
       set val = decode(val, '1', '0', '1')
     where key = 'Crypto.DebugMode';
    bc.home;
  end;

  --------------------------------------------------------------------------------
  -- trace_sign - отладочная процедура для анализа проблем с подписью
  --                         
  procedure trace_sign(p_ref           oper.ref%type, -- ref документа из oper
                       p_level         number, -- номер визы 
                       p_key_id        in sgn_data.key_id%type, -- идентификатор ключа 
                       p_sign_mode     in varchar2, -- режим роботи (sign\verify)
                       p_buffer_type   in varchar2, -- тип буфера (int\ext)
                       p_buffer_hex    in clob, -- буфер в HEX
                       p_sign_hex      in sgn_data.sign_hex%type, -- подпись в HEX,
                       p_verify_status in number, -- статус проверки подписи (0-ок)
                       p_verify_error  in varchar2 -- ошибка проверки подписи
                       ) is
  begin
    insert into sgn_trace_sign
      (user_id,
       ref,
       visa_level,
       key_id,
       sign_mode,
       buffer_type,
       buffer_hex,
       buffer_bin,
       sign_hex,
       verify_status,
       verify_error)
    values
      (bars.user_id,
       p_ref,
       p_level,
       p_key_id,
       p_sign_mode,
       p_buffer_type,
       p_buffer_hex,
       utl_raw.cast_to_varchar2(hextoraw(to_char(p_buffer_hex))),
       p_sign_hex,
       p_verify_status,
       p_verify_error);
  end trace_sign;

  --------------------------------------------------------------------------------
  -- diagnostic_problem_sign - диагностика по проблемным документам
  --                                              
  procedure diagnostic_problem_sign(p_ref in number default null) is
    l_buffer clob;
  begin
    for c in (select *
                from sgn_trace_sign
               where nvl(verify_status, 0) != 0
                 and ref = nvl(p_ref, ref)) loop
      begin
        select buffer_bin
          into l_buffer
          from sgn_trace_sign
         where ref = c.ref
           and sign_mode = 'VISA'
           and buffer_type = c.buffer_type;
        dbms_output.put_line('------------------------------------------');
        dbms_output.put_line('ref:: [' || c.ref || ']');
        dbms_output.put_line('buffer1=[' || l_buffer || ']');
        dbms_output.put_line('buffer2=[' || c.buffer_bin || ']');
      exception
        when no_data_found then
          null;
      end;
    end loop;
  end;

  --------------------------------------------------------------------------------
  -- trace_user - контроль проверки рабочего места
  --                         
  procedure trace_user(p_key_id       in sgn_data.key_id%type, -- идентификатор ключа 
                       p_bc_version   in varchar2,
                       p_user_address in varchar2,
                       p_browser_info in varchar2,
                       p_check_status in number, -- статус проверки (0-ок)
                       p_check_error  in varchar2 -- ошибка проверки
                       ) is
  begin
    insert into sgn_user_trace
      (user_id,
       key_id,
       bc_version,
       user_address,
       browser_info,
       check_status,
       check_error)
    values
      (bars.user_id,
       p_key_id,
       p_bc_version,
       p_user_address,
       p_browser_info,
       p_check_status,
       p_check_error);
  end;

begin
  -- Initialization
  select nvl(max(val), 0)
    into g_trace_enabled
    from web_barsconfig
   where key = 'Crypto.DebugMode';
end sgn_mgr;
/
