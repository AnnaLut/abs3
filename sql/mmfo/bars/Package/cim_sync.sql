
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cim_sync.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE cim_sync
is
   --
   --  ����� ��� ������������ �������� �� ������ �������� �������� (CIM)
   --

   g_header_version    constant varchar2 (64) := 'version 1.00.02 19/03/2018';
   g_awk_header_defs   constant varchar2 (512) := '';

   --------------------------------------------------------------------------------
   -- ����
   --

   --------------------------------------------------------------------------------
   -- ���������
   --
   --------------------------------------------------------------------------------
   -- �������� ���������
   --

   --------------------------------------------------------------------------------
   -- �������� ����
   --

   --------------------------------------------------------------------------------
   -- header_version - ������� ����� ��������� ������
   --
   function header_version return varchar2;

   --------------------------------------------------------------------------------
   -- body_version - ������� ����� ��� ������
   --
   function body_version return varchar2;

   function clean_string (p_string in varchar2) return varchar2;
   --------------------------------------------------------------------------------
   -- f98_update - ��������� ��������� ������� ������� ����������
   --
   procedure f98_update(p_total_count out number,  p_upd_count out number, p_ins_count out number);

   --------------------------------------------------------------------------------
   -- sync_table - ��������� ������������ �������
   --
   procedure sync_table(p_table_name in varchar2, p_result out varchar2, p_total_count out number);

end cim_sync;
/
CREATE OR REPLACE PACKAGE BODY cim_sync is
  --
  --  ����� ��� ������������ �������� �� ������ �������� �������� (CIM)
  --

  g_body_version  constant varchar2(64) := 'version 1.00.02 19/03/2018';
  g_awk_body_defs constant varchar2(512) := '';

  --------------------------------------------------------------------------------
  -- �������� ����
  --
  g_module_name  constant varchar2(3) := 'CIM';
  g_trace_module constant varchar2(10) := 'cim_sync.';

  -- ����� ������� ��� ������������ char <--> date
  g_date_format     constant varchar2(10) := 'dd.mm.yyyy';
  g_datetime_format constant varchar2(30) := 'dd.mm.yyyy HH24:MI:SS';

  g_sync_side   cim_params.par_value%type;
  g_sync_url    cim_params.par_value%type;
  g_wallet_dir  varchar2(64);
  g_wallet_pass varchar2(64);

  --------------------------------------------------------------------------------
  -- header_version - ������� ����� ��������� ������
  --
  function header_version return varchar2 is
  begin
    return 'Package header cim_sync ' || g_header_version || '.' || CHR(10) || 'AWK definition: ' || CHR(10) || g_awk_header_defs;
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - ������� ����� ��� ������
  --
  function body_version return varchar2 is
  begin
    return 'Package body cim_sync ' || g_body_version || '.' || CHR(10) || 'AWK definition: ' || CHR(10) || g_awk_body_defs;
  end body_version;

  function clean_string (p_string in varchar2)
  return varchar2
  is
--  invalid_ascii constant varchar2(254) :=
--    chr(00)||chr(01)||chr(02)||chr(03)||chr(04)||chr(05)||chr(06)||chr(07)||
--    chr(08)||chr(09)||chr(10)||chr(11)||chr(12)||chr(13)||chr(14)||chr(15)||
--    chr(16)||chr(17)||chr(18)||chr(19)||chr(20)||chr(21)||chr(22)||chr(23)||
--    chr(24)||chr(25)||chr(26)||chr(27)||chr(28)||chr(29)||chr(30)||chr(31);
  /*||chr(47)||chr(92)||chr(94)||chr(96)||'['||']'*/
  begin
