CREATE OR REPLACE PACKAGE "PKG_STAT" is

  g_header_version  constant varchar2(64) := 'version 1.2 04/02/2019';

  --конвертация символов НБУ (день, месяц, год)
  function nbu_decode(s_ in varchar2)
  return varchar2;
  -------------------------------------------------------------------------------
  --возвращает последнюю подпись
  procedure get_last_sign(p_file_id  in  STAT_FILE_SIGNS.FILE_ID%TYPE,
                          p_sign     out STAT_FILE_SIGNS.SIGN%TYPE);    
  -------------------------------------------------------------------------------
 --возвращает список типов файлов доступных для загрузки
  procedure get_type_list_p(res out BARS.VARCHAR2_LIST);

  --------------------------------------------------------------------------------
   --Функція, яка повертае HASH файлу по storage_id
  function get_file_hash_by_storage(p_storage_id  in stat_file_storage.id%type )
    return stat_file_storage.file_hash%type;
  --------------------------------------------------------------------------------
  --процедура, яка повертае тіло файлу по storage_id
  procedure get_file_data_by_storage(p_storage_id in stat_file_storage.id%type,
                                     p_file_data  out stat_file_data.file_data%type);
  --------------------------------------------------------------------------------                                    
  -- повертає ID ЄЦП, для поточного користувача
  function get_user_key_id
     return varchar2;
  --------------------------------------------------------------------------------
  -- применяет операцию к файлу
  procedure set_file_operation(p_file_id      in stat_files.id%type,
                               p_oper_id      in stat_operations.id%type,
                               p_sign         in STAT_FILE_SIGNS.sign%type:=null,
                               p_reverse      in int := 0);
  --------------------------------------------------------------------------------
  -- добавляет файл
  procedure add_file(p_file_name    in stat_files.name%type,
                     p_file_data    in stat_file_data.file_data%type,
                     p_file_hash    in stat_file_storage.file_hash%type,
                     p_file_id      out stat_files.id%type,
                     p_storage_id   out stat_file_storage.id%type
                     );

--------


end PKG_STAT;
/
CREATE OR REPLACE PACKAGE BODY "PKG_STAT" is

  g_body_version  constant varchar2(64) := 'version 1.2 04/02/2019';
  g_dbgcode       constant varchar2(12) := 'PKG_STAT';
  g_first_version   constant int := 1;
  g_load_oper       constant int := 0;  --операция загрузки
  g_file_status_new constant int := 1;  --первый статус после загрузки

  --конвертация символов НБУ (день, месяц, год)
  function nbu_decode(s_ in varchar2)
  return varchar2 is
    enqstr  constant varchar2(255) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    ss_ char(2);
  begin
    ss_ := '';
    IF instr(enqstr,s_)>0 then
      ss_ := ascii(s_)-55;
    else
      ss_ := lpad(s_,2,0);
    end if;
    return ss_;
  end nbu_decode;

  --возвращает последнюю подпись
  procedure get_last_sign(p_file_id  in  STAT_FILE_SIGNS.FILE_ID%TYPE,
                          p_sign     out STAT_FILE_SIGNS.SIGN%TYPE) is
  begin
    select s.sign
    into   p_sign 
    from STAT_FILE_SIGNS s , stat_file_operations_hist h
    where s.file_id  = p_file_id
      and s.end_oper = 1 --только с признаком последняя
      and h.file_id  = p_file_id
      and h.id       = s.oper_hist
      and h.way      = 1; --только прямая
  exception when no_data_found then   
    p_sign:=null;  
  end;

  procedure get_type_list_p(res out BARS.VARCHAR2_LIST) is
    l_list BARS.VARCHAR2_LIST;
  begin
    select distinct ft.code
      BULK COLLECT
      INTO l_list
      from stat_workflow_operations wo,
           stat_access              sa,
           V_ROLE_STAFF             sr,
           STAT_FILE_TYPES          FT
     where sa.wf_oper_id = wo.id
       and sr.role_id = sa.role
       and sr.user_id = sys_context('bars_global', 'user_id')
       and ft.wf_id = wo.wf_id
       and wo.oper_id = g_load_oper;
    res := l_list;
  end;

  -- повертає ID ЄЦП, для поточного користувача
  function get_user_key_id
     return varchar2
  is
     l_key_id  staff$base.tabn%type;
  begin
      select tabn into l_key_id  from staff$base
      where tabn is not null
        and id=user_id;
      return l_key_id;
  exception
  when no_data_found then
     --   raise_application_error(-20000, 'По користувачу не знайдено ключ для підпису');
     return null;
  end get_user_key_id;


   --Функція, яка повертае HASH файлу по самому файлу
  function get_file_hash(p_file_data in stat_file_data.file_data%type)
    return stat_file_storage.file_hash%type is
    l_file_hash   stat_file_storage.file_hash%type;
  begin
    l_file_hash   := dbms_crypto.hash(src => p_file_data,typ => dbms_crypto.hash_md5);
    return l_file_hash;
  end get_file_hash;

   --Функція, яка повертае HASH файлу по storage_id
  function get_file_hash_by_storage(p_storage_id  in stat_file_storage.id%type )
    return stat_file_storage.file_hash%type is
    l_file_hash   stat_file_storage.file_hash%type;
    l_file_data   stat_file_data.file_data%type;
  begin
    select file_data into l_file_data from   stat_file_data where storage_id = p_storage_id;
    l_file_hash   := dbms_crypto.hash(src => l_file_data,typ => dbms_crypto.hash_md5);
    return l_file_hash;
  end get_file_hash_by_storage;

