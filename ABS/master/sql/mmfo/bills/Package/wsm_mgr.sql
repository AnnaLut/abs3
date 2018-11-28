
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/package/wsm_mgr.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BILLS.WSM_MGR is
  --------------------------------------------------------------------------------
  --  Author : sergey.gorobets
  --  Created : 09.02.2015
  --  Purpose: ����� ��� ������ � �������� ��������� (soap, rest) - Web Services Module
  --------------------------------------------------------------------------------

  g_header_version  constant varchar2(64) := 'version 1.1 12/06/2018'; -- ����������� ��� COBUVEKSEL
  g_awk_header_defs constant varchar2(512) := '';

  g_http_version constant varchar2(20) := 'HTTP/1.1';
  g_http_post    constant varchar2(20) := 'POST';
  g_http_get     constant varchar2(20) := 'GET';

  -- Content type
  g_ct_json constant varchar2(20) := 'application/json';
  g_ct_xml  constant varchar2(20) := 'text/xml';
  g_ct_html constant varchar2(20) := 'text/xml';
  -- Content charset
  g_cc_utf8    constant varchar2(20) := 'charset=utf-8';
  g_cc_win1251 constant varchar2(20) := 'charset=windows-1251';

  g_status_code pls_integer;

  -- ����� ���������� ��������� (0 - ���������, 1 - dbms_output, 2 - sec_audit (trace), 3 - ��� (1 � 2))
  g_trace_mode pls_integer := 1;

  --------------------------------------------------------------------------------
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

  --------------------------------------------------------------------------------
  -- types

  -- ������ header ����������
  type header is record(
    name  varchar2(256),
    value varchar2(1024));
  type header_table is table of header index by binary_integer;

  g_headers header_table;

  type t_parameter is record(
    p_param_name  varchar2(256),
    p_param_value clob,
    p_param_type  varchar2(256));

  type t_parameters is table of t_parameter index by binary_integer;

  g_parameters t_parameters;
  ----
  -- ������ �������
  --
  type t_request is record(
    url             varchar2(32767),
    action          varchar2(256),
    http_method     varchar2(10),
    content_type    varchar2(256),
    content_charset varchar2(256),
    wallet_path     varchar2(256),
    wallet_pwd      varchar2(256),
    body            clob,
    parameters      t_parameters);

  ----
  -- ������ ������
  --
  type t_response is record(
    xdoc xmltype,
    cdoc clob);

  --------------------------------------------------------------------------------
  -- �������� ������ � base64
  --
  function convert_to_base64(p_clob clob) return clob;
  --------------------------------------------------------------------------------
  -- ����������� ������ c base64
  --
  function convert_from_base64(par clob) return clob;
  ------------------------------------------------------------------------------
  -- URL-�������� ������
  --
  function url_encode(p_str in varchar2) return varchar2;
  ------------------------------------------------------------------------------
  -- ���������� URL-������������ ������
  --
  function url_decode(p_str in varchar2) return varchar2;
  --------------------------------------------------------------------------------
  -- �������� �����\���� � ACL ��� ������ � ��������
  --
  procedure set_acl_access(p_host in varchar2, p_port in integer);
  --------------------------------------------------------------------------------
  -- �������� \ �������� �������� � ���������� wsm_params
  --
  procedure set_param(p_param_name in wsm_params.par_name%type, p_value in wsm_params.par_value%type, p_comment in wsm_params.par_comment%type default null);
  --------------------------------------------------------------------------------
  -- ������������� \ ���������� �������
  --
  procedure prepare_request(p_url             in varchar2,
                            p_action          in varchar2,
                            p_http_method     in varchar2 default g_http_get,
                            p_content_type    in varchar2 default g_ct_json,
                            p_content_charset in varchar2 default g_cc_utf8,
                            p_wallet_path     in varchar2 default null,
                            p_wallet_pwd      in varchar2 default null,
                            p_body            in clob     default null);
  --------------------------------------------------------------------------------
  -- ��������� �������� � ������
  --
  procedure add_parameter(p_name in varchar2, p_value in clob, p_type in varchar2 default 'string');
  --------------------------------------------------------------------------------
  -- ����� �������������� �������
  --
  procedure execute_request(p_response out t_response);
  --------------------------------------------------------------------------------
  --  ��������� ������
  --
  function test_service(p_echo clob, p_http_method in varchar2 default 'POST') return varchar2;
  --------------------------------------------------------------------------------
  --  ��������� �����
  --
  function sign_buffer(p_buffer clob) return varchar2;
  --------------------------------------------------------------------------------
  --  ��������� �������  �����
  --
  procedure verify_sign(p_buffer clob, p_sign_buffer in clob, p_signs_count out number);