--  return translate(translate(p_string,invalid_ascii,chr(1)),chr(0)||chr(1),' ');
    return replace(replace(replace(replace(replace(replace(replace(replace(replace(
           replace(replace(replace(replace(replace(replace(replace(replace(replace(
           replace(replace(replace(replace(replace(replace(replace(replace(replace(
           replace(replace(replace(replace(replace(p_string,
           chr(0)),  chr(1)),  chr(2)),  chr(3)),  chr(4)),  chr(5)),  chr(6)),  chr(7)),
           chr(8)),  chr(9)),  chr(10)), chr(11)), chr(12)), chr(13)), chr(14)), chr(15)),
           chr(16)), chr(17)), chr(18)), chr(19)), chr(20)), chr(21)), chr(22)), chr(23)),
           chr(24)), chr(25)), chr(26)), chr(27)), chr(28)), chr(29)), chr(30)), chr(31));
  end;

  --------------------------------------------------------------------------------
  -- extract_from_xml - �������� �������� � xml
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
  -- get_table_map - �������� ������ ������� ��� ������� �� xmltype ������������� �������
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
  -- get_table_cols_list - �������� ������ �������
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
  -- f98_update - ��������� ��������� ������� ������� ����������
  --
  procedure f98_update(p_total_count out number, p_upd_count out number, p_ins_count out number) is
    l_del_count number;
    l_recover_count number;
  begin
    -- ������� ��� ������ � dbf �����
    insert /*+ append */ into cim_f98_tmp(np,dt,ek_pok,ko,mfo,nkb,ku,prb,k030,v_sank,ko_1,r1_1,r2_1,k020,datapod,nompod,djerpod,nakaz,datanak,nomnak,datpodsk,nompodsk,djerpods,datnaksk,nomnaksk,sanksia1,srsank11,srsank12,r4,r030,t071,k040,bankin,adrin,data_m)
    select np,dt,ek_pok,ko,mfo,nkb,ku,prb,k030,v_sank,ko_1,clean_string(r1_1),clean_string(r2_1),k020,datapod,nompod,djerpod,nakaz,datanak,nomnak,datpodsk,nompodsk,djerpods,datnaksk,nomnaksk,sanksia1,srsank11,srsank12,clean_string(r4),r030,t071,k040,clean_string(bankin),clean_string(adrin),data_m from cim_f98_load
    where dt is not null;
    p_total_count := sql%rowcount; -- ������ ������ �� �������

    -- ������� ���������� ������ � cim_f98, ���� �� ��������� � ����� ������������� ����
    update cim_f98
       set delete_date = sysdate
     where delete_date is null
       and line_hash not in (select line_hash from cim_f98_tmp);
    p_upd_count := sql%rowcount; -- �������� �� ���������
    l_del_count := p_upd_count;

    -- ���������� ������ � cim_f98, �� ���� �������, ��� ������� � ������ ����
    update cim_f98
       set delete_date = null, modify_date = sysdate
     where delete_date is not null
       and line_hash in (select line_hash from cim_f98_tmp);
    l_recover_count := sql%rowcount;
    p_upd_count := p_upd_count + l_recover_count;

    -- ������� ����� ������
    insert into cim_f98
      select * from cim_f98_tmp where line_hash not in (select line_hash from cim_f98);
    p_ins_count := sql%rowcount; -- ������� �����
    bars_audit.info(g_module_name||' �������� ������� ����������. total_count:'||p_total_count||' del_count:'||l_del_count||' recover_count:'||l_recover_count||' ins_count:'||p_ins_count);
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
  -- sync_table - ��������� ������������ �������
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
    -- ��� SYNC_SIDE=1 (�������� ����) - ������������ ����������
    if g_sync_side = 1 then
      bars_error.raise_error(g_module_name, 102);
    end if;
    -- �������� ������ ������
    if g_sync_url is null then
      bars_error.raise_error(g_module_name, 101);
    end if;

    -- ������ �� ����� �������
    l_request := soap_rpc.new_request(p_url => g_sync_url, p_namespace => 'http://tempuri.org/', p_method => 'SyncTable', p_wallet_dir => g_wallet_dir, p_wallet_pass => g_wallet_pass);

    -- ���� ����������� ����������� + 1 ��.
    select max(modify_date) + 1 / (24 * 60) into l_start_date from cim_f98;
    -- ���������
    soap_rpc.add_parameter(l_request, 'table_name', p_table_name);
    soap_rpc.add_parameter(l_request, 'start_date', to_char(l_start_date, g_datetime_format));
    logger.info(l_trace || ' l_start_date = ' || to_char(l_start_date, g_datetime_format));

    -- ������ ������
    l_response := soap_rpc.invoke(l_request);

    -- ��������� �����
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);

    l_status := to_number(extract_from_xml(l_tmp, '/SyncTableResponse/SyncTableResult/Status/text()', null));
    l_error  := extract_from_xml(l_tmp, '/SyncTableResponse/SyncTableResult/ErrorMessage/text()', null);
    p_total_count := to_number(extract_from_xml(l_tmp, '/SyncTableResponse/SyncTableResult/RowsCount/text()', null));

    -- ��������� �������� ��� �� ������������ �������
    delete from cim_sync_data where table_name = p_table_name;
    -- ������� �������� �������
    insert into cim_sync_data (table_name, data_clob, data_xml, error_message, rows_count) values (p_table_name, l_clob, l_xml_data, l_error, p_total_count);

    -- ���� ��� ������� � � ����
    if l_status = 0 and p_total_count > 0 then
      l_xml_data := l_tmp.extract('/SyncTableResponse/SyncTableResult/Data/DocumentElement');
      update cim_sync_data set data_xml = l_xml_data where table_name = p_table_name;
      logger.info(l_trace || ' start sync table ' || p_table_name || ', rows for merge - ' || p_total_count);
      exec_sync(p_table_name);


      logger.info(l_trace || ' finish sync table');

    end if;

    -- �������, ��� ��������� ��������� ��������
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

  -- ������� oracle wallet ��� ������ �� https (���� ����� �� �� ��� � ��� ��������)
  begin
    select val into g_wallet_dir from birja where par = 'Wlt_dir';
    select val into g_wallet_pass from birja where par = 'Wlt_pass';
  exception
    when no_data_found then
      null; -- ���� ������
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
 