
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/wcs_sync.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.WCS_SYNC is

  -- ================================== Константы ===============================================
  g_pack_name varchar2(20) := 'wcs_sync. ';
  -- ===============================================================================================
  g_header_version constant varchar2(64) := 'version 1.3 30/03/2015';
  -- возвращает версию заголовка пакета
  function header_version return varchar2;
  -- возвращает версию тела пакета
  function body_version return varchar2;
  -- ===============================================================================================

  -- Удаляет запись в таблице синхронизации
  procedure drop_sync(p_sync_id in wcs_sync_queue.id%type);

  -- Возобновление запись в таблице синхронизации
  procedure refresh_sync(p_sync_id in wcs_sync_queue.id%type);

  -- Создает запись в таблице синхронизации по заявке
  procedure create_sync_cabid(p_bid_id in wcs_bids.id%type);

  -- Получение кода текущего источника данных
  function get_current_dsid return varchar2;

  -- Создание внешнего пользователя
  function create_rmt_user(p_ds_id   in wcs_sync_rmt_users.ds_id%type,
                           p_rmt_id  in wcs_sync_rmt_users.rmt_id%type,
                           p_fio     in staff$base.fio%type,
                           p_logname in staff$base.logname%type,
                           p_type    in staff$base.type%type,
                           p_branch  in staff$base.branch%type,
                           p_created in staff$base.created%type,
                           p_expired in staff$base.expired%type)
    return wcs_sync_rmt_users.lcl_id%type;

  -- Получение локального ид. для внешнего пользователя
  function get_lcl_user(p_ds_id  in wcs_sync_rmt_users.ds_id%type,
                        p_rmt_id in wcs_sync_rmt_users.rmt_id%type)
    return wcs_sync_rmt_users.lcl_id%type;

  -- Получение внешнего ид. для внешнего пользователя
  function get_rmt_user(p_lcl_id in wcs_sync_rmt_users.lcl_id%type)
    return wcs_sync_rmt_users.rmt_id%type;

  -- Проверка есть ли пользователь внешним
  function is_rmt_user(p_staff_id in staff$base.id%type) return number;

  function check_hash_scan(p_bid_id in number,
                           p_question_id in wcs_questions.id%type) return varchar2;

  -- Загрузка заявки из внешнего источника
  procedure load_cabid(p_ds_id  in wcs_sync_datastores.id%type,
                       p_bid_id in number);

  -- Отработка синхронизации
  procedure process_sync(p_sync_id in wcs_sync_queue.id%type);

  -- Отработка очереди синхронизации
  procedure process_queue;

