
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_useradm_utl.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_USERADM_UTL is

  --
  -- Идентификация версии
  --

  VERSION_HEADER      constant varchar2(64) := 'version 1.1 26.10.2012';
  VERSION_HEADER_DEFS constant varchar2(512) := '';

  -- Постановка в очередь на пересчет зависимости АРМов и функций
  procedure add_queue_operapp(p_codeapp in applist.codeapp%type);

  -- Постановка в очередь на пересчет зависимости веб-функций
  procedure add_queue_oprlstdeps(p_codeoper in operlist.codeoper%type);

  -- Обновление взаимосвязей АРМа
  procedure calc_operapp(p_codeapp in applist.codeapp%type);

  -- Обновление зависимости веб-функции
  procedure calc_oprlstdeps(p_codeoper in operlist.codeoper%type);

  -- Обработка очереди зависимостей АРМом
  procedure process_queue_operapp;

  -- Обработка очереди зависимости веб-функций
  procedure process_queue_oprlstdeps;

  -- Запуск джоба обработки очереди зависимостей АРМом
  procedure job_queue_operapp;

  -- Запуск джоба обработки очереди зависимости веб-функций
  procedure job_queue_oprlstdeps;

  -----------------------------------------------------------------
  --                                                             --
  --  Методы идентификации версии                                --
  --                                                             --
  -----------------------------------------------------------------

  -----------------------------------------------------------------
  -- HEADER_VERSION()
  --
  --     Функция получения версии заголовка пакета
  --
  --
  --
  function header_version return varchar2;

  -----------------------------------------------------------------
  -- BODY_VERSION()
  --
  --     Функция получения версии тела пакета
  --
  --
  --
  function body_version return varchar2;