--процедура, яка повертае тіло файлу по storage_id
procedure get_file_data_by_storage(p_storage_id in stat_file_storage.id%type,
                                   p_file_data  out stat_file_data.file_data%type) is
begin
  select file_data
    into p_file_data
    from stat_file_data
   where storage_id = p_storage_id;
end get_file_data_by_storage;

   --Функція, яка повертае імя файлу
  function get_file_id(p_file_name stat_files.name%type)
    return stat_files.id%type is
    l_file_id   stat_files.id%type;
  begin
    begin
      select t.id
        into l_file_id
        from stat_files t
       where t.name = p_file_name;
    exception
      when no_data_found then
        l_file_id := null;
    end;
    return l_file_id;
  end get_file_id;


  function get_workflow_id(p_file_type_id in stat_files.file_type_id%type)
    return number is
    l_res       stat_workflows.id%type;
    l_type_name stat_file_types.name%type;
  begin

    select w.id
      into l_res
      from stat_workflows w, stat_file_types t
     where w.id = t.wf_id
       and t.id = p_file_type_id;

    return l_res;

  exception
    when no_data_found then

      select name
        into l_type_name
        from stat_file_types
       where id = p_file_type_id;

      -- workflow для указанного типа не найден
       raise_application_error(-20001,'workflow для даного типу файлу не знайдено!');

  end;

  --------------------------------------------------------------------------------
  -- set_file_operation - применяет операцию к файлу
  procedure set_file_operation(p_file_id      in stat_files.id%type,
                               p_oper_id      in stat_operations.id%type,
                               p_sign         in STAT_FILE_SIGNS.sign%type:=null,
                               p_reverse      in int := 0) is
    l_th constant varchar2(100) := g_dbgcode || 'set_file_operation';
    l_oper         v_stat_workflow_operations_all%rowtype;
    l_file_id      stat_files.id%type;
    l_file_name    stat_files.name%type;
    l_status_id    stat_files.status%type;
    l_status_name  stat_file_statuses.name%type;
    l_wf_id        stat_workflows.id%type;
    l_id           stat_file_operations_hist.id%type;
    l_oper_id      stat_OPERATIONS.ID%type;
    l_tr           stat_file_operations_hist.tr_id%type;
    l_user_comment stat_file_operations_hist.user_comment%type;
    l_signer_id    stat_files.signer_id%type;
    l_sign_date    stat_files.sign_date%type;

  begin
    logger.trace('%s: entry point', l_th);

    begin
      select f.id
      into l_file_id
        from stat_files f,
            stat_file_storage s
        where f.id = p_file_id
          and s.file_id = f.id
          and  f.last_version = s.file_ver
          and get_file_hash_by_storage(s.id) = s.file_hash;
    exception when no_data_found then
      --не совпадает первоначальный HASH с файлом
      raise_application_error(-20001,'Увага!! Файл було змінено в процессі підписання усіма учасниками!!');
    end;

    if p_sign is not null then
      l_signer_id:=gl.USR_ID;
      l_sign_date:=sysdate;
    end if;

    -- поиск файла

  if p_reverse = 1 then  --откат последней операции
     begin
        select f.id, f.status , s.name status_name,h.oper_id, h.tr_id , t.wf_id, f.name
          into l_file_id, l_status_id, l_status_name,l_oper_id,l_tr, l_wf_id, l_file_name
        from stat_files f,stat_file_statuses s, stat_file_operations_hist h, stat_file_types t
       where f.status = s.id
         and h.file_id  = f.id
         and f.id   = p_file_id
         and f.file_type_id = t.id
         and h.id  = (select max(h1.id)  from  stat_file_operations_hist h1,
                                                  stat_operations o1
                                            where h1.oper_id =o1.id
                                              and h1.file_id = f.id
                                              and o1.end_status = f.status
                                              and h1.way=1);
     exception
      when no_data_found then

        -- файл не найден
      raise_application_error(-20001,'Файл '||p_file_id||' не знайдено!');
    end;
 else
    begin

      select f.id, f.status, s.name, t.wf_id, f.name
        into l_file_id, l_status_id, l_status_name, l_wf_id, l_file_name
        from stat_files f, stat_file_types t, stat_file_statuses s
       where f.id = p_file_id
         and f.file_type_id = t.id
         and f.status = s.id;

    exception
      when no_data_found then

        -- файл не найден
      raise_application_error(-20001,'Файл '||p_file_id||' не знайдено!');

    end;
    l_oper_id:=  p_oper_id;
 end if;

    -- поиск операции
    begin
      select *
        into l_oper
        from v_stat_workflow_operations_all
       where wf_id = l_wf_id
         and oper_id = l_oper_id;

    exception
      when no_data_found then

        --  не найдена подходящая операция
      raise_application_error(-20001,'Не знайдено відповідної операції!');

    end;

    if ((nvl(p_reverse,0) = 0 and l_oper.begin_status != l_status_id) or (p_reverse = 1 and (l_oper.end_status != l_status_id or l_oper.END_OPER = 1 or l_oper.oper_id = g_load_oper))) then

      --  невозможно применить указанную операцию
      raise_application_error(-20001,'неможливо виконати операцію '||l_oper.oper_name||' для файлу '||to_char(p_file_id));

    end if;

    if p_reverse = 1 then
      -- при обратной операции
      l_user_comment := 'Откат операции';
      update stat_files f
         set f.status = l_oper.begin_status,
             f.status_date = sysdate,
             signer_id     = l_signer_id,
             sign_date     = l_sign_date,
             f.end_oper    = null
       where id = l_file_id;
    insert into stat_file_operations_hist
      (id,
       file_id,
       user_comment,
       user_id,
       oper_id,
       oper_date,
       tr_id,
       WAY)
    values
      (S_stat_FILE_OPERATIONS_hist.nextval,
       l_file_id,
       l_user_comment,
       gl.USR_ID,
       l_oper.oper_id,
       sysdate,
       dbms_transaction.local_transaction_id,
       2)
    returning id into l_id;

    update   stat_file_operations_hist EFO
    set      EFO.WAY = 3
    where    EFO.ID = (select max(EFOm.Id) from stat_file_operations_hist EFOm where EFOm.File_Id = l_file_id and EFOm.Oper_Id = l_oper.oper_id and EFOm.ID<l_id);
    else
      -- при прямой операции
      update stat_files f
         set f.status = l_oper.end_status,
             f.status_date = sysdate,
             signer_id     = l_signer_id,
             sign_date     = l_sign_date,
             f.end_oper    = l_oper.END_OPER
       where id = l_file_id;
     insert into stat_file_operations_hist
      (id,
       file_id,
       user_comment,
       user_id,
       oper_id,
       oper_date,
       tr_id,
       WAY)
    values
      (S_stat_FILE_OPERATIONS_hist.nextval,
       l_file_id,
       l_user_comment,
       gl.USR_ID,
       l_oper.oper_id,
       sysdate,
       dbms_transaction.local_transaction_id,
       1 )
     returning id into l_id;

      if p_sign is not null then
      insert into STAT_FILE_SIGNS
        (sign_id,
         file_id,
         sign_date,
         user_id,
         sign,
         oper_hist,
         END_OPER
         )
       values
         (S_STATFILESIGNS.nextval,
          p_file_id,
          l_sign_date,
          l_signer_id,
          p_sign,
          l_id,
          l_oper.END_OPER);
      end if;
   end if;

   logger.info(g_dbgcode||' Операція '||l_oper.oper_name||' над файлом '||l_file_name||' виконано');

    logger.trace('%s: done', l_th);

  end set_file_operation;


  -- iadd_file_header - добавляет заголовок файла
  function iadd_file_header(p_file_name    in stat_files.name%type,
                            p_file_status  in stat_files.status%type)
    return stat_files.id%type is
    l_th constant varchar2(100) := g_dbgcode || 'iadd_file_header';
    l_row        stat_files%rowtype;
    l_res        stat_files.id%type;
    l_oper_id    stat_operations.id%type;
    l_wf_id      stat_workflows.id%type;
    l_stat_version stat_files.last_version%type;
  begin
    logger.trace('%s: entry point', l_th);

    --Шукаемо чи був файл вже прийнятим
    l_row.id := get_file_id(p_file_name);

    if (l_row.id is null) then
      select S_STATFILES.nextval into l_row.id from dual;
      l_row.last_version := g_first_version;
      l_stat_version       := null;

    begin
      select id into l_row.file_type_id  from stat_file_types where code = substr(p_file_name,1,3);
    exception when no_data_found then
       raise_application_error(-20001,'Не знайдено відповідного типу файлу для '||substr(p_file_name,1,3));
    end;
    else