end wcs_sync;
/
CREATE OR REPLACE PACKAGE BODY BARS.WCS_SYNC is

  -- ===============================================================================================
  g_body_version constant varchar2(64) := 'version 1.3 30/03/2015';

  -- Константы для синхронизации
  g_max_failures  constant number := 3;
  g_look_for_days constant number := 30;

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header wcs_sync ' || g_header_version || '.';
  end header_version;
  -- возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body wcs_sync ' || g_body_version || '.';
  end body_version;

  -- ===============================================================================================

  -- Создает запись в таблице синхронизации
  procedure create_sync(p_type_id in wcs_sync_queue.type_id%type,
                        p_ds_id   in wcs_sync_queue.ds_id%type,
                        p_params  in wcs_sync_queue.params%type) is
    l_proc_name varchar2(100) := 'create_sync. ';

    l_status_id wcs_sync_queue.status_id%type := 'WAIT';
  begin
    bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_type_id = ' ||
                     p_type_id || ' p_ds_id = ' || p_ds_id);

    insert into wcs_sync_queue
      (id, type_id, status_id, crt_date, crt_staff_id, ds_id, params)
    values
      (s_wcs_sync_queue.nextval,
       p_type_id,
       l_status_id,
       sysdate,
       user_id,
       p_ds_id,
       p_params);

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
  end create_sync;

  -- Удаляет запись в таблице синхронизации
  procedure drop_sync(p_sync_id in wcs_sync_queue.id%type) is
    l_proc_name varchar2(100) := 'drop_sync. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_sync_id = ' ||
                     p_sync_id);

    delete from wcs_sync_queue sq where sq.id = p_sync_id;

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
  end drop_sync;

  -- Возобновление запись в таблице синхронизации
  procedure refresh_sync(p_sync_id in wcs_sync_queue.id%type) is
    l_proc_name varchar2(100) := 'refresh_sync. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_sync_id = ' ||
                     p_sync_id);

    update wcs_sync_queue sq
       set sq.status_id = 'WAIT', sq.failures = 0, sq.error_message = null
     where sq.id = p_sync_id;

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
  end refresh_sync;

  -- Создает запись в таблице синхронизации по заявке
  procedure create_sync_cabid(p_bid_id in wcs_bids.id%type) is
    l_proc_name varchar2(100) := 'create_sync_cabid. ';

    l_ds_id wcs_sync_datastores.id%type;
  begin
    bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_bid_id = ' ||
                     p_bid_id);

    if (wcs_sync.get_current_dsid = '000000') then
      -- если мы ЦА, то ищем куда отправить заявку по ее бранчу
      select substr(b.branch, 2, 6)
        into l_ds_id
        from wcs_bids b
       where b.id = p_bid_id;
    else
      -- если мы РУ, то отправляем в ЦА
      l_ds_id := '000000';
    end if;
    bars_audit.trace(g_pack_name || l_proc_name || 'Process. l_ds_id = ' ||
                     l_ds_id);

    -- Создает запись в таблице синхронизации
    create_sync('CABID', l_ds_id, t_wcs_sync_params.create_cabid(p_bid_id));

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
  end create_sync_cabid;

  -- Меняет статус синхронизации
  procedure set_sync_status(p_sync_id       in wcs_sync_queue.id%type,
                            p_status_id     in wcs_sync_queue.status_id%type,
                            p_error_message in wcs_sync_queue.error_message%type default null) is
  begin
    -- если статус ERROR - Помилки, то инкременируем некдачную попытку
    update wcs_sync_queue sq
       set sq.status_id     = p_status_id,
           sq.error_message = p_error_message,
           sq.failures      = decode(p_status_id,
                                     'ERROR',
                                     sq.failures + 1,
                                     sq.failures)
     where sq.id = p_sync_id;
  end set_sync_status;

  -- Получение кода текущего источника данных
  function get_current_dsid return varchar2 is
    l_ds_id varchar2(100);
  begin
    select lpad(to_number(val), 2, '0')
      into l_ds_id
      from params$global
     where par = 'KODRU';

    if (l_ds_id is null or l_ds_id = '00') then
      l_ds_id := '000000';
    else
      l_ds_id := f_ourmfo_g;
    end if;

    return l_ds_id;
  exception
    when no_data_found then
      return '000000';
  end get_current_dsid;

  -- Получение локального ид. для внешнего пользователя
  function get_lcl_user(p_ds_id  in wcs_sync_rmt_users.ds_id%type,
                        p_rmt_id in wcs_sync_rmt_users.rmt_id%type)
    return wcs_sync_rmt_users.lcl_id%type is
    l_lcl_id wcs_sync_rmt_users.lcl_id%type;
  begin
    select sru.lcl_id
      into l_lcl_id
      from wcs_sync_rmt_users sru
     where sru.ds_id = p_ds_id
       and sru.rmt_id = p_rmt_id;

    return l_lcl_id;
  end get_lcl_user;

  -- Получение внешнего ид. для внешнего пользователя
  function get_rmt_user(p_lcl_id in wcs_sync_rmt_users.lcl_id%type)
    return wcs_sync_rmt_users.rmt_id%type is
    l_rmt_id wcs_sync_rmt_users.rmt_id%type;
  begin
    select sru.rmt_id
      into l_rmt_id
      from wcs_sync_rmt_users sru
     where sru.lcl_id = p_lcl_id;

    return l_rmt_id;
  end get_rmt_user;

  -- Проверка есть ли пользователь внешним
  function is_rmt_user(p_staff_id in staff$base.id%type) return number is
    l_is_rmt number := 0;
  begin
    select count(1)
      into l_is_rmt
      from wcs_sync_rmt_users sru
     where sru.lcl_id = p_staff_id;

    return l_is_rmt;
  end is_rmt_user;

  -- Создание внешнего пользователя
  function create_rmt_user(p_ds_id   in wcs_sync_rmt_users.ds_id%type,
                           p_rmt_id  in wcs_sync_rmt_users.rmt_id%type,
                           p_fio     in staff$base.fio%type,
                           p_logname in staff$base.logname%type,
                           p_type    in staff$base.type%type,
                           p_branch  in staff$base.branch%type,
                           p_created in staff$base.created%type,
                           p_expired in staff$base.expired%type)
    return wcs_sync_rmt_users.lcl_id%type is
    l_lcl_id    wcs_sync_rmt_users.lcl_id%type;
    l_fio       staff$base.fio%type := p_fio || '(імпорт з МФО=' || p_ds_id || ')';
    l_logname   staff$base.logname%type := p_logname || p_ds_id;
    l_lcl_name  staff$base.logname%type;
    l_id        staff$base.id%type;      
  begin
    -- вичитываем или вставляем
    begin
      l_lcl_id := get_lcl_user(p_ds_id, p_rmt_id);
      l_id     := bars_sqnc.get_nextval('S_STAFF');
    exception
      when no_data_found then
        -- создание фиктивной записи в staff
        insert into staff$base
          (id, fio, logname, type, branch, created, expired)
        values
          (l_id,
           l_fio,
           l_logname,
           p_type,
           p_branch,
           p_created,
           p_expired)
        returning id into l_lcl_id;
        
        select logname into l_lcl_name from staff$base where id = l_lcl_id;
        
        bars_lic.set_user_license(l_lcl_name);

        -- создание записи в таблице внешних пользователей
        insert into wcs_sync_rmt_users
          (lcl_id, ds_id, rmt_id)
        values
          (l_lcl_id, p_ds_id, p_rmt_id);
    end;

    return l_lcl_id;
  end create_rmt_user;

   -- Проверка хэш-а сканкопий
  function check_hash_scan(p_bid_id in number,
                           p_question_id in wcs_questions.id%type) return varchar2 is
    l_res varchar2(32);
    begin
      select dbms_crypto.Hash(val_file,2) into l_res from wcs_answers where bid_id = p_bid_id and question_id = p_question_id;
      return l_res;
    end;

  -- Загрузка заявки из внешнего источника
  procedure load_cabid(p_ds_id  in wcs_sync_datastores.id%type,
                       p_bid_id in number) is
    l_proc_name varchar2(100) := 'sync_bid_data. ';

    l_dblink wcs_sync_datastores.dblink%type;

    -- Загрузка справочника отделений по заявке
    procedure load_bid_branch(p_dblink in wcs_sync_datastores.dblink%type,
                              p_bid_id in number) is
      l_proc_name varchar2(100) := 'load_bid_branch. ';

    begin
      bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_dblink = ' ||
                       p_dblink || ' p_bid_id = ' || p_bid_id);

      -- переливаем таблицу
      --
      execute immediate '
 merge into branch lcl
 using (select b.branch,
               b.name,
               b.b040,
               b.description,
               b.date_opened,
               b.date_closed,
               b.deleted
          from branch@' || p_dblink || ' b
         where b.branch in
               (select wb.branch
                  from wcs_bids@' || p_dblink || ' wb
                 where wb.id = :p_bid_id
                union
                select sb.branch
                  from staff$base@' || p_dblink || ' sb
                 where sb.id in (select wb2.mgr_id
                                   from wcs_bids@' ||
                        p_dblink ||
                        ' wb2
                                  where wb2.id = :p_bid_id
                                 union
                                 select bsh.checkout_user_id
                                   from wcs_bid_states_history@' ||
                        p_dblink || ' bsh
                                  where bsh.bid_id = :p_bid_id))) rmt
 on (lcl.branch = rmt.branch)
 when matched then
   update
      set lcl.name        = rmt.name,
          lcl.b040        = rmt.b040,
          lcl.description = rmt.description,
          lcl.date_opened = rmt.date_opened,
          lcl.date_closed = rmt.date_closed,
          lcl.deleted     = rmt.deleted
 when not matched then
   insert
     (lcl.branch,
      lcl.name,
      lcl.b040,
      lcl.description,
      lcl.date_opened,
      lcl.date_closed,
      lcl.deleted)
   values
     (rmt.branch,
      rmt.name,
      rmt.b040,
      rmt.description,
      rmt.date_opened,
      rmt.date_closed,
      rmt.deleted)'
        using p_bid_id, p_bid_id, p_bid_id;
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. merge into branch done: ' || sql%rowcount ||
                       ' rows');

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
    end load_bid_branch;

    -- Загрузка справочника пользователей по заявке
    procedure load_bid_staff(p_ds_id  in wcs_sync_datastores.id%type,
                             p_dblink in wcs_sync_datastores.dblink%type,
                             p_bid_id in number) is
      l_proc_name varchar2(100) := 'sync_bid_staff. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_ds_id = ' ||
                       p_ds_id || ' p_dblink = ' || p_dblink ||
                       ' p_bid_id = ' || p_bid_id);

      execute immediate '
      declare
        l_lcl_id wcs_sync_rmt_users.lcl_id%type;
      begin
        for cur in (select sb.id,
                           sb.fio,
                           sb.logname,
                           sb.type,
                           sb.branch,
                           sb.created,
                           sb.expired
                      from staff$base@' || p_dblink || ' sb
                     where sb.id in (select bsh.checkout_user_id
                                       from wcs_bid_states_history@' ||
                        p_dblink ||
                        ' bsh
                                      where bsh.bid_id = ' ||
                        p_bid_id || '
                                        and bsh.checkout_user_id is not null
                                     union all
                                     select b.mgr_id
                                       from wcs_bids@' ||
                        p_dblink || ' b
                                      where b.id = ' ||
                        p_bid_id || ')
                       and wcs_sync.is_rmt_user@' ||
                        p_dblink ||
                        '(sb.id) = 0) loop
          l_lcl_id := wcs_sync.create_rmt_user(''' ||
                        p_ds_id || ''',
                                               cur.id,
                                               cur.fio,
                                               cur.logname,
                                               cur.type,
                                               cur.branch,
                                               cur.created,
                                               cur.expired);
        end loop;
      end;';

      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. create_rmt_user done');

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
    end load_bid_staff;

    -- Загрузка таблицы заявок по заявке
    procedure load_bid(p_ds_id  in wcs_sync_datastores.id%type,
                       p_dblink in wcs_sync_datastores.dblink%type,
                       p_bid_id in number) is
      l_proc_name varchar2(100) := 'load_bid. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_dblink = ' ||
                       p_dblink || ' p_bid_id = ' || p_bid_id);

      -- переливаем таблицу
      execute immediate '
    merge into wcs_bids lcl
    using (select id,
                  subproduct_id,
                  crt_date,
                  mgr_id,
                  decode(wcs_sync.is_rmt_user@' ||
                        p_dblink || '(mgr_id), 1, wcs_sync.get_rmt_user@' ||
                        p_dblink || '(mgr_id), wcs_sync.get_lcl_user(:p_ds_id, mgr_id)) as unq_mgr_id,
                  branch,
                  inn,
                  rnk
             from wcs_bids@' || p_dblink || '
            where id = :p_bid_id) rmt
    on (lcl.id = rmt.id)
    when matched then
      update
         set lcl.mgr_id = rmt.unq_mgr_id,
             lcl.branch = rmt.branch,
             lcl.inn    = rmt.inn,
             lcl.rnk    = rmt.rnk
    when not matched then
      insert
        (lcl.id,
         lcl.subproduct_id,
         lcl.crt_date,
         lcl.mgr_id,
         lcl.branch,
         lcl.inn,
         lcl.rnk)
      values
        (rmt.id,
         rmt.subproduct_id,
         rmt.crt_date,
         rmt.unq_mgr_id,
         rmt.branch,
         rmt.inn,
         rmt.rnk)'
        using p_ds_id, p_bid_id;
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. merge into wcs_bids done: ' ||
                       sql%rowcount || ' rows');

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
    end load_bid;

    -- Загрузка таблицы состояний заявок по заявке
    procedure load_bid_states(p_ds_id  in wcs_sync_datastores.id%type,
                              p_dblink in wcs_sync_datastores.dblink%type,
                              p_bid_id in number) is
      l_proc_name varchar2(100) := 'load_bid_states. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_dblink = ' ||
                       p_dblink || ' p_bid_id = ' || p_bid_id);

      -- переливаем таблицу
      --удаляем все статусы в текущей базе(ЦА или РУ)
      delete from wcs_bid_states lcl where lcl.bid_id = p_bid_id;

      execute immediate '
 merge into wcs_bid_states lcl
 using (select bid_id,
               state_id,
               checkouted,
               checkout_dat,
               checkout_user_id,
               decode(wcs_sync.is_rmt_user@' ||
                        p_dblink ||
                        '(checkout_user_id), 1, wcs_sync.get_rmt_user@' ||
                        p_dblink || '(checkout_user_id), wcs_sync.get_lcl_user(:p_ds_id, checkout_user_id)) as unq_checkout_user_id,
               user_comment
          from wcs_bid_states@' || p_dblink || '
         where bid_id = :p_bid_id) rmt
 on (lcl.bid_id = rmt.bid_id and lcl.state_id = rmt.state_id)
 when matched then
   update
      set lcl.checkouted       = rmt.checkouted,
          lcl.checkout_dat     = rmt.checkout_dat,
          lcl.checkout_user_id = rmt.unq_checkout_user_id,
          lcl.user_comment     = rmt.user_comment
 when not matched then
   insert
     (lcl.bid_id,
      lcl.state_id,
      lcl.checkouted,
      lcl.checkout_dat,
      lcl.checkout_user_id,
      lcl.user_comment)
   values
     (rmt.bid_id,
      rmt.state_id,
      rmt.checkouted,
      rmt.checkout_dat,
      rmt.unq_checkout_user_id,
      rmt.user_comment)'
        using p_ds_id, p_bid_id;
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. merge into wcs_bid_states done: ' ||
                       sql%rowcount || ' rows');

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
    end load_bid_states;

    -- Загрузка таблицы истории состояний заявок по заявке
    procedure load_bid_states_history(p_ds_id  in wcs_sync_datastores.id%type,
                                      p_dblink in wcs_sync_datastores.dblink%type,
                                      p_bid_id in number) is
      l_proc_name varchar2(100) := 'load_bid_states_history. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_dblink = ' ||
                       p_dblink || ' p_bid_id = ' || p_bid_id);

      -- переливаем таблицу
      delete from wcs_bid_states_history where bid_id = p_bid_id;

      execute immediate '
  merge into wcs_bid_states_history lcl
  using (select bid_id,
                state_id,
                checkouted,
                checkout_dat,
                checkout_user_id,
               decode(wcs_sync.is_rmt_user@' ||
                        p_dblink ||
                        '(checkout_user_id), 1, wcs_sync.get_rmt_user@' ||
                        p_dblink || '(checkout_user_id), wcs_sync.get_lcl_user(:p_ds_id, checkout_user_id)) as unq_checkout_user_id,
                user_comment,
                change_action,
                change_dat
           from wcs_bid_states_history@' || p_dblink || '
          where bid_id = :p_bid_id order by id) rmt
  on (lcl.bid_id = rmt.bid_id and lcl.state_id = rmt.state_id and lcl.change_action = rmt.change_action and lcl.change_dat = rmt.change_dat)
  when matched then
    update
       set lcl.checkouted       = rmt.checkouted,
           lcl.checkout_dat     = rmt.checkout_dat,
           lcl.checkout_user_id = rmt.unq_checkout_user_id,
           lcl.user_comment     = rmt.user_comment
  when not matched then
    insert
      (lcl.id,
       lcl.bid_id,
       lcl.state_id,
       lcl.checkouted,
       lcl.checkout_dat,
       lcl.checkout_user_id,
       lcl.user_comment,
       lcl.change_action,
       lcl.change_dat)
    values
      (s_wcs_bid_states_history.nextval,
       rmt.bid_id,
       rmt.state_id,
       rmt.checkouted,
       rmt.checkout_dat,
       rmt.unq_checkout_user_id,
       rmt.user_comment,
       rmt.change_action,
       rmt.change_dat)'
        using p_ds_id, p_bid_id;
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. merge into wcs_bid_states_history done: ' ||
                       sql%rowcount || ' rows');

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
    end load_bid_states_history;

    -- Загрузка таблицы ответов по заявке
    procedure load_answers(p_dblink in wcs_sync_datastores.dblink%type,
                           p_bid_id in number) is
      l_proc_name varchar2(100) := 'load_answers. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_dblink = ' ||
                       p_dblink || ' p_bid_id = ' || p_bid_id);

      -- переливаем таблицу без сканкопий
      execute immediate '
    merge into wcs_answers lcl
    using (select *
             from wcs_answers@' || p_dblink ||
                        ' a, wcs_questions q
            where a.bid_id = :p_bid_id
              and a.question_id = q.id
              and q.id != ''FILE'') rmt
    on (lcl.bid_id = rmt.bid_id and lcl.ws_id = rmt.ws_id and lcl.ws_number = rmt.ws_number and lcl.question_id = rmt.question_id)
    when matched then
      update
         set lcl.val_text    = rmt.val_text,
             lcl.val_numb    = rmt.val_numb,
             lcl.val_decimal = rmt.val_decimal,
             lcl.val_date    = rmt.val_date,
             lcl.val_list    = rmt.val_list,
             lcl.val_refer   = rmt.val_refer,
             lcl.val_file    = rmt.val_file,
             lcl.val_file_name=rmt.val_file_name,
             lcl.val_matrix  = rmt.val_matrix,
             lcl.val_bool    = rmt.val_bool,
             lcl.val_xml     = rmt.val_xml
    when not matched then
      insert
        (lcl.bid_id,
         lcl.ws_id,
         lcl.ws_number,
         lcl.question_id,
         lcl.val_text,
         lcl.val_numb,
         lcl.val_decimal,
         lcl.val_date,
         lcl.val_list,
         lcl.val_refer,
         lcl.val_file,
         lcl.val_file_name,
         lcl.val_matrix,
         lcl.val_bool,
         lcl.val_xml)
      values
        (rmt.bid_id,
         rmt.ws_id,
         rmt.ws_number,
         rmt.question_id,
         rmt.val_text,
         rmt.val_numb,
         rmt.val_decimal,
         rmt.val_date,
         rmt.val_list,
         rmt.val_refer,
         rmt.val_file,
         rmt.val_file_name,
         rmt.val_matrix,
         rmt.val_bool,
         rmt.val_xml)'
        using p_bid_id;

      -- переливаем таблицу только сканкопии
      execute immediate '
      merge into wcs_answers lcl
    using (select *
             from wcs_answers@'|| p_dblink ||
                        ' a, wcs_questions q
            where a.bid_id = :p_bid_id
              and a.question_id = q.id
              and q.id = ''FILE'') rmt
    on (lcl.bid_id = rmt.bid_id and lcl.ws_id = rmt.ws_id and lcl.ws_number = rmt.ws_number and lcl.question_id = rmt.question_id and wcs_sync.check_hash_scan(lcl.bid_id,lcl.question_id) != wcs_sync.check_hash_scan@'|| p_dblink ||'(rmt.bid_id,rmt.question_id))
    when matched then
      update
         set lcl.val_file_name = rmt.val_file_name,
             lcl.val_file      = rmt.val_file
    when not matched then
      insert
        (lcl.bid_id,
         lcl.ws_id,
         lcl.ws_number,
         lcl.question_id,
         lcl.val_text,
         lcl.val_numb,
         lcl.val_decimal,
         lcl.val_date,
         lcl.val_list,
         lcl.val_refer,
         lcl.val_file,
         lcl.val_file_name,
         lcl.val_matrix,
         lcl.val_bool,
         lcl.val_xml)
      values
        (rmt.bid_id,
         rmt.ws_id,
         rmt.ws_number,
         rmt.question_id,
         rmt.val_text,
         rmt.val_numb,
         rmt.val_decimal,
         rmt.val_date,
         rmt.val_list,
         rmt.val_refer,
         rmt.val_file,
         rmt.val_file_name,
         rmt.val_matrix,
         rmt.val_bool,
         rmt.val_xml)'
      using p_bid_id;
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. merge into wcs_answers done: ' ||
                       sql%rowcount || ' rows');

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
    end load_answers;

  begin
    bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_ds_id = ' ||
                     p_ds_id || ' p_bid_id = ' || p_bid_id);

    -- правильно логинимся
    bars_login.login_user(null, null, null, null);

    -- параметры источника
    begin
      select sd.dblink
        into l_dblink
        from wcs_sync_datastores sd
       where sd.id = p_ds_id
         and sd.active = 1;
    exception
      when no_data_found then
        raise_application_error(-20001,
                                'Джерело даних ' || p_ds_id ||
                                ' не описано або неактивне.');
    end;
    bars_audit.trace(g_pack_name || l_proc_name || 'Process. l_dblink = ' ||
                     l_dblink);

    -- проверяем соединение с БД
    begin
      execute immediate 'select 1 from dual@' || l_dblink;
    exception
      when others then
        raise_application_error(-20001,
                                'Помилка з`єднання з зовнішньою БД: ' ||
                                sqlerrm);
    end;

    -- Загрузка справочника отделений по заявке (Загрузку из ЦА не делаем)
    if (p_ds_id != '000000') then
      load_bid_branch(l_dblink, p_bid_id);
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. load_bid_branch done');
    end if;

    -- Загрузка справочника пользователей по заявке
    load_bid_staff(p_ds_id, l_dblink, p_bid_id);
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. load_bid_staff done');

    -- Загрузка таблицы заявок по заявке
    load_bid(p_ds_id, l_dblink, p_bid_id);
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. load_bid done');

    -- Загрузка таблицы заявок по заявке
    load_bid_states(p_ds_id, l_dblink, p_bid_id);
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. load_bid_states done');

    -- Загрузка таблицы истории состояний заявок по заявке
    load_bid_states_history(p_ds_id, l_dblink, p_bid_id);
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. load_bid_states_history done');

    -- Загрузка таблицы ответов по заявке
    load_answers(l_dblink, p_bid_id);
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. load_answers done');

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
  end load_cabid;

  -- Отработка синхронизации
  procedure process_sync(p_sync_id in wcs_sync_queue.id%type) is
    l_proc_name varchar2(100) := 'process_sync. ';

    l_sq_row wcs_sync_queue%rowtype;
    l_dblink wcs_sync_datastores.dblink%type;
  begin
    bars_audit.trace(g_pack_name || l_proc_name || 'Start. p_sync_id = ' ||
                     p_sync_id);
    -- параметры синхронизации
    select sq.*
      into l_sq_row
      from wcs_sync_queue sq
     where sq.id = p_sync_id;

    -- установка состояния PROC - У процесі
    set_sync_status(p_sync_id, 'PROC');

    -- параметры источника
    begin
      select sd.dblink
        into l_dblink
        from wcs_sync_datastores sd
       where sd.id = l_sq_row.ds_id
         and sd.active = 1;
    exception
      when no_data_found then
        set_sync_status(p_sync_id,
                        'ERROR',
                        'Джерело даних ' || l_sq_row.ds_id ||
                        ' не описано або неактивне.');
        return;
    end;
    bars_audit.trace(g_pack_name || l_proc_name || 'Process. datastore ok');

    -- проверяем соединение с БД
    begin
      execute immediate 'select 1 from dual@' || l_dblink;
    exception
      when others then
        set_sync_status(p_sync_id,
                        'ERROR',
                        'Помилка з`єднання з зовнішньою БД: ' || sqlerrm);
        return;
    end;
    bars_audit.trace(g_pack_name || l_proc_name || 'Process. dblink ok');

    -- в зависимости от типа обрабатываем
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. l_sq_row.type_id = ' || l_sq_row.type_id);
    case l_sq_row.type_id
      when 'CABID' then
        begin
          execute immediate 'begin bars.bars_login.login_user@'||l_dblink||'(null, null, null, null); end;';
          execute immediate 'begin wcs_sync.load_cabid@' || l_dblink ||
                            '(:p_ds_id, :p_bid_id); end; '
            using wcs_sync.get_current_dsid, l_sq_row.params.bid_id;
          bars_audit.trace(g_pack_name || l_proc_name ||
                           'Process. remote load_cabid done');
        exception
          when others then
            set_sync_status(p_sync_id,
                            'ERROR',
                            'Помилка синхронізації у зовнішньому джерелі ' ||
                            l_dblink || ': ' || sqlerrm);
            return;
        end;
    end case;

    -- установка состояния DONE - Виконано
    set_sync_status(p_sync_id, 'DONE');

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
  end process_sync;

  -- Отработка очереди синхронизации
  procedure process_queue is
    l_proc_name varchar2(100) := 'process_queue. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name || 'Start.');

    -- поочередно обрабатываем очередь синхронизации
    for cur in (select *
                  from wcs_sync_queue sq
                 where sq.crt_date > sysdate - g_look_for_days
                   and sq.status_id in ('WAIT', 'ERROR')
                   and sq.failures <= g_max_failures
                 order by sq.id) loop
      process_sync(cur.id);
      commit;
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. process_sync for id = ' || cur.id ||
                       ' done');
    end loop;

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
  end process_queue;

end wcs_sync;
/
 show err;
 
PROMPT *** Create  grants  WCS_SYNC ***
grant EXECUTE                                                                on WCS_SYNC        to WCS_SYNC_USER;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/wcs_sync.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 