end bars_useradm_utl;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_USERADM_UTL is

  version_body      constant varchar2(64) := 'version 1.2 21.11.2012';
  version_body_defs constant varchar2(512) := '';

  -----------------------------------------------------------------
  -- Constants
  --
  MODCODE  constant varchar2(3) := 'ADM';
  PKG_CODE constant varchar2(100) := 'usradmutl';

  g_rows_limit constant number := 5000;
  g_job_lag    constant number := 10;

  g_job_what_app  varchar2(1000) := 'bars.bars_useradm_utl.process_queue_operapp; ';
  g_job_what_oper varchar2(1000) := 'bars.bars_useradm_utl.process_queue_oprlstdeps; bars.bars_useradm_utl.process_queue_operapp; ';

  -- Получение признак повышенной/пониженной безопасности
  function get_secure_state return number is
    l_value params.val%type;
  begin
    select val into l_value from params where par = 'LOSECURE';

    if (l_value = '1') then
      return 0;
    end if;

    return 1;

  end get_secure_state;

  -- Постановка в очередь на пересчет зависимости АРМов и функций
  procedure add_queue_operapp(p_codeapp in applist.codeapp%type) is
  begin
    insert into queue_operapp_acs (codeapp) values (p_codeapp);
  exception
    when dup_val_on_index then
      null;
  end add_queue_operapp;

  -- Постановка в очередь на пересчет зависимости веб-функций
  procedure add_queue_oprlstdeps(p_codeoper in operlist.codeoper%type) is
  begin
    insert into queue_oprlstdeps_acs (codeoper) values (p_codeoper);
  exception
    when dup_val_on_index then
      null;
  end add_queue_oprlstdeps;

  -- Обновление взаимосвязей АРМа
  procedure calc_operapp(p_codeapp in applist.codeapp%type) is
    p constant varchar2(100) := PKG_CODE || '.calc_operapp';
    l_state number := get_secure_state;
  begin
    bars_audit.trace('%s: entry point', p);

    -- удаляем все что было раньше
    delete from operapp_acs oaa where oaa.codeapp = p_codeapp;

    -- добавляем заново
    insert into operapp_acs
      (codeapp, codeoper)
      select distinct p_codeapp, oda.id_child
        from operapp oa, operlist_deps_acs oda
       where oa.codeapp = p_codeapp
         and oa.codeoper = oda.id_parent
         and decode(l_state, 0, 1, oa.approve) = 1
         and date_is_valid(oa.adate1, oa.adate2, oa.rdate1, oa.rdate2) = 1;

    bars_audit.trace('%s: succ end', p);
  end calc_operapp;

  -- Обновление зависимости веб-функции
  procedure calc_oprlstdeps(p_codeoper in operlist.codeoper%type) is
    p constant varchar2(100) := PKG_CODE || '.calc_oprlstdeps';

    l_runable operlist.runable%type;
    l_cnt     number;
  begin
    bars_audit.trace('%s: entry point', p);

    -- удаляем все что было раньше
    delete from operlist_deps_acs oda where oda.id_parent = p_codeoper;

    -- берем параметры функции
    begin
      select o.runable
        into l_runable
        from operlist o
       where o.codeoper = p_codeoper;
    exception
      when no_data_found then
        -- если просто удаление, то корректно выполняем отчистку и выходим
        l_runable := -1;
    end;

    -- если функциия не runable = 1, то не сохраняем ее
    if (l_runable = 1) then
      -- вставляем саму себя
      insert into operlist_deps_acs
        (id_parent, id_child)
      values
        (p_codeoper, p_codeoper);

      -- перестраиваем заново
      for cur in (select id_child
                    from operlist_deps
                   start with id_parent = p_codeoper
                  connect by prior id_child = id_parent) loop
        select count(1)
          into l_cnt
          from operlist_deps_acs oda
         where oda.id_parent = p_codeoper
           and oda.id_child = cur.id_child;

        if (l_cnt = 0) then
          insert into operlist_deps_acs
            (id_parent, id_child)
          values
            (p_codeoper, cur.id_child);
        else
          null;
        end if;
      end loop;
    end if;

    -- перестраиваем зависимости АРМов и функций
    for cur in (select * from operapp_acs oa where oa.codeoper = p_codeoper) loop
      add_queue_operapp(cur.codeapp);
    end loop;

    -- рекурсивно запускаем для вышестоящих функций
    for cur in (select id_parent
                  from operlist_deps
                 where id_child = p_codeoper) loop
      calc_oprlstdeps(cur.id_parent);
    end loop;

    bars_audit.trace('%s: succ end', p);
  end calc_oprlstdeps;

  -- Обработка очереди зависимостей АРМом
  procedure process_queue_operapp is
    p constant varchar2(100) := PKG_CODE || '.process_queue_operapp';

    type t_applist is table of queue_operapp_acs.codeapp%type;
    l_applist t_applist;

    l_cnt      number;
    l_islocked boolean;
    l_dummy    number;
  begin
    bars_audit.trace('%s: entry point', p);

    select codeapp bulk collect
      into l_applist
      from queue_operapp_acs
     where rownum <= g_rows_limit;

    for i in 1 .. l_applist.count loop
      -- блокируем записи
      begin
        select 1
          into l_dummy
          from queue_operapp_acs
         where codeapp = l_applist(i)
           for update nowait;

        l_islocked := true;
      exception
        when others then
          l_islocked := false;
      end;

      -- если получилось заблокировать, пересчитываем зависимости
      if (l_islocked) then
        calc_operapp(l_applist(i));

        -- удаляем из очереди
        delete from queue_operapp_acs where codeapp = l_applist(i);
      end if;

      -- коммиь пачками
      l_cnt := l_cnt + 1;
      if (mod(l_cnt, 500) = 0) then
        commit;
      end if;
    end loop;
    commit; -- на пакет записей

    bars_audit.trace('%s: succ end', p);
  end process_queue_operapp;

  -- Обработка очереди зависимости веб-функций
  procedure process_queue_oprlstdeps is
    p constant varchar2(100) := PKG_CODE || '.process_queue_oprlstdeps';

    type t_operlist is table of queue_oprlstdeps_acs.codeoper%type;
    l_operlist t_operlist;

    l_cnt      number;
    l_islocked boolean;
    l_dummy    number;
  begin
    bars_audit.trace('%s: entry point', p);

    select codeoper bulk collect
      into l_operlist
      from queue_oprlstdeps_acs
     where rownum <= g_rows_limit;

    for i in 1 .. l_operlist.count loop
      -- блокируем записи
      begin
        select 1
          into l_dummy
          from queue_oprlstdeps_acs
         where codeoper = l_operlist(i)
           for update nowait;

        l_islocked := true;
      exception
        when others then
          l_islocked := false;
      end;

      -- если получилось заблокировать, пересчитываем зависимости
      if (l_islocked) then
        calc_oprlstdeps(l_operlist(i));

        -- удаляем из очереди
        delete from queue_oprlstdeps_acs where codeoper = l_operlist(i);
      end if;

      -- коммиь пачками
      l_cnt := l_cnt + 1;
      if (mod(l_cnt, 500) = 0) then
        commit;
      end if;
    end loop;
    commit; -- на пакет записей

    bars_audit.trace('%s: succ end', p);
  end process_queue_oprlstdeps;

  -- Запуск джоба обработки очереди зависимостей АРМом
  procedure job_queue_operapp is
    p constant varchar2(100) := PKG_CODE || '.job_queue_operapp';

    l_job             number;
    l_job_oper_exists number;
  begin
    bars_audit.trace('%s: entry point', p);

    for cur in (select * from all_jobs aj where aj.what = g_job_what_app) loop
      dbms_job.remove(cur.job);
      bars_audit.info(p || ': job removed: cur.job = ' || cur.job || ' cur.what = ' || cur.what);
    end loop;

    -- запускаем джоб по АРМам, только если не запущен по функциям
    select count(*)
      into l_job_oper_exists
      from all_jobs aj
     where aj.what = g_job_what_oper;
    if (l_job_oper_exists = 0) then
      dbms_job.submit(l_job,
                      g_job_what_app,
                      sysdate + g_job_lag / 24 / 60 / 60,
                      null);
      bars_audit.info(p || ': job submited: l_job = ' || l_job || ' g_job_what_app = ' || g_job_what_app);
    end if;

    bars_audit.trace('%s: succ end', p);
  end job_queue_operapp;

  -- Запуск джоба обработки очереди зависимости веб-функций
  procedure job_queue_oprlstdeps is
    p constant varchar2(100) := PKG_CODE || '.job_queue_oprlstdeps';

    l_job number;
  begin
    bars_audit.trace('%s: entry point', p);

    for cur in (select *
                  from all_jobs aj
                 where aj.what in (g_job_what_oper, g_job_what_app)) loop
      dbms_job.remove(cur.job);
      bars_audit.info(p || ': job removed: cur.job = ' || cur.job || ' cur.what = ' || cur.what);
    end loop;

    dbms_job.submit(l_job,
                    g_job_what_oper,
                    sysdate + g_job_lag / 24 / 60 / 60,
                    null);
    bars_audit.info(p || ': job submited: l_job = ' || l_job || ' g_job_what_oper = ' || g_job_what_oper);

    bars_audit.trace('%s: succ end', p);
  end job_queue_oprlstdeps;

  -----------------------------------------------------------------
  --                                                             --
  --  Методы идентификации версии                                --
  --                                                             --
  -----------------------------------------------------------------

  -----------------------------------------------------------------
  -- HEADER_VERSION()
  --
  --     Функция получения версии заголовка пакета
  --
  --
  --
  function header_version return varchar2 is
  begin
    return 'package header BARS_USERADM_UTL ' || VERSION_HEADER || chr(10) || 'package header definition(s):' || chr(10) || VERSION_HEADER_DEFS;
  end header_version;

  -----------------------------------------------------------------
  -- BODY_VERSION()
  --
  --     Функция получения версии тела пакета
  --
  --
  --
  function body_version return varchar2 is
  begin
    return 'package body BARS_USERADM_UTL ' || VERSION_BODY || chr(10) || 'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
  end body_version;

end bars_useradm_utl;
/
 show err;
 
PROMPT *** Create  grants  BARS_USERADM_UTL ***
grant EXECUTE                                                                on BARS_USERADM_UTL to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_useradm_utl.sql =========*** En
 PROMPT ===================================================================================== 
 