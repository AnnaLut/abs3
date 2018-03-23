
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_web_ui.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_WEB_UI is

  --
  -- Автор  : OLEG
  -- Создан : 26.11.2013
  --
  -- Purpose : Пакет процедур обслуживающий функции интерфейса пользователей WEB
  --

  -- Public constant declarations
  g_header_version  constant varchar2(64)  := 'version 1.0 26/11/2013';
  g_awk_header_defs constant varchar2(512) := '';

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  --------------------------------------------------------------------------------
  -- job_statfunc_buff - процедура переливки накопленных данных из буфера в основную таблицу
  --
  --
  procedure job_statfunc_buff;

  --------------------------------------------------------------------------------
  -- select_function - процедура фиксации выбора функции в интерфейсе
  --
  -- @p_func_url - урл функции
  -- @p_user_data - информация о хосте
  --
  procedure select_function(
    p_func_url in varchar2,
    p_user_data in varchar2
  );

  --------------------------------------------------------------------------------
  -- job_statfunc_clean - процедура очистки данных статистики пользователя за прошлый период
  --
  --
  procedure job_statfunc_clean(
    p_store_days_cnt integer
  );


end bars_web_ui;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_WEB_UI is

  --
  -- Автор  : OLEG
  -- Создан : 26.11.2013
  --
  -- Purpose : Пакет процедур обслуживающий функции интерфейса пользователей WEB
  --

  -- Private constant declarations
  g_body_version  constant varchar2(64)  := 'version 1.1 21/03/2018';
  g_awk_body_defs constant varchar2(512) := '';
  g_dbgcode constant varchar2(12) := 'bars_web_ui.';
  g_exclude_funcs_mask constant varchar2(1024) := '/barsroot/barsweb/welcome.aspx|/barsroot/|/barsroot/board/index/|/barsroot/messages/count/';

  --
  type t_funcstats_list is table of ui_func_stats_buff%rowtype;

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header bars_web_ui '||g_header_version||'.'||chr(10)
         ||'AWK definition: '||chr(10)
         ||g_awk_header_defs;
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body bars_web_ui '||g_body_version||'.'||chr(10)
         ||'AWK definition: '||chr(10)
         ||g_awk_body_defs;
  end body_version;

  --------------------------------------------------------------------------------
  -- select_function - процедура фиксации выбора функции в интерфейсе
  --
  -- @p_func_url - урл функции
  -- @p_user_data - информация о хосте
  --
  procedure select_function(
    p_func_url in varchar2,
    p_user_data in varchar2
  ) is
    pragma autonomous_transaction;
    l_th constant varchar2(100) := g_dbgcode || 'select_function';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_func_url = %s, p_from_url = %s', l_th, p_func_url);

    if instr(g_exclude_funcs_mask, p_func_url) = 0 then

      insert into ui_func_stats_buff(id, stat_date, staff_id, func_url, user_data)
        values (s_uifuncstats.nextval, sysdate, nvl(user_id,1), p_func_url, p_user_data );

    end if;

    commit;
    bars_audit.trace('%s: done', l_th);
  end select_function;

  --------------------------------------------------------------------------------
  -- store_buff - процедура обновления
  --
  --
  procedure store_buff(p_funcstats_list t_funcstats_list )
  is
    l_th constant varchar2(100) := g_dbgcode || 'store_buff';
    l_func_id operlist.codeoper%type;
    l_func_name operlist.funcname%type;
  begin
    bars_audit.trace('%s: entry point', l_th);

    for i in 1..p_funcstats_list.count
    loop

      l_func_name := substr(p_funcstats_list(i).func_url, 1,   instr(p_funcstats_list(i).func_url, '?') - 1  );

      if l_func_name is null then
        l_func_name := p_funcstats_list(i).func_url;
      end if;


      bars_audit.info('!--'||l_func_name);

      -- поиск id вызываемой функции
      begin

        select codeoper
         into l_func_id
         from operlist
        where funcname like l_func_name || '%'
          and bars_regexp.match('^' || replace(funcname, '?', '\?') || '$', p_funcstats_list(i).func_url ) = 1;

      exception
      when others then null;
      --TO DO нужно разобраться почему срет в аудит
       -- when no_data_found then
         -- bars_audit.error(l_th || ': не найден шаблон для функции - '||p_funcstats_list(i).func_url);
       -- when too_many_rows then
        --  bars_audit.error(l_th || ': найдено несколько шаблонов для функции - '||p_funcstats_list(i).func_url);
      end;

      insert into ui_func_stats(id, stat_date, staff_id, func_url, func_id, user_data)
        values(s_uifuncstats.nextval, p_funcstats_list(i).stat_date,
          p_funcstats_list(i).staff_id, p_funcstats_list(i).func_url, l_func_id, p_funcstats_list(i).user_data);

      if l_func_id is null then
        continue;
      end if;

      update ui_func_hits
          set hits = hits + 1, last_hit = p_funcstats_list(i).stat_date
        where staff_id = p_funcstats_list(i).staff_id
          and func_id = l_func_id;

      if sql%rowcount = 0 then

        insert into ui_func_hits(func_id, staff_id, hits, last_hit)
          values (l_func_id, p_funcstats_list(i).staff_id, 1, sysdate);

      end if;
    end loop;

    bars_audit.trace('%s: done', l_th);
  end store_buff;



  --------------------------------------------------------------------------------
  -- job_statfunc_buff - процедура переливки накопленных данных из буфера в основную таблицу
  --
  --
  procedure job_statfunc_buff is
    l_th constant varchar2(100) := g_dbgcode || 'select_function';
    l_ids t_funcstats_list;
  begin
    bars_audit.trace('%s: entry point', l_th);

    delete from ui_func_stats_buff purge
      returning id, stat_date, staff_id, func_url, user_data bulk collect into l_ids;

    store_buff(l_ids);

    bars_audit.trace('%s: done', l_th);
  end job_statfunc_buff;



  --------------------------------------------------------------------------------
  -- job_statfunc_clean - процедура очистки данных статистики пользователя за прошлый период
  --
  --
  procedure job_statfunc_clean(
    p_store_days_cnt integer
  ) is
    l_min_date date;
    l_store_date date;
    l_th constant varchar2(100) := g_dbgcode || 'job_statfunc_clean';
  begin
    bars_audit.trace('%s: entry point', l_th);

    -- дата первой записи в sec_audit
    select stat_date
      into l_min_date
      from ui_func_stats
     where id = (select min(id) from ui_func_stats);

    -- дата по которую нужно архивировать
    l_store_date := trunc( sysdate - p_store_days_cnt);

    if l_min_date >= l_store_date then
      return;
    end if;

    for c in (
      select l_min_date + rownum - 1 as part_date
        from dual
     connect by level < (l_store_date - l_min_date) + 1
    )
    loop

      begin

         -- удалить партицию
         execute immediate 'alter table ui_func_stats drop partition for (to_date('''||to_char(c.part_date,'dd.mm.yyyy')||''',''dd.mm.yyyy''))'||
                           ' update global indexes';

      exception when others then
        if sqlcode =-02149 then null; else raise; end if;
      end;

    end loop;

    bars_audit.trace('%s: done', l_th);
  end job_statfunc_clean;

begin
  -- Initialization
  null;
end bars_web_ui;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_web_ui.sql =========*** End ***
 PROMPT ===================================================================================== 
 