/*      select last_version
        into l_stat_version
        from stat_files
       where id = l_row.id;
      l_row.last_version := l_stat_version + 1;*/

    raise_application_error(-20001,'Заборонено завантажувати один файл двічі');
    end if;
    l_row.name            := p_file_name;
    l_row.zdate           := nbu_decode(substr(p_file_name,7,1))||'.'||nbu_decode(substr(p_file_name,8,1));
    l_row.status          := p_file_status;
    l_row.load_date       := sysdate;
    l_row.status_date     := sysdate;

    --ID исполнителя, загрузившего файл
    l_row.load_user_id := gl.USR_ID;
    -- проверить параметры файла перед вставкой
    if (l_stat_version is null) then
      insert into stat_files
        (id,
         file_type_id,
         name,
         zdate,
         load_date,
         load_user_id,
         exec_user_id,
         status,
         status_date,
         last_version)
      values
        (l_row.id,
         l_row.file_type_id,
         l_row.name,
         l_row.zdate,
         l_row.load_date,
         l_row.load_user_id,
         l_row.exec_user_id,
         l_row.status,
         l_row.status_date,
         l_row.last_version)
      returning id into l_res;
    else
      update stat_files
         set file_type_id = l_row.file_type_id,
             name         = l_row.name,
             load_date    = l_row.load_date,
             load_user_id = l_row.load_user_id,
             exec_user_id = l_row.exec_user_id,
             status       = l_row.status,
             status_date  = l_row.status_date,
             last_version = l_row.last_version
       where id = l_row.id;

      l_res := l_row.id;
    end if;

    -- установить первую операцию
    if l_row.status = g_file_status_new then

      l_wf_id := get_workflow_id(l_row.file_type_id);

      begin
        select oper_id
          into l_oper_id
          from v_stat_workflow_operations_all
         where wf_id = l_wf_id
           and end_status = g_file_status_new;
      exception
        when others then
          l_oper_id := null;
      end;

      set_file_operation(p_file_id      => l_res,
                         p_oper_id      => l_oper_id
                         );

    end if;
    logger.trace('%s: done', l_th);
    return l_res;
  end;


  --------------------------------------------------------------------------------
  -- iadd_file_body - добавляет тело файла
  --
  function iadd_file_body(p_file_id   in stat_files.id%type,
                          p_file_hash    in stat_file_storage.file_hash%type,
                          p_file_data in stat_file_data.file_data%type
                          ) return stat_files.id%type is
    l_th constant varchar2(100) := g_dbgcode || 'iadd_file_body';
    l_res       stat_files.id%type;
    l_store_rec stat_file_storage%rowtype;
    l_data_rec  stat_file_data%rowtype;
  begin
    logger.trace('%s: entry point', l_th);

    if p_file_data is null then
         raise_application_error(-20001,'Файл не містить даних!');
    else
          l_store_rec.file_size   := dbms_lob.getlength(p_file_data);
          l_store_rec.file_hash   := get_file_hash(p_file_data);