end wsm_mgr;

/
CREATE OR REPLACE PACKAGE BODY BILLS.WSM_MGR is
  ------------------------------------------------------------------------------
  --  Author : sergey.gorobets
  --  Created : 09.02.2015
  --  Purpose: ����� ��� ������ � �������� ��������� (soap, rest) - Web Services Module
  ------------------------------------------------------------------------------

  -- Private constant declarations
  g_body_version  constant varchar2(64) := 'version 1.1 12/06/2018'; -- ����������� ��� COBUVEKSEL
  g_awk_body_defs constant varchar2(512) := '';

  g_service_url varchar2(256);

  g_request  t_request;
  g_response t_response;

  ------------------------------------------------------------------------------
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2 is
  begin
    return 'Package header service_mgr ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_header_defs;
  end header_version;
  ------------------------------------------------------------------------------
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2 is
  begin
    return 'Package body service_mgr ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_body_defs;
  end body_version;
  --------------------------------------------------------------------------------
  -- �������� \ �������� �������� � ���������� wsm_params
  --
  procedure set_param(p_param_name in wsm_params.par_name%type, p_value in wsm_params.par_value%type, p_comment in wsm_params.par_comment%type default null) as
  begin
    update wsm_params set par_value = p_value, par_comment = nvl(p_comment, par_comment) where par_name = p_param_name;
    if sql%rowcount = 0 then
      insert into wsm_params (par_name, par_value, par_comment) values (p_param_name, p_value, p_comment);
    end if;
    commit;
  end;

  function to_base64(t in varchar2) return varchar2 is
  begin
    return utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(t)));
  end to_base64;

  function from_base64(t in varchar2) return varchar2 is
  begin
    return utl_raw.cast_to_varchar2(utl_encode.base64_decode(utl_raw.cast_to_raw(t)));
  end from_base64;

  ------------------------------------------------------------------------------
  -- �������� ������ � base64
  --
  function convert_to_base64(p_clob clob) return clob is
    l_clob clob;
    l_step pls_integer := 12000; -- make sure you set a multiple of 3 not higher than 24573
  begin
    for i in 0 .. trunc((dbms_lob.getlength(p_clob) - 1) / l_step) loop
      l_clob := l_clob || utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(dbms_lob.substr(p_clob, l_step, i * l_step + 1))));
    end loop;
    return replace(l_clob, chr(13) || chr(10), '');
  end;

  ------------------------------------------------------------------------------
  -- ����������� ������ c base64
  --
  function convert_from_base64(par clob) return clob is
  begin
    return utl_encode.text_decode(par, encoding => utl_encode.base64);
  end;
  ------------------------------------------------------------------------------
  -- URL-�������� ������
  --
  function url_encode(p_str in varchar2) return varchar2 is
    l_tmp  varchar2(6000);
    l_hex  varchar2(16) default '0123456789ABCDEF';
    l_num  number;
    l_bad  varchar2(100) default ' >%}\~];?@&<#{|^[`/:=$+''"';
    l_char char(1);
  begin
    if p_str is null then
      return null;
    end if;
    for i in 1 .. length(p_str) loop
      l_char := substr(p_str, i, 1);
      if instr(l_bad, l_char) > 0 then
        l_num := ascii(l_char);
        l_tmp := l_tmp || '%' || substr(l_hex, mod(trunc(l_num / 16), 16) + 1, 1) || substr(l_hex, mod(l_num, 16) + 1, 1);
      else
        l_tmp := l_tmp || l_char;
      end if;
    end loop;
    return l_tmp;
  end url_encode;
  ------------------------------------------------------------------------------
  -- ���������� URL-������������ ������
  --
  function url_decode(p_str in varchar2) return varchar2 is
    l_hex varchar2(16) := '0123456789ABCDEF';
    l_idx number := 0;
    l_ret long := p_str;
  begin
    if p_str is null then
      return p_str;
    end if;
    loop
      l_idx := instr(l_ret, '%', l_idx + 1);
      exit when l_idx = 0;
      l_ret := substr(l_ret, 1, l_idx - 1) || chr((instr(l_hex, substr(l_ret, l_idx + 1, 1)) - 1) * 16 + instr(l_hex, substr(l_ret, l_idx + 2, 1)) - 1) || substr(l_ret, l_idx + 3);
    end loop;
    return l_ret;
  end url_decode;
  ------------------------------------------------------------------------------
  -- �������� �����\���� � ACL ��� ������ � ��������
  --
  procedure set_acl_access(p_host in varchar2, p_port in integer) as
    l_path varchar2(4000 byte);
  begin
    begin
      select any_path into l_path from resource_view where any_path like '/sys/acls/bars_acl.xml';
    exception
      when no_data_found then
        execute immediate 'begin dbms_network_acl_admin.create_acl (
                            acl             => ''bars_acl.xml'',
                            description     => ''ACL for user BARS(UNITY-BARS Ltd)'',
                            principal       => ''' || user || ''',
                            is_grant        => TRUE,
                            privilege       => ''connect'',
                            start_date      => null,
                            end_date        => null); end;';

        execute immediate 'begin dbms_network_acl_admin.add_privilege (
                            acl       => ''bars_acl.xml'',
                            principal  => ''' || user || ''',
                            is_grant      => TRUE,
                            privilege   => ''connect'',
                            start_date  => null,
                            end_date    => null); end;';
    end;

    execute immediate 'begin sys.DBMS_NETWORK_ACL_ADMIN.assign_acl(acl => ''bars_acl.xml'',
                        host        => :p_host,
                        lower_port  => :p_port,
                        upper_port  => :p_port); end;'
      using p_host, p_port;

    commit;
  end;
  ------------------------------------------------------------------------------
  -- ���������� ���������
  --
  procedure trace_info(p_message in varchar2) as
  begin
    case g_trace_mode
      when 1 then
        dbms_output.put_line(p_message);
      when 2 then
        null;--bars.logger.trace(p_message);
      when 3 then
        dbms_output.put_line(p_message);
        --bars.logger.trace(p_message);
      else
        null;
    end case;
  end;
  ------------------------------------------------------------------------------
  -- ����������� clob � varchar2 (����� �� ������ wwv_flow_utilities.clob_to_varchar2)
  --
  function clob_to_varchar2(p_clob in clob, p_offset in number default 0, p_raise in boolean default false) return varchar2 is
    l_return_val varchar2(32767) := null;
    l_buf        varchar2(32767) := null;
    l_pos        number;
    l_length     number;
  begin
    l_length := nvl(dbms_lob.getlength(p_clob), 0);
    if l_length > 0 + p_offset then
      l_pos        := 1 + p_offset;
      l_buf        := dbms_lob.substr(p_clob, 8191, l_pos);
      l_return_val := l_buf;

      if l_length > 8191 + p_offset then
        l_pos        := 8192 + p_offset;
        l_buf        := dbms_lob.substr(p_clob, 8191, l_pos);
        l_return_val := l_return_val || l_buf;

        if l_length > 16382 + p_offset then
          l_pos        := 16383 + p_offset;
          l_buf        := dbms_lob.substr(p_clob, 8191, l_pos);
          l_return_val := l_return_val || l_buf;

          if l_length > 24573 + p_offset then
            l_pos        := 24574 + p_offset;
            l_buf        := dbms_lob.substr(p_clob, 8191, l_pos);
            l_return_val := l_return_val || l_buf;

            if l_length > 32764 + p_offset then
              l_pos        := 32765 + p_offset;
              l_buf        := dbms_lob.substr(p_clob, 3, l_pos);
              l_return_val := l_return_val || l_buf;
            end if;
          end if;
        end if;
      end if;
    end if;
    return l_return_val;
  exception
    when others then
      if sqlcode = -6502 and p_raise = false then
        for i in reverse 1 .. length(l_buf) loop
          if lengthb(l_return_val) + lengthb(substr(l_buf, 1, i)) <= 32767 then
            l_return_val := l_return_val || substr(l_buf, 1, i);
            exit;
          end if;
        end loop;
        return l_return_val;
      else
        raise;
      end if;
  end clob_to_varchar2;
  ------------------------------------------------------------------------------
  -- ������������� \ ���������� �������
  --
  procedure prepare_request(p_url             in varchar2,
                            p_action          in varchar2,
                            p_http_method     in varchar2 default g_http_get,
                            p_content_type    in varchar2 default g_ct_json,
                            p_content_charset in varchar2 default g_cc_utf8,
                            p_wallet_path     in varchar2 default null,
                            p_wallet_pwd      in varchar2 default null,
                            p_body            in clob     default null) as
  begin
    -- ��������� ��� ��� SSL ���������� ������� ��������� wallet
    if (instr(lower(g_request.url), 'https') = 1 and (p_wallet_path is null or p_wallet_pwd is null)) then
      raise_application_error(-20001, '��� SSL �`������� ��������� ������� ��������� Wallet', false);
    end if;

    g_request.url             := p_url;
    g_request.action          := p_action;
    g_request.http_method     := p_http_method;
    g_request.content_type    := p_content_type;
    g_request.content_charset := p_content_charset;
    g_request.wallet_path     := p_wallet_path;
    g_request.wallet_pwd      := p_wallet_pwd;
    g_request.body            := p_body;
    g_request.parameters      := g_parameters;
    if g_request.body  is null then
      dbms_lob.createtemporary(g_request.body,false);
    end if;
  end;
  --------------------------------------------------------------------------------
  -- ��������� �������� � ������
  --
  procedure add_parameter(p_name in varchar2, p_value in clob, p_type in varchar2 default 'string') as
    l_parameter t_parameter;
  begin
    l_parameter.p_param_name := p_name;
    l_parameter.p_param_value := p_value;
    l_parameter.p_param_type := p_type;
    g_request.parameters(g_request.parameters.count + 1) := l_parameter;
  end;
  --------------------------------------------------------------------------------
  -- ����� �������������� �������
  --
  procedure execute_request(p_response out t_response) as
    l_http_req    utl_http.req;
    l_http_resp   utl_http.resp;
    l_result      clob;
    l_param_value clob;
    l_parameter   t_parameter;
    l_db_charset  varchar2(100) := 'AL32UTF8';
    i             integer;
    l_env_lenb    number := 0;
    l_amount      number;
    l_offset      number;
    l_buffer      varchar2(32767);
    l_name        varchar2(256);
    l_hdr_value   varchar2(1024);
    l_hdr         header;
    l_hdrs        header_table;
  begin
    -- ����������� ��������� ����, ���� �� AL32UTF8 - ��������� ��������������
    select value into l_db_charset from nls_database_parameters where parameter = 'NLS_CHARACTERSET';

    trace_info('l_db_charset=' || l_db_charset || ', g_request.http_method=' || g_request.http_method || ', g_request.parameters.count=' || g_request.parameters.count);

    -- ������ ������ ����������
    for i in 1 .. g_request.parameters.count loop
      l_parameter := g_request.parameters(i);
      trace_info('parameter: p_param_name=[' || l_parameter.p_param_name || '], p_param_value=[' || substr(l_parameter.p_param_value, 1, 2000) || ']');

      if g_request.http_method = g_http_get then
        l_param_value  := url_encode(l_parameter.p_param_value);
        g_request.body := g_request.body || case
                            when i = 1 then
                             ''
                            else
                             '&'
                          end || l_parameter.p_param_name || '=' || l_param_value;
      else
        l_param_value  := l_parameter.p_param_value;
        g_request.body := g_request.body || case
                            when i = 1 then
                             ''
                            else
                             ','
                          end || '"' || l_parameter.p_param_name || '"' || ':' || '"' || l_param_value || '"';
      end if;
    end loop;


    if not g_request.http_method = g_http_get and g_request.content_type = wsm_mgr.g_ct_json then
      g_request.body := '{' || g_request.body || '}';
    end if;

    g_request.url := g_request.url || g_request.action;

    i := 0;

    if g_request.http_method = g_http_get then
      --g_request.body := utl_raw.cast_to_varchar2(utl_raw.convert(utl_raw.cast_to_raw(g_request.body),'american_america.al32utf8','american_america.'||l_db_charset));
      g_request.url  := g_request.url || '?' || clob_to_varchar2(g_request.body);
      g_request.body := null;

    else
      -- ��������� ������ ���� �������
      loop
        exit when clob_to_varchar2(g_request.body, i * 32767) is null;
        if l_db_charset = 'AL32UTF8' then
          l_env_lenb := l_env_lenb + lengthb(clob_to_varchar2(g_request.body, i * 32767));
        else
          l_env_lenb := l_env_lenb +
                        utl_raw.length(utl_raw.convert(utl_raw.cast_to_raw(clob_to_varchar2(g_request.body, i * 32767)), 'american_america.al32utf8', 'american_america.' || l_db_charset));
        end if;
        i := i + 1;
      end loop;
    end if;

    begin
      l_http_req := utl_http.begin_request(g_request.url, g_request.http_method, g_http_version);
    exception
      when others then
        if sqlcode = -29273 then
          raise_application_error(-20001, '�� �������� ����� �� ������� [' || g_request.url || ']' || sqlerrm, false);
        else
          raise;
        end if;
    end;

    -- utl_http.set_persistent_conn_support(true);
    -- utl_http.set_transfer_timeout(600);

    --update test_clob set data = g_request.body where metod_name = 'body';

    -- ��������� wallet ��� https
    if instr(lower(g_request.url), 'https') = 1 then
      utl_http.set_wallet(g_request.wallet_path, g_request.wallet_pwd);
    end if;

    trace_info('g_request.url             = [' || g_request.url || ']' || chr(10) || 'g_request.body            = [' || substr(g_request.body, 1, 2000) || ']' || chr(10) ||
               'l_env_lenb                = [' || l_env_lenb || ']' || chr(10) || 'g_request.content_type    = [' || g_request.content_type || ']' || chr(10) || 'g_request.content_charset = [' ||
               g_request.content_charset || ']');

    if g_request.http_method = g_http_post then
      utl_http.set_header(l_http_req, 'Content-Type', g_request.content_type || ';' || g_request.content_charset);
      utl_http.set_header(l_http_req, 'Content-Length', l_env_lenb);

      -- �������� ���� ������� ��� POST ��������
      l_amount := 8000;
      l_offset := 1;
      if dbms_lob.getlength(g_request.body) > 0 then
        begin
          loop
            dbms_lob.read(g_request.body, l_amount, l_offset, l_buffer);
            if l_db_charset = 'AL32UTF8' then
              utl_http.write_text(l_http_req, l_buffer);
            else
              utl_http.write_raw(l_http_req, utl_raw.convert(utl_raw.cast_to_raw(l_buffer), 'american_america.al32utf8', 'american_america.' || l_db_charset));
            end if;
            l_offset := l_offset + l_amount;
            l_amount := 8000;
          end loop;
        exception
          when no_data_found then
            null;
        end;
      end if;
    end if;

    l_http_resp := utl_http.get_response(l_http_req);

    -- set response code, response http header and response cookies global
    g_status_code := l_http_resp.status_code;
    trace_info('g_status_code = [' || g_status_code || ']');

    for i in 1 .. utl_http.get_header_count(l_http_resp) loop
      utl_http.get_header(l_http_resp, i, l_name, l_hdr_value);
      l_hdr.name := l_name;
      l_hdr.value := l_hdr_value;
      l_hdrs(i) := l_hdr;
      trace_info('res header name=[' || l_name || '], value=[' || l_hdr_value || ']');
    end loop;

    g_headers := l_hdrs;

    -- �������� ��� ��� � �� AL32UTF8 ����������
    utl_http.set_body_charset(l_http_resp, 'UTF8');

    -- ������ �����
    dbms_lob.createtemporary(l_result, false);
    dbms_lob.open(l_result, dbms_lob.lob_readwrite);

    begin
      loop
        utl_http.read_text(l_http_resp, l_buffer);
        dbms_lob.writeappend(l_result, length(l_buffer), l_buffer);
      end loop;
    exception
      when utl_http.end_of_body then
        null;
    end;

    utl_http.end_response(l_http_resp);
    -- ��� ��� ����������� �������������� � xmltype
    --l_result := replace(l_result, 'xmlns=', 'mlns=');
    --update test_clob set data = l_result where metod_name = 'test';
    --    commit;
    if g_status_code != 200 then
      raise_application_error(-20001,
                              '����� �������� ��� [' || g_status_code || ']. �������� ������������. ����� ������:' || chr(13) || chr(10) || l_result,
                              false);
    end if;

    --
    p_response.cdoc := l_result;
    begin
      p_response.xdoc := xmltype.createxml(l_result);
    exception
      when others then
        p_response.xdoc := null;
    end;
    --trace_info('l_result_clob = [' || p_response.cdoc || ']');

  end;

  ------------------------------------------------------------------------------
  --  ��������� ������
  --
  function test_service(p_echo clob, p_http_method in varchar2 default 'POST') return varchar2 is
    l_result varchar2(32767);
  begin
    begin
      select par_value into g_service_url from wsm_params where par_name = 'SEC_SERVICE_URL';
    exception
      when no_data_found then
        raise_application_error(-20001,
                                '�� ������� ������ ������ ��� ��������� ��������������� ����������� (SEC_SERVICE_URL) � �������� WSM_PARAMS',
                                false);
    end;

    if p_http_method = g_http_get then
      prepare_request(p_url => g_service_url, p_action => 'EchoGet', p_http_method => g_http_get);

      add_parameter(p_name => 'str1', p_value => p_echo || '1');
      add_parameter(p_name => 'str2', p_value => p_echo || '2');
      add_parameter(p_name => 'str3', p_value => p_echo || '3');

    else
      prepare_request(p_url => g_service_url, p_action => 'EchoPost', p_http_method => g_http_post);
      add_parameter(p_name => 'Message', p_value => p_echo);
    end if;

    execute_request(g_response);

    l_result := dbms_xmlgen.convert(g_response.xdoc.extract('//Message/text()').getstringval(), dbms_xmlgen.entity_decode);

    return l_result;
  end;

  ------------------------------------------------------------------------------
  --  ��������� �����
  --
  function sign_buffer(p_buffer clob) return varchar2 is
    l_result varchar2(32767);
  begin
    begin
      select par_value into g_service_url from wsm_params where par_name = 'SEC_SERVICE_URL';
    exception
      when no_data_found then
        raise_application_error(-20001,
                                '�� ������� ������ ������ ��� ��������� ��������������� ����������� (SEC_SERVICE_URL) � �������� WSM_PARAMS',
                                false);
    end;

    prepare_request(p_url => g_service_url, p_action => 'SignBufferSingle', p_http_method => g_http_post, p_content_type => g_ct_json);

    add_parameter(p_name => 'BufferInB64', p_value => convert_to_base64(p_buffer));
    add_parameter(p_name => 'BufferEncoding', p_value => 'windows-1251');
    add_parameter(p_name => 'Id', p_value => 'pdv');

    execute_request(g_response);

    if g_response.xdoc is not null then
      l_result := g_response.xdoc.extract('//Status/text()').getstringval();
      if l_result = '0' then
        return g_response.xdoc.extract('//Data/SignedBuffer/text()').getstringval();
      else
        l_result := g_response.xdoc.extract('//ErrorMessage/text()').getstringval();
        raise_application_error(-20001, '������� ���������� ������ - ' || l_result, false);
      end if;
    end if;
    return l_result;
  end;

  ------------------------------------------------------------------------------
  --  ��������� �������  �����
  --
  procedure verify_sign(p_buffer clob, p_sign_buffer in clob, p_signs_count out number) is
    l_result varchar2(32767);
  begin
    begin
      select par_value into g_service_url from wsm_params where par_name = 'SEC_SERVICE_URL';
    exception
      when no_data_found then
        raise_application_error(-20001,
                                '�� ������� ������ ������ ��� ��������� ��������������� ����������� (SEC_SERVICE_URL) � �������� WSM_PARAMS',
                                false);
    end;
    p_signs_count := 0;
    prepare_request(p_url => g_service_url, p_action => 'CheckSignSingle', p_http_method => g_http_post, p_content_type => g_ct_json);

    add_parameter(p_name => 'Id', p_value => 'pdv');
    add_parameter(p_name => 'Buffer', p_value => p_buffer);
    add_parameter(p_name => 'SignedBuffer', p_value => p_sign_buffer);

    execute_request(g_response);

    l_result := g_response.xdoc.extract('//Status/text()').getstringval();
    if l_result = '0' then
      p_signs_count := to_number(g_response.xdoc.extract('//Data/text()').getstringval());
      return;
    else
      l_result := g_response.xdoc.extract('//ErrorMessage/text()').getstringval();
      raise_application_error(-20001, '������� �������� ������ ������ - ' || l_result, false);
    end if;
  end;

begin
  -- Initialization
  null;
end wsm_mgr;

/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/package/wsm_mgr.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 