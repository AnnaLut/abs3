CREATE OR REPLACE PACKAGE BARS.rs is

  /******************************************************************************
     ��������:   RS
     ����������: �������� ����� �������� ��� ������������ ������� .NET
  ******************************************************************************/

  g_header_version constant varchar2(64) := 'version 2.5 01/07/2014';

  -- ������� �������� ����������� � ��������� ������ � ���
  g_job_prt_err_timeout constant number := 3600;
  -- ������� �������� ���������� ������ � ���
  g_job_done_timeout constant number := 86400;
  -- ��� ����� �������� (1 hour)
  g_part_done_timeout constant number := 86400;
  -- ������� ������ ����� � ���.
  function g_job_timeout return number;

  /**
  * header_version - ���������� ������ ��������� ������
  */
  function header_version return varchar2;

  /**
  * body_version - ���������� ������ ���� ������
  */
  function body_version return varchar2;

  -- ��. ������� ����� ��� ������� � ������������� �������
  current_session_id number;

  -- ���������� �������� ������ �� �������� ����������
  function generate_key_params(p_xml_params in varchar2) return varchar2;

  -- ������������� ������ ������
  procedure set_status(p_query_id  in cbirep_query_statuses_history.query_id%type,
                       p_status_id in cbirep_query_statuses_history.status_id%type,
                       p_comm      in cbirep_query_statuses_history.comm%type default null);

  -- ������� ������ �� ������������ ������
  function create_report_query(p_rep_id     in reports.id%type,
                               p_xml_params in varchar2)
    return cbirep_queries.id%type;

  -- ��������� ������ �� ������������ ������
  procedure exec_report_query(p_query_id in cbirep_queries.id%type);

  -- ������ ������ ������
  procedure clear_report_query(p_query_id in cbirep_queries.id%type);

  -- ������ ������ ������������������� ������� �� ��������� �������
  procedure clean_tmp_data;

  -- ������� ��������
  procedure clean_partitions;

  -- ���� ����� �� ������������ �������� ������ ������������
  procedure job_timeout_monitor;

  --�������� ���� ���� � ����
  procedure set_report_file(p_queries_id in CBIREP_QUERIES_DATA.QUERIES_ID%type,
                            p_file_data in CBIREP_QUERIES_DATA.FILE_DATA%type,
                            p_file_type in CBIREP_QUERIES_DATA.FILE_TYPE%type);
end;
/