/*          if  p_file_hash <> l_store_rec.file_hash then
            raise_application_error(-20001,'Вирахуваний Hash не співпадає з отриманим!');
          end if;*/

    end if;

    select s_statfilestorage.nextval into l_store_rec.id from dual;
    l_store_rec.file_id     := p_file_id;

    l_store_rec.upd_date    := sysdate;
    l_store_rec.upd_user_id := gl.USR_ID;

    begin
      select nvl(max(file_ver), 0) + 1
        into l_store_rec.file_ver
        from stat_file_storage
       where file_id = p_file_id;
    exception
      when no_data_found then
        l_store_rec.file_ver := g_first_version;
    end;


    insert into stat_file_storage values l_store_rec returning id into l_res;

    l_data_rec.file_id    := p_file_id;
    l_data_rec.storage_id := l_res;
    l_data_rec.file_data  := p_file_data;

    insert into stat_file_data values l_data_rec;

    return l_res;

    logger.trace('%s: done', l_th);

  end;

  --------------------------------------------------------------------------------
  -- add_file - добавляет файл
  procedure add_file(p_file_name    in stat_files.name%type,
                     p_file_data    in stat_file_data.file_data%type,
                     p_file_hash    in stat_file_storage.file_hash%type,
                     p_file_id      out stat_files.id%type,
                     p_storage_id   out stat_file_storage.id%type
                     ) is
    l_th constant varchar2(100) := g_dbgcode || 'add_file';
    l_file_id  stat_files.id%type;
    l_store_id stat_file_storage.id%type;
    l_file_status_new stat_files.status%type;
  begin
    logger.trace('%s: entry point', l_th);
    begin
      l_file_status_new:=0;
      l_file_id := iadd_file_header(p_file_name    => p_file_name,
                                    p_file_status  => nvl(l_file_status_new,g_file_status_new));

      -- тело файла
      l_store_id := iadd_file_body(p_file_id   => l_file_id,
                                   p_file_hash => p_file_hash,
                                   p_file_data => p_file_data);

      p_file_id    := l_file_id;
      p_storage_id := l_store_id;

    set_file_operation(p_file_id => p_file_id, p_oper_id => 0);

   logger.info(g_dbgcode||' Файл '||p_file_name||' успішно створено!');

    exception
      when others then
        raise_application_error(-20001,dbms_utility.format_error_stack() ||chr(10) || dbms_utility.format_error_backtrace());
    end;

    logger.trace('%s: done', l_th);
  end add_file;


begin
null;
end PKG_STAT;
/
