
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cim_sync.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CIM_SYNC 
is
   --
   --  Пакет для синхронізації довідників по модулю Валютний Контроль (CIM)
   --

   g_header_version    constant varchar2 (64) := 'version 1.00.01 17/07/2015';
   g_awk_header_defs   constant varchar2 (512) := '';

   --------------------------------------------------------------------------------
   -- Типи
   --

   --------------------------------------------------------------------------------
   -- Константи
   --
   --------------------------------------------------------------------------------
   -- Глобальні константи
   --

   --------------------------------------------------------------------------------
   -- Глобальні змінні
   --

   --------------------------------------------------------------------------------
   -- header_version - повертає версію заголовка пакету
   --
   function header_version return varchar2;

   --------------------------------------------------------------------------------
   -- body_version - повертає версію тіла пакету
   --
   function body_version return varchar2;

   --------------------------------------------------------------------------------
   -- f98_update - процедура оновлення таблиці санкцій мінекономіки
   --
   procedure f98_update(p_total_count out number,  p_upd_count out number, p_ins_count out number);

   --------------------------------------------------------------------------------
   -- sync_table - процедура синхронізації таблиці
   --
   procedure sync_table(p_table_name in varchar2, p_result out varchar2, p_total_count out number);

end cim_sync;
/
CREATE OR REPLACE PACKAGE BODY BARS.CIM_SYNC is
  --
  --  Пакет для синхронізації довідників по модулю Валютний Контроль (CIM)
  --

  g_body_version  constant varchar2(64) := 'version 1.00.01 17/07/2015';
  g_awk_body_defs constant varchar2(512) := '';

  --------------------------------------------------------------------------------
  -- Глобальні змінні
  --
  g_module_name  constant varchar2(3) := 'CIM';
  g_trace_module constant varchar2(10) := 'cim_sync.';

  -- маска формату для перетворення char <--> date
  g_date_format     constant varchar2(10) := 'dd.mm.yyyy';
  g_datetime_format constant varchar2(30) := 'dd.mm.yyyy HH24:MI:SS';

  g_sync_side   cim_params.par_value%type;
  g_sync_url    cim_params.par_value%type;
  g_wallet_dir  varchar2(64);
  g_wallet_pass varchar2(64);

  --------------------------------------------------------------------------------
  -- header_version - повертає версію заголовка пакету
  --
  function header_version return varchar2 is
  begin
    return 'Package header cim_sync ' || g_header_version || '.' || CHR(10) || 'AWK definition: ' || CHR(10) || g_awk_header_defs;
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - повертає версію тіла пакету
  --
  function body_version return varchar2 is
  begin
    return 'Package body cim_sync ' || g_body_version || '.' || CHR(10) || 'AWK definition: ' || CHR(10) || g_awk_body_defs;
  end body_version;

  --------------------------------------------------------------------------------
  -- extract_from_xml - отримати значення з xml
  --
  function extract_from_xml(p_xml in xmltype, p_xpath in varchar2, p_default in varchar2) return varchar2 is
  begin
    return p_xml.extract(p_xpath).getStringVal();
  exception
    when others then
      if sqlcode = -30625 then
        return p_default;
      else
        raise;
      end if;
  end extract_from_xml;

  --------------------------------------------------------------------------------
  -- get_table_map - побудова списку колонок для вичитки із xmltype представлення таблиці
  --
  function get_table_map(p_table_name in varchar2) return varchar2 is
    l_result varchar2(4000);
  begin
    for c in (SELECT * FROM user_tab_columns WHERE table_name = p_table_name ORDER BY column_id) loop
      case c.data_type
        when 'DATE' then
          l_result := l_result || ' ' || c.column_name || ' TIMESTAMP(6) WITH TIME ZONE PATH ''' || c.column_name || ''',' || CHR(13);
        when 'RAW' then
          l_result := l_result || ' ' || c.column_name || ' ' || c.data_type || '(' || c.data_length || ') PATH ''' || c.column_name || '_HEX'',' || CHR(13);
        else
          l_result := l_result || ' ' || c.column_name || ' ' || c.data_type || '(' || c.data_length || ') PATH ''' || c.column_name || ''',' || CHR(13);
      end case;
    end loop;
    return substr(l_result, 1, length(l_result) - 2);
  end get_table_map;

  --------------------------------------------------------------------------------
  -- get_table_cols_list - побудова списку колонок
  --
  function get_table_cols_list(p_table_name in varchar2, p_alias in varchar default null) return varchar2 is
    l_result varchar2(4000);
  begin
    for c in (SELECT column_name, nvl2(p_alias, p_alias || '.' , null) col_alias FROM user_tab_columns WHERE table_name = p_table_name ORDER BY column_id) loop
       l_result := l_result || c.col_alias || c.column_name || ',';
    end loop;
    return substr(l_result, 1, length(l_result) - 1);
  end get_table_cols_list;

  --------------------------------------------------------------------------------
  -- f98_update - процедура оновлення таблиці санкцій мінекономіки
  --
  procedure f98_update(p_total_count out number, p_upd_count out number, p_ins_count out number) is
    l_del_count number;
    l_recover_count number;
  begin
    -- заливка усіх данниз з dbf файлу
    insert /*+ append */ into cim_f98_tmp(np,dt,ek_pok,ko,mfo,nkb,ku,prb,k030,v_sank,ko_1,r1_1,r2_1,k020,datapod,nompod,djerpod,nakaz,datanak,nomnak,datpodsk,nompodsk,djerpods,datnaksk,nomnaksk,sanksia1,srsank11,srsank12,r4,r030,t071,k040,bankin,adrin,data_m)
    select np,dt,ek_pok,ko,mfo,nkb,ku,prb,k030,v_sank,ko_1,r1_1,r2_1,k020,datapod,nompod,djerpod,nakaz,datanak,nomnak,datpodsk,nompodsk,djerpods,datnaksk,nomnaksk,sanksia1,srsank11,srsank12,r4,r030,t071,k040,bankin,adrin,data_m from cim_f98_load
    where dt is not null;
    p_total_count := sql%rowcount; -- всього стрічок на обробку

    -- помічаємо видаленими стрічки в cim_f98, яких не виявилось в щойно завантаженому файлі
    update cim_f98
       set delete_date = sysdate
     where delete_date is null
       and line_hash not in (select line_hash from cim_f98_tmp);
    p_upd_count := sql%rowcount; -- помічених на видалення
    l_del_count := p_upd_count;

    -- відновлюємо стрічки в cim_f98, які були видалені, але прийшли в новому файлі
    update cim_f98
       set delete_date = null, modify_date = sysdate
     where delete_date is not null
       and line_hash in (select line_hash from cim_f98_tmp);
    l_recover_count := sql%rowcount;
    p_upd_count := p_upd_count + l_recover_count;

    -- вставка нових записів
    insert into cim_f98
      select * from cim_f98_tmp where line_hash not in (select line_hash from cim_f98);
    p_ins_count := sql%rowcount; -- вставка нових
    bars_audit.info(g_module_name||' Загрузка санкцій мінекономіки. total_count:'||p_total_count||' del_count:'||l_del_count||' recover_count:'||l_recover_count||' ins_count:'||p_ins_count);
  end f98_update;

  procedure exec_sync(p_table_name in varchar2) is
  begin
    execute immediate '
    MERGE INTO '|| p_table_name ||' c1
     USING (SELECT x.* FROM cim_sync_data t, XMLTABLE (''/DocumentElement/'|| p_table_name ||''' PASSING t.data_xml COLUMNS '|| get_table_map(p_table_name) ||') x where t.table_name='''|| p_table_name ||''') c2 ON (c1.line_hash = c2.line_hash)
    WHEN MATCHED THEN
       UPDATE SET c1.modify_date = c2.modify_date, c1.delete_date = c2.delete_date
    WHEN NOT MATCHED THEN
       INSERT ('|| get_table_cols_list(p_table_name) ||')
       VALUES ('|| get_table_cols_list(p_table_name, 'c2') ||')';
    update cim_sync_data set sync_date = sysdate where table_name = p_table_name;
  end;

  --------------------------------------------------------------------------------
  -- sync_table - процедура синхронізації таблиці
  --
  procedure sync_table(p_table_name in varchar2, p_result out varchar2, p_total_count out number) is
    l_trace varchar2(2000) := g_trace_module || 'sync_table::' ;
    l_request    soap_rpc.t_request;
    l_response   soap_rpc.t_response;
    l_start_date date := sysdate;
    l_clob       clob;
    l_clob_data  clob;
    l_xml_data   xmltype;
    l_error      varchar2(2000);
    l_str        varchar2(2000);
    l_status     number;
    l_tmp        xmltype;
    ret_         varchar2(256);
  begin
    logger.info(l_trace || ' p_table_name => ' || p_table_name || ', g_sync_side = ' || g_sync_side || ', g_sync_url = ' || g_sync_url);
    -- для SYNC_SIDE=1 (головний офіс) - синхронізація заборонена
    if g_sync_side = 1 then
      bars_error.raise_error(g_module_name, 102);
    end if;
    -- перевірка адреси сервісу
    if g_sync_url is null then
      bars_error.raise_error(g_module_name, 101);
    end if;

    -- запрос на вызов сервиса
    l_request := soap_rpc.new_request(p_url => g_sync_url, p_namespace => 'http://tempuri.org/', p_method => 'SyncTable', p_wallet_dir => g_wallet_dir, p_wallet_pass => g_wallet_pass);

    -- дата максимальної модифікації + 1 хв.
    select max(modify_date) + 1 / (24 * 60) into l_start_date from cim_f98;
    -- параметри
    soap_rpc.add_parameter(l_request, 'table_name', p_table_name);
    soap_rpc.add_parameter(l_request, 'start_date', to_char(l_start_date, g_datetime_format));
    logger.info(l_trace || ' l_start_date = ' || to_char(l_start_date, g_datetime_format));

    -- виклик сервісу
    l_response := soap_rpc.invoke(l_request);

    -- разбираем ответ
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);

    l_status := to_number(extract_from_xml(l_tmp, '/SyncTableResponse/SyncTableResult/Status/text()', null));
    l_error  := extract_from_xml(l_tmp, '/SyncTableResponse/SyncTableResult/ErrorMessage/text()', null);
    p_total_count := to_number(extract_from_xml(l_tmp, '/SyncTableResponse/SyncTableResult/RowsCount/text()', null));

    -- видаляемо попередні дані по синхронізації таблиці
    delete from cim_sync_data where table_name = p_table_name;
    -- вставка проміжних значень
    insert into cim_sync_data (table_name, data_clob, data_xml, error_message, rows_count) values (p_table_name, l_clob, l_xml_data, l_error, p_total_count);

    -- якщо без помилок і є данні
    if l_status = 0 and p_total_count > 0 then
      l_xml_data := l_tmp.extract('/SyncTableResponse/SyncTableResult/Data/DocumentElement');
      update cim_sync_data set data_xml = l_xml_data where table_name = p_table_name;
      logger.info(l_trace || ' start sync table ' || p_table_name || ', rows for merge - ' || p_total_count);
      exec_sync(p_table_name);


      logger.info(l_trace || ' finish sync table');

    end if;

    -- фіксуємо, для уникнення блокувань можливих
    commit;

    p_result := l_error;

  end sync_table;

begin
  -- Initialization
  begin
    select par_value into g_sync_side from cim_params where par_name = 'SYNC_SIDE';
  exception
    when no_data_found then
      bars_error.raise_error(g_module_name, 100);
  end;

  if g_sync_side = 0 then
    select max(par_value) into g_sync_url from cim_params where par_name = 'SERVICE_URL';
  end if;

  -- каталог oracle wallet для работы по https (пока берем те же что и для биржевых)
  begin
    select val into g_wallet_dir from birja where par = 'Wlt_dir';
    select val into g_wallet_pass from birja where par = 'Wlt_pass';
  exception
    when no_data_found then
      null; -- поки давимо
  end;

  bars_audit.set_module('CIM');
end cim_sync;
/
 show err;
 
PROMPT *** Create  grants  CIM_SYNC ***
grant EXECUTE                                                                on CIM_SYNC        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CIM_SYNC        to CIM_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cim_sync.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 