CREATE OR REPLACE PACKAGE BODY BARS.rs as

  g_body_version constant varchar2(64) := 'version 2.5 22/03/2013';
  modcode        constant varchar2(3) := 'OTC';

  -- ������� ������ ����� � ���.
  function g_job_timeout return number is
    l_val number;
  begin
    select nvl(to_number(min(pg.value)), 1800)
      into l_val
      from cbirep_params pg
     where pg.name = 'CBIREP_JOB_TIMEOUT';

    return(l_val);
  end g_job_timeout;

  /**
  * header_version - ���������� ������ ��������� ������
  */
  function header_version return varchar2 is
  begin
    return 'Package header rs ' || G_HEADER_VERSION;
  end header_version;

  /**
  * body_version - ���������� ������ ���� ������
  */
  function body_version return varchar2 is
  begin
    return 'Package body rs ' || G_BODY_VERSION;
  end body_version;

  -- ���������� �������� ������ �� �������� ����������
  function generate_key_params(p_xml_params in varchar2) return varchar2 is
    l_xmlParser  xmlparser.Parser;
    l_xmlDoc     xmldom.DOMDocument;
    l_xmlNodes   xmldom.DOMNodeList;
    l_xmlNode    xmldom.DOMNode;
    l_xmlElement xmldom.DOMElement;

    l_par_id    varchar2(100);
    l_par_value varchar2(1024);

    l_returnValue varchar2(4000) := 'none';
  begin
    -- ������ ��������
    l_xmlParser := xmlparser.newParser;
    xmlparser.parseBuffer(l_xmlParser, p_xml_params);

    begin
      l_xmlDoc := xmlparser.getDocument(l_xmlParser);

      -- ������� ���� ����������
      l_xmlNodes := xmldom.getElementsByTagName(l_xmlDoc, 'Param');
      for node_index in 0 .. xmldom.getLength(l_xmlNodes) - 1 loop
        -- ����� �������� ������� ���������
        l_xmlNode    := xmldom.item(l_xmlNodes, node_index);
        l_xmlElement := xmldom.makeElement(l_xmlNode);

        -- ������ ����������
        l_par_id    := xmldom.getAttribute(l_xmlElement, 'ID');
        l_par_value := xmldom.getAttribute(l_xmlElement, 'Value');

        l_returnValue := l_returnValue || upper(l_par_id) || ':' ||
                         upper(l_par_value) || ';';
      end loop;

      xmlparser.freeParser(l_xmlParser);
      xmldom.freeDocument(l_xmlDoc);
    exception
      when others then
        xmlparser.freeParser(l_xmlParser);
        xmldom.freeDocument(l_xmlDoc);
        raise;
    end;

    return chk.to_hex(l_returnValue);
  end generate_key_params;

  -- ������������� ������ ������
  procedure set_status(p_query_id  in cbirep_query_statuses_history.query_id%type,
                       p_status_id in cbirep_query_statuses_history.status_id%type,
                       p_comm      in cbirep_query_statuses_history.comm%type default null) is
    l_cnt number;
  begin
    select count(*)
      into l_cnt
      from cbirep_queries cq
     where cq.id = p_query_id
       and cq.status_id = p_status_id;

    if l_cnt = 0 then
      -- �������
      insert into cbirep_query_statuses_history
        (id,
         query_id,
         userid,
         rep_id,
         key_params,
         status_id,
         set_time,
         comm)
        select s_cbirep_query_sts_hist.nextval,
               cq.id,
               cq.userid,
               cq.rep_id,
               cq.key_params,
               p_status_id,
               sysdate,
               p_comm
          from cbirep_queries cq
         where cq.id = p_query_id;

      -- ������ ������� ������
      update cbirep_queries cq
         set cq.status_id = p_status_id, cq.status_date = sysdate
       where cq.id = p_query_id;
    end if;

  end set_status;

  -- ������� ������ �� ������������ ������
  function create_report_query(p_rep_id     in reports.id%type,
                               p_xml_params in varchar2)
    return cbirep_queries.id%type is
    l_query_id       cbirep_queries.id%type;
    l_key_params     cbirep_queries.key_params%type := generate_key_params(p_xml_params);
    l_current_branch branch.branch%type := sys_context('bars_context',
                                                       'user_branch');
  begin
    begin
      select s_cbirep_cbirep_queries.nextval into l_query_id from dual;
      insert into cbirep_queries
        (id,
         branch,
         userid,
         rep_id,
         key_params,
         xml_params,
         status_id,
         status_date)
        select l_query_id,
               nvl(l_current_branch, tobopack.gettobo),
               user_id,
               p_rep_id,
               l_key_params,
               p_xml_params,
               'START',
               sysdate
          from dual;
    exception
      when dup_val_on_index then
        -- ��������� ������������ ������ ���������
        bars_error.raise_error(modcode, 5);
    end;

    -- ��������� �������
    set_status(l_query_id, 'START');

    -- �������� job
    savepoint before_job_start;
    declare
      l_job_id   number;
      l_job_what varchar2(4000) := 'rs.exec_report_query(' || l_query_id || ');';
    begin

      dbms_job.submit(job       => l_job_id,
                      what      => l_job_what,
                      next_date => sysdate,
                      interval  => null,
                      no_parse  => true);

      update cbirep_queries cq
         set cq.job_id = l_job_id
       where cq.id = l_query_id;

    exception
      when others then
        rollback to savepoint before_job_start;
        -- ��������� ������
        set_status(l_query_id,
                   'ERROR',
                   substr(sqlerrm || chr(10) ||
                          dbms_utility.format_call_stack(),
                          0,
                          4000));
    end;

    return l_query_id;
  end create_report_query;

  -- �������� ����������
  function bind_variables(p_sql_text in varchar2, p_xml_params in varchar2)
    return varchar2 is
    l_xmlParser  xmlparser.Parser;
    l_xmlDoc     xmldom.DOMDocument;
    l_xmlNodes   xmldom.DOMNodeList;
    l_xmlNode    xmldom.DOMNode;
    l_xmlElement xmldom.DOMElement;

    l_par_id    varchar2(100);
    l_par_value varchar2(1024);

    l_sql_text varchar2(32000);
  begin
    l_sql_text := p_sql_text;

    -- ������ ��������
    l_xmlParser := xmlparser.newParser;
    begin
      xmlparser.parseBuffer(l_xmlParser, p_xml_params);
      l_xmlDoc := xmlparser.getDocument(l_xmlParser);

      -- ������� ���� ����������
      l_xmlNodes := xmldom.getElementsByTagName(l_xmlDoc, 'Param');
      for node_index in 0 .. xmldom.getLength(l_xmlNodes) - 1 loop
        -- ����� �������� ������� ���������
        l_xmlNode    := xmldom.item(l_xmlNodes, node_index);
        l_xmlElement := xmldom.makeElement(l_xmlNode);

        -- ������ ����������
        l_par_id    := xmldom.getAttribute(l_xmlElement, 'ID');
        l_par_value := xmldom.getAttribute(l_xmlElement, 'Value');
        l_sql_text  := replace(l_sql_text,
                               l_par_id,
                               '''' || replace(l_par_value, '''', '''''') || '''');

      end loop;

      xmlparser.freeParser(l_xmlParser);
      xmldom.freeDocument(l_xmlDoc);
    exception
      when others then
        xmlparser.freeParser(l_xmlParser);
        xmldom.freeDocument(l_xmlDoc);

        raise_application_error(-20000,
                                substr(sqlerrm || chr(10) ||
                                       dbms_utility.format_call_stack(),
                                       0,
                                       4000),
                                true);
    end;

    return l_sql_text;
  end bind_variables;

  -- ��������� �������� ����������
  function get_variable(p_var_name in varchar2, p_xml_params in varchar2)
    return varchar2 is
    l_xmlParser  xmlparser.Parser;
    l_xmlDoc     xmldom.DOMDocument;
    l_xmlNodes   xmldom.DOMNodeList;
    l_xmlNode    xmldom.DOMNode;
    l_xmlElement xmldom.DOMElement;

    l_par_id    varchar2(100);
    l_par_value varchar2(1024);
  begin
    l_xmlParser := xmlparser.newParser;
    -- ������ ��������
    begin
      xmlparser.parseBuffer(l_xmlParser, p_xml_params);
      l_xmlDoc := xmlparser.getDocument(l_xmlParser);

      -- ������� ���� ����������
      l_xmlNodes := xmldom.getElementsByTagName(l_xmlDoc, 'Param');
      for node_index in 0 .. xmldom.getLength(l_xmlNodes) - 1 loop
        -- ����� �������� ������� ���������
        l_xmlNode    := xmldom.item(l_xmlNodes, node_index);
        l_xmlElement := xmldom.makeElement(l_xmlNode);

        -- ������ ����������
        l_par_id    := xmldom.getAttribute(l_xmlElement, 'ID');
        l_par_value := xmldom.getAttribute(l_xmlElement, 'Value');

        if (l_par_id = p_var_name) then
          xmlparser.freeParser(l_xmlParser);
          return l_par_value;
        end if;
      end loop;

      xmlparser.freeParser(l_xmlParser);
      xmldom.freeDocument(l_xmlDoc);
    exception
      when others then
        xmlparser.freeParser(l_xmlParser);
        xmldom.freeDocument(l_xmlDoc);

        raise_application_error(-20000,
                                substr(sqlerrm || chr(10) ||
                                       dbms_utility.format_call_stack(),
                                       0,
                                       4000),
                                true);
    end;

    return null;
  end get_variable;

  -- ��������� ������ �� ������������ ������
  procedure exec_report_query(p_query_id in cbirep_queries.id%type) is
    l_cq_row    cbirep_queries%rowtype;
    l_repparams v_cbirep_repparams%rowtype;

    l_session_id rs_tmp_session_data.session_id%type;

    c number;
    d number;

    l_col_cnt  number;
    l_col_desc dbms_sql.desc_tab;

    l_ins_prefix varchar2(2000);
    l_int_sql    varchar2(4000);

    --���� ��� ������ � ����
    l_request soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_request_url PARAMS$GLOBAL.VAL%type;
    l_wallet_dir  web_barsconfig.val%type;
    l_wallet_pass web_barsconfig.val%type;
    l_rescode number;
    l_resmsg varchar2(512);
    G_WSPROXY_URL_TAG constant varchar2(22) := 'REPORT_SERVER_URL';
    G_WALLET_DIR_TAG constant varchar2(22) := 'SMPP.Wallet_dir';
    G_WALLET_PASS_TAG constant varchar2(22) := 'SMPP.Wallet_pass';
    G_WSPROXY_NS_TAG constant varchar2(22) := 'PROXY_WS_NS';
    G_WSPROXY_METHOD constant varchar2(22) := 'GenerateReport';
    G_WSPROXY_QUERYID_PARAM  constant varchar2(22) := 'queryId';
    G_WSPROXY_USERNAME_PARAM  constant varchar2(100) := 'userName';
    G_WSPROXY_USERID_PARAM  constant varchar2(22) := 'userId';
    G_RES_OK constant number := 0;
    G_RES_ERR constant number := -1;
    G_RES_OK_MSG constant varchar2(2) := 'OK';

    -- COBUMMFO-9690 Begin
    l_module      varchar2(64);
    l_action      varchar2(64);
    -- COBUMMFO-9690 End
    
    -- ��������� ������ �������
    function col_no(p_no number) return varchar2 is
    begin
      return substr('00' || p_no, -2, 2);
    end;
    -- ���������� ��������� �� ������� � ������� �� ������������� �������
    procedure build_stmts is
      l_i           number;
      l_i_n         number default 0;
      l_i_d         number default 0;
      l_i_c         number default 0;
      l_into_clause varchar2(2000) := '';
      l_select_list varchar2(2000) := '';

      type_number integer default 2;
      type_date   integer default 12;

    begin
      l_i := l_col_desc.first;

      if (l_i is not null) then
        loop
          if length(l_into_clause) > 0 then
            l_into_clause := l_into_clause || ', ';
          end if;
          if length(l_select_list) > 0 then
            l_select_list := l_select_list || ', ';
          end if;

          if l_col_desc(l_i).col_type = type_number then
            l_into_clause := l_into_clause || 'NUM' || col_no(l_i_n);
            l_select_list := l_select_list || 'NUM' || col_no(l_i_n) || ' ' || l_col_desc(l_i)
                            .col_name;
            l_i_n         := l_i_n + 1;
          elsif l_col_desc(l_i).col_type = type_date then
            l_into_clause := l_into_clause || 'DAT' || col_no(l_i_d);
            l_select_list := l_select_list || 'DAT' || col_no(l_i_d) || ' ' || l_col_desc(l_i)
                            .col_name;
            l_i_d         := l_i_d + 1;
          else
            l_into_clause := l_into_clause || 'CHAR' || col_no(l_i_c);
            l_select_list := l_select_list || 'CHAR' || col_no(l_i_c) || ' ' || l_col_desc(l_i)
                            .col_name;
            l_i_c         := l_i_c + 1;
          end if;

          l_i := l_col_desc.next(l_i);
          exit when(l_i is null);
        end loop;
      end if;

      l_ins_prefix := 'insert into rs_tmp_report_data (' || l_into_clause || ') ';
      l_int_sql    := 'select ' || l_select_list ||
                      ' from rs_tmp_report_data where session_id=:SESSION_ID order by id';
    end build_stmts;

  begin
    -- COBUMMFO-9690 Begin
    dbms_application_info.read_module( l_module, l_action);
    dbms_application_info.set_module( 'REPORT', 'EXECUTE');
    -- COBUMMFO-9690 End
    
    -- ��������� ������
    begin
      select cq.*
        into l_cq_row
        from cbirep_queries cq
       where cq.id = p_query_id;
    exception
      when no_data_found then
        -- '������ �� ������: ' || ID_ || SQLERRM
        bars_error.raise_error(modcode, 1, to_char(p_query_id), sqlerrm);
    end;

    -- �������������� �������������
    bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                          p_userid    => l_cq_row.userid,
                          p_hostname  => null,
                          p_appname   => 'BARSWEB_JOBS');

    -- �������������� �������, ���� ������������ ���� �������� � ��������������
    if (l_cq_row.branch != sys_context('bars_context', 'user_branch')) then
      bc.subst_branch(l_cq_row.branch);
    end if;

    -- �������� �������
    set_status(p_query_id, 'PROCESS');
    commit;

    begin
      -- ����� ������
      begin
        select *
          into l_repparams
          from v_cbirep_repparams cr
         where cr.rep_id = l_cq_row.rep_id;
      exception
        when no_data_found then
          -- '������ �� ������: ' || ID_ || SQLERRM
          bars_error.raise_error(modcode,
                                 1,
                                 to_char(l_cq_row.rep_id),
                                 sqlerrm);
      end;

      -- ������ ����
      execute_immediate('alter session set nls_date_format=''dd.MM.yyyy''');

      -- ������� ������
      select s_rs_session_id.nextval into current_session_id from dual;
      l_session_id := current_session_id;

      -- ��������� ������
      begin
        c := dbms_sql.open_cursor;

        -- ��������� ��������� ������������
        if (l_repparams.form_proc is not null) then
          dbms_sql.parse(c,
                         bind_variables('begin ' || l_repparams.form_proc ||
                                        '; end;',
                                        l_cq_row.xml_params),
                         dbms_sql.native);
          d := dbms_sql.execute(c);
        end if;

        -- ������ �������� SQL
        dbms_sql.parse(c,
                       bind_variables(l_repparams.txt, l_cq_row.xml_params),
                       dbms_sql.native);
        dbms_sql.describe_columns(c, l_col_cnt, l_col_desc);

        -- ���������� ��������� �� ������� � ������� �� ������������� �������
        build_stmts;
        dbms_sql.parse(c,
                       bind_variables(l_ins_prefix || ' ' ||
                                      l_repparams.txt,
                                      l_cq_row.xml_params),
                       dbms_sql.native);
        d := dbms_sql.execute(c);

        dbms_sql.close_cursor(c);
      exception
        when others then
          dbms_sql.close_cursor(c);
          raise_application_error(-20000,
                                  substr(sqlerrm || chr(10) ||
                                         dbms_utility.format_call_stack(),
                                         0,
                                         4000),
                                  true);
      end;

      declare
        sFdat1 date := get_variable(':sFdat1', l_cq_row.xml_params);
        sFdat2 date := get_variable(':sFdat2', l_cq_row.xml_params);
      begin
        insert into rs_tmp_session_data
          (session_id, query_id, int_sql, template, date1, date2)
        values
          (l_session_id,
           l_repparams.kodz,
           l_int_sql,
           l_repparams.rpt_template,
           to_date(sFdat1, 'dd.MM.yyyy'),
           to_date(sFdat2, 'dd.MM.yyyy'));

        update cbirep_queries cq
           set cq.session_id = l_session_id
         where cq.id = p_query_id;
      end;

      -- ��������� �������� ������
      for c_attr in (select upper(id) id, sql_text
                       from zapros_attr
                      where kodz is null
                         or (kodz is not null and kodz = l_repparams.kodz)
                      order by id) loop
        declare
          l_attr_value varchar2(254);
        begin

          if instr(upper(c_attr.sql_text), ':NKODZ') > 0 then
            execute immediate c_attr.sql_text
              into l_attr_value
              using l_repparams.kodz;
          else
            execute immediate c_attr.sql_text
              into l_attr_value;
          end if;

          if l_attr_value is not null then
            insert into rs_tmp_report_attr
              (session_id, attr_name, attr_value)
            values
              (l_session_id, c_attr.id, l_attr_value);
          end if;

        exception
          when no_data_found then
            null;
          when others then
            -- '������ ��� ��������� ��������� ' || C_ATTR.ID || SQLERRM
            bars_error.raise_error(modcode, 2, to_char(c_attr.id), sqlerrm);
        end;
      end loop;

      commit;

      -- ����� ������ ������-�������
      begin
        select val into l_request_url from params$global where par = G_WSPROXY_URL_TAG and rownum = 1;

        --������������ �� 3 �������
        --l_request_url := replace(l_request_url, '10.7.98.30', decode(mod(p_query_id, 3), 0, '10.7.98.11', 1, '10.7.98.15', 2, '10.7.98.21'));
        if mod(p_query_id, 3) = 0 then
            l_request_url := replace(l_request_url, '10.7.98.30', '10.7.98.11');
        end if;
        if mod(p_query_id, 3) = 1 then
            l_request_url := replace(l_request_url, '10.7.98.30', '10.7.98.15');
        end if;
        if mod(p_query_id, 3) = 2 then
            l_request_url := replace(l_request_url, '10.7.98.30', '10.7.98.21');
        end if;
        -- ������ ������������ �� 2 �������
        /*if mod(p_query_id, 2) = 0 then
            l_request_url := replace(l_request_url, '10.7.98.30', '10.7.98.11');
        else
            l_request_url := replace(l_request_url, '10.7.98.30', '10.7.98.21');
        end if;*/
        logger.info('RS:: p_query_id=' || p_query_id || ', l_request_url=' || l_request_url);

        select max(val) into l_wallet_dir from web_barsconfig where key = G_WALLET_DIR_TAG;
        select max(val) into l_wallet_pass from web_barsconfig where key = G_WALLET_PASS_TAG;
        -- ����������� �������
        l_request :=  soap_rpc.new_request(
          p_url => l_request_url,
          p_namespace => getglobaloption(G_WSPROXY_NS_TAG),
          p_method => G_WSPROXY_METHOD,
          p_wallet_dir => l_wallet_dir,
          p_wallet_pass => l_wallet_pass);
        -- �������� ���������
        soap_rpc.add_parameter(l_request, G_WSPROXY_QUERYID_PARAM, to_char(p_query_id));
        soap_rpc.add_parameter(l_request, G_WSPROXY_USERNAME_PARAM, BARS.USER_NAME);
        soap_rpc.add_parameter(l_request, G_WSPROXY_USERID_PARAM, to_char(BARS.USER_ID));
        -- ������� ����� ���-�������
        l_response := soap_rpc.invoke(l_request);
        -- ��
        l_rescode := G_RES_OK;
        l_resmsg := G_RES_OK_MSG;

      exception when others then
        l_rescode := substr(sqlcode, 1, 512);
        l_resmsg := sqlerrm;
        --������ �� ���������� �� ����
        bars_audit.error('Error create file on webserver: '|| l_resmsg );
        set_status(p_query_id, 'ERROR',substr('�� ������� ��������� ����� ���������� ����. ��''������ � �������������. [' || l_resmsg || ']', 1, 4000));
      end;
    exception
      when others then
        rollback;
        -- ��������� ������
        set_status(p_query_id,
                   'ERROR',
                   substr(sqlerrm || chr(10) ||
                          dbms_utility.format_call_stack(),
                          0,
                          4000));
    end;

    dbms_application_info.set_module( l_module, l_action); -- COBUMMFO-9690
  exception
     when others then
          dbms_application_info.set_module( l_module, l_action); -- COBUMMFO-9690
          raise;
  end exec_report_query;

  -- �������� ������ ������������������� ������� �� ��������� �������
  procedure clear_report_data(p_session_id in number) is
  begin
    --delete from rs_tmp_report_data where session_id = p_session_id;

    /*begin
        execute immediate 'alter table bars.rs_tmp_report_data drop partition for ('|| p_session_id || ')';
        exception
            --���� �������� �� ����
            when others then if ( sqlcode = -2149 or sqlcode = -14758) then null; else raise; end if;
    end;*/
    delete from rs_tmp_report_attr where session_id = p_session_id;
    delete from rs_tmp_session_data where session_id = p_session_id;
  end clear_report_data;

  -- �������� ������ ������������
  procedure clear_report_session(p_query_id in cbirep_queries.id%type) is
    l_cq_row  cbirep_queries%rowtype;
    l_dj_row  dba_jobs%rowtype;
    l_djr_row dba_jobs_running%rowtype;
  begin
    -- ��������� ������
    select cq.*
      into l_cq_row
      from cbirep_queries cq
     where cq.id = p_query_id;

    -- ������� ���� �� ����
    begin
      select dj.*
        into l_dj_row
        from dba_jobs dj
       where dj.job = l_cq_row.job_id;
    exception
      when no_data_found then
        return;
    end;

    -- ������� �������� �� ����
    begin
      select djr.*
        into l_djr_row
        from dba_jobs_running djr
       where djr.job = l_cq_row.job_id;
    exception
      when no_data_found then
        -- ������ ����
        dbms_job.broken(l_cq_row.job_id, true);
        commit;
        dbms_job.remove(l_cq_row.job_id);
        commit;
        return;
    end;

    -- ������� ���������� ���� � �������
    dbms_job.broken(l_cq_row.job_id, true);
    commit;
    declare
      l_s_row v$session%rowtype;
    begin
      select s.* into l_s_row from v$session s where s.sid = l_djr_row.sid;
      execute immediate 'alter system kill session ''' || l_s_row.sid || ',' ||
                        l_s_row.serial# || '''';
    exception
      when no_data_found then
        null;
    end;
    dbms_job.remove(l_cq_row.job_id);
    commit;

  exception
    when no_data_found then
      null;
  end clear_report_session;

  -- ������ ������ ������
  procedure clear_report_query(p_query_id in cbirep_queries.id%type) is
    l_cq_row cbirep_queries%rowtype;
  begin
    -- ��������� ������
    select cq.*
      into l_cq_row
      from cbirep_queries cq
     where cq.id = p_query_id;

    -- ���� ������ �������� �� ������������� ������
    clear_report_session(p_query_id);

    -- ������� ������
    delete from cbirep_queries_data cqd where CQD.QUERIES_ID = p_query_id;
    delete from cbirep_queries cq where cq.id = p_query_id;
    if (l_cq_row.session_id is not null) then
      clear_report_data(l_cq_row.session_id);
    end if;

  exception
    when no_data_found then
      null;
  end clear_report_query;

  -- ������ ������ ������������������� ������� �� ��������� �������
  procedure clean_tmp_data is
    l_cnt number := 0;
  begin
    -- ������������ � ��������� ������ + �����������
    for cur in (select *
                  from cbirep_queries cq
                 where (cq.status_id in ('PRINTED', 'ERROR') and
                       cq.status_date <
                       sysdate - g_job_prt_err_timeout / 60 / 60 / 24)
                    or (cq.status_id in ('DONE', 'STARTCREATEDFILE','CREATEDFILE') and
                       cq.status_date <
                       sysdate - g_job_done_timeout / 60 / 60 / 24)) loop
      clear_report_query(cur.id);
      l_cnt := l_cnt + 1;
      if (mod(l_cnt, 200) = 0) then
        commit;
      end if;
    end loop;
    commit;

    -- ���� ����������
    dbms_stats.gather_table_stats('BARS', 'CBIREP_QUERIES');
    dbms_stats.gather_table_stats('BARS', 'RS_TMP_REPORT_ATTR');
    dbms_stats.gather_table_stats('BARS', 'RS_TMP_SESSION_DATA');

  end clean_tmp_data;

  procedure clean_partitions is
  begin
    -- �������� �� ������ ����� ����������� ����
    for cur in (select * from v_rs_tmp_rep_data_part
                 where high_value_in_date_format < sysdate - g_part_done_timeout / 60 / 60 / 24) loop
      if cur.partition_name != 'P_FIRST' then
      begin
        execute immediate 'alter table bars.rs_tmp_report_data drop partition ' || cur.partition_name;
            exception
                --���� �������� �� ���� ��� �������
                when others then if ( sqlcode = -2149 or sqlcode = -14758) then null; else raise; end if;
         end;
      end if;
    end loop;
  end clean_partitions;

  -- ���� ����� �� ������������ �������� ������ ������������
  procedure job_timeout_monitor is
  begin
    -- ����� ������� �� ������������ ����������� �����
    for cur in (select *
                  from (select cq.*,
                               (sysdate - cq.creation_time) * 24 * 60 * 60 as dur_sec
                          from cbirep_queries cq
                         where cq.status_id = 'PROCESS')
                 where dur_sec > g_job_timeout) loop

      clear_report_session(cur.id);

      -- ��������� � ������ ������
      set_status(cur.id,
                 'ERROR',
                 '������� ���������� �����: ���������� ��� ���� ����������');
      commit;
    end loop;
  end job_timeout_monitor;

  --�������� ���� ���� � ����
  procedure set_report_file(p_queries_id in CBIREP_QUERIES_DATA.QUERIES_ID%type,
                            p_file_data in CBIREP_QUERIES_DATA.FILE_DATA%type,
                            p_file_type in CBIREP_QUERIES_DATA.FILE_TYPE%type) is
    l_sesion_id CBIREP_QUERIES.SESSION_ID%type;
  begin
    insert into CBIREP_QUERIES_DATA (QUERIES_ID, FILE_DATA,FILE_TYPE) values (p_queries_id,p_file_data,p_file_type);
    select Q.SESSION_ID into l_sesion_id from CBIREP_QUERIES q where Q.ID = p_queries_id;
    clear_report_data(l_sesion_id);
    set_status(p_queries_id,'CREATEDFILE','');
  end set_report_file;
end;

/

GRANT EXECUTE ON BARS.RS TO ABS_ADMIN;

GRANT EXECUTE ON BARS.RS TO BARS_ACCESS_DEFROLE;

GRANT EXECUTE ON BARS.RS TO RS;

GRANT EXECUTE ON BARS.RS TO WR_ALL_RIGHTS;

GRANT EXECUTE ON BARS.RS TO WR_CBIREP;
