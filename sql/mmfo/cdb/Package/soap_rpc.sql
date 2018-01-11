
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/soap_rpc.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.SOAP_RPC as

    ---------------------------------------------------------------------
    -- Author  : OLEG
    -- Created : 22.12.2008
    -- Purpose : Пакет процедур для вызова методов web-сервисов
    -- Editor  : Artem Yurchenko
    --         : 18.09.2014 пакет переработан с учетом необходимости
    --         : шифровать пароли пользователей
    ---------------------------------------------------------------------

    g_header_version   constant varchar2(64) := 'version 1.03 18/09/2014';
    g_transfer_timeout constant number := 180;

    ----
    -- Возвращает версию заголовка пакета
    --
    function header_version return varchar2;

    ----
    -- Возвращает версию тела пакета
    --
    function body_version return varchar2;
    function decrypt(
        p_cypher in raw)
    return varchar2;

    ----
    -- тип, представляющий soap request
    --
    type t_request is record
    (
        url              varchar2(256 char),
        namespace        varchar2(256 char),
        method           varchar2(256 char),
        user_login       varchar2(30 char),
        user_pass        raw(1000),
        wallet_dir       raw(2000),
        wallet_pass      raw(1000),
        body             varchar2(32767 byte)
    );

    ----
    -- тип, представляющий  soap response
    --
    type t_response is record(
      doc xmltype);

    function read_branch_ws_parameters(
        p_branch_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return branch_ws_parameters%rowtype;

    procedure set_branch_ws_parameters(
        p_branch_id in integer,
        p_url in varchar2,
        p_login in varchar2,
        p_password in varchar2,
        p_wallet_dir in varchar2,
        p_wallet_pass in varchar2,
        p_default_namespace in varchar2 default null);

    procedure set_branch_ws_url(
        p_branch_id in integer,
        p_url in varchar2,
        p_default_namespace in varchar2 default null);

    procedure set_branch_ws_password(
        p_branch_id in integer,
        p_login in varchar2,
        p_password in varchar2);

    procedure set_branch_ws_wallet(
        p_branch_id in integer,
        p_wallet_dir in varchar2,
        p_wallet_pass in varchar2);

    ----
    -- создает новый soap request
    --
    function new_request(
        p_url         in varchar2,
        p_namespace   in varchar2,
        p_method      in varchar2,
        p_user_login  in varchar2,
        p_user_pass   in raw,
        p_wallet_dir  in raw,
        p_wallet_pass in raw)
    return t_request;

    function new_request(
        p_branch_id in integer,
        p_method in varchar2,
        p_namespace in varchar2 default null)
    return t_request;

    ----
    -- добавляет параметр в soap request.
    --
    procedure add_parameter(
        p_req   in out nocopy t_request,
        p_name  in varchar2,
        p_value in varchar2);

    ----
    -- вызов
    --
    function invoke(p_req in out nocopy t_request) return t_response;

    ----
    -- возвращает параметр из ответа веб-сервиса
    --
    function get_return_value(p_resp      in out nocopy t_response,
                              p_name      in varchar2,
                              p_namespace in varchar2) return varchar2;

    function urlencode(p_str in varchar2) return varchar2;
    function urldecode(p_str in varchar2) return varchar2;

    procedure generate_envelope(p_req in out nocopy t_request,
                                p_env in out nocopy varchar2);
    procedure show_envelope(p_env in varchar2);

end;
/
CREATE OR REPLACE PACKAGE BODY CDB.SOAP_RPC as

    G_BODY_VERSION                 constant varchar2(64) := 'version 1.03 21/10/2014';
    G_XMLHEAD                      constant varchar2(100) := '<?xml version="1.0" encoding="utf-8"?>';

    g_crypto_key          constant varchar2(64 char) := '71C35128A5A305B8B3C72AE4A67338F8B292517E3038570A2D2B5D5060B81B93';

    ----
    -- Возвращает версию заголовка пакета
    --
    function header_version return varchar2 is
    begin
      return 'package header soap_rpc ' || g_header_version;
    end header_version;

    ----
    -- Возвращает версию тела пакета
    --
    function body_version return varchar2 is
    begin
      return 'package body soap_rpc ' || g_body_version;
    end body_version;

    function crlf return varchar2 is
    begin
      return chr(13) || chr(10);
    end;

    function encrypt(
        p_password in varchar2)
    return raw
    is
        l_charset varchar2(50 char);
        l_encryption_type PLS_INTEGER :=          -- total encryption type
                              DBMS_CRYPTO.ENCRYPT_AES256
                            + DBMS_CRYPTO.CHAIN_CBC
                            + DBMS_CRYPTO.PAD_PKCS5;
        l_key raw(32);
        l_encrypted_raw raw(2000);
    begin
        select value
        into   l_charset
        from   nls_database_parameters
        where  parameter = 'NLS_CHARACTERSET';

        l_key := cast(g_crypto_key as raw);

        l_encrypted_raw := dbms_crypto.encrypt
           (
              src => utl_i18n.string_to_raw (p_password,  l_charset),
              typ => l_encryption_type,
              key => l_key
           );
         -- The encrypted value "encrypted_raw" can be used here
         return l_encrypted_raw;
    end;

    function decrypt(
        p_cypher in raw)
    return varchar2
    is
        l_charset varchar2(50 char);
        l_encryption_type PLS_INTEGER :=          -- total encryption type
                              DBMS_CRYPTO.ENCRYPT_AES256
                            + DBMS_CRYPTO.CHAIN_CBC
                            + DBMS_CRYPTO.PAD_PKCS5;
        l_key raw(32);
        l_decrypted_raw raw(2000);
        l_output_string varchar2(1024 char);
    begin
        select value
        into   l_charset
        from   nls_database_parameters
        where  parameter = 'NLS_CHARACTERSET';

        l_key := cast(g_crypto_key as raw);

        l_decrypted_raw := dbms_crypto.decrypt
             (
                src => p_cypher,
                typ => l_encryption_type,
                key => l_key
             );

        l_output_string := utl_i18n.raw_to_char (l_decrypted_raw, l_charset);

        return l_output_string;
    end;

    function read_branch_ws_parameters(
        p_branch_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return branch_ws_parameters%rowtype
    is
        l_branch_ws_parameters_row branch_ws_parameters%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_branch_ws_parameters_row
            from   branch_ws_parameters p
            where  p.branch_id = p_branch_id
            for update;
        else
            select *
            into   l_branch_ws_parameters_row
            from   branch_ws_parameters p
            where  p.branch_id = p_branch_id;
        end if;

        return l_branch_ws_parameters_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Параметри web-сервісу для філіалу з ідентифікатором {' || p_branch_id || '} не знайдені');
             else return null;
             end if;
    end;

    procedure set_branch_ws_parameters(
        p_branch_id in integer,
        p_url in varchar2,
        p_login in varchar2,
        p_password in varchar2,
        p_wallet_dir in varchar2,
        p_wallet_pass in varchar2,
        p_default_namespace in varchar2 default null)
    is
        l_branch_ws_parameters_row branch_ws_parameters%rowtype;
        l_password raw(1000);
        l_wallet_dir raw(2000);
        l_wallet_pass raw(1000);
    begin
        l_branch_ws_parameters_row := read_branch_ws_parameters(p_branch_id, p_lock => true, p_raise_ndf => false);

        l_password := encrypt(p_password);
        l_wallet_dir := encrypt(p_wallet_dir);
        l_wallet_pass := encrypt(p_wallet_pass);

        if (l_branch_ws_parameters_row.branch_id is null) then
            insert into branch_ws_parameters
            values (p_branch_id, p_url, p_login, l_password, l_wallet_dir, l_wallet_pass, p_default_namespace);
        else
            update branch_ws_parameters p
            set    p.url = p_url,
                   p.login = p_login,
                   p.password = l_password,
                   p.wallet_dir = l_wallet_dir,
                   p.wallet_pass = l_wallet_pass,
                   p.default_namespace = p_default_namespace
            where  p.branch_id = p_branch_id;
        end if;
    end;

    procedure set_branch_ws_url(
        p_branch_id in integer,
        p_url in varchar2,
        p_default_namespace in varchar2 default null)
    is
        l_branch_ws_parameters_row branch_ws_parameters%rowtype;
    begin
        l_branch_ws_parameters_row := read_branch_ws_parameters(p_branch_id, p_lock => true, p_raise_ndf => false);

        if (l_branch_ws_parameters_row.branch_id is null) then
            insert into branch_ws_parameters
            values (p_branch_id, p_url, null, null, null, null, p_default_namespace);
        else
            update branch_ws_parameters p
            set    p.url = p_url,
                   p.default_namespace = p_default_namespace
            where  p.branch_id = p_branch_id;
        end if;
    end;

    procedure set_branch_ws_password(
        p_branch_id in integer,
        p_login in varchar2,
        p_password in varchar2)
    is
        l_branch_ws_parameters_row branch_ws_parameters%rowtype;
        l_password raw(1000);
    begin
        l_branch_ws_parameters_row := read_branch_ws_parameters(p_branch_id, p_lock => true);

        l_password := encrypt(p_password);

        update branch_ws_parameters p
        set    p.login = p_login,
               p.password = l_password
        where  p.branch_id = l_branch_ws_parameters_row.branch_id;
    end;

    procedure set_branch_ws_wallet(
        p_branch_id in integer,
        p_wallet_dir in varchar2,
        p_wallet_pass in varchar2)
    is
        l_branch_ws_parameters_row branch_ws_parameters%rowtype;
        l_wallet_dir raw(2000);
        l_wallet_pass raw(1000);
    begin
        l_branch_ws_parameters_row := read_branch_ws_parameters(p_branch_id, p_lock => true);

        l_wallet_dir := encrypt(p_wallet_dir);
        l_wallet_pass := encrypt(p_wallet_pass);

        update branch_ws_parameters p
        set    p.wallet_dir = l_wallet_dir,
               p.wallet_pass = l_wallet_pass
        where  p.branch_id = l_branch_ws_parameters_row.branch_id;
    end;

    ----
    -- создает новый soap request
    --
    function new_request(p_url         in varchar2,
                         p_namespace   in varchar2,
                         p_method      in varchar2,
                         p_user_login  in varchar2,
                         p_user_pass   in raw,
                         p_wallet_dir  in raw,
                         p_wallet_pass in raw)
    return t_request is
        l_req t_request;
    begin
        -- Проверяем что для SSL соединения указаны параметры wallet
        if (instr(lower(p_url), 'https://') > 0 and
            (p_wallet_dir is null or p_wallet_pass is null)) then
            raise_application_error(-20001, 'Для SSL з`єднання необхідно вказати параметри Wallet', false);
        end if;

        l_req.method      := p_method;
        l_req.namespace   := p_namespace;
        l_req.url         := p_url;
        l_req.user_login  := p_user_login;
        l_req.user_pass   := p_user_pass;
        l_req.wallet_dir  := p_wallet_dir;
        l_req.wallet_pass := p_wallet_pass;

        return l_req;
    end new_request;

    function new_request(
        p_branch_id in integer,
        p_method in varchar2,
        p_namespace in varchar2 default null)
    return t_request
    is
        l_branch_ws_parameters_row branch_ws_parameters%rowtype;
    begin
        l_branch_ws_parameters_row := read_branch_ws_parameters(p_branch_id);

        return new_request(l_branch_ws_parameters_row.url,
                           nvl(p_namespace, l_branch_ws_parameters_row.default_namespace),
                           p_method,
                           l_branch_ws_parameters_row.login,
                           l_branch_ws_parameters_row.password,
                           l_branch_ws_parameters_row.wallet_dir,
                           l_branch_ws_parameters_row.wallet_pass);
    end new_request;

    ---
    -- добавляет параметр в soap request
    --
    procedure add_parameter(p_req   in out nocopy t_request,
                            p_name  in varchar2,
                            p_value in varchar2) as
    begin
      p_req.body := p_req.body || '<' || p_name || '>' || p_value || '</' ||
                    p_name || '>';
    end;

    function generate_header(p_req in out nocopy t_request)
    return varchar2
    is
        l_header varchar2(32767 byte);
        l_password varchar2(32767 byte);
    begin

        if (p_req.user_login is not null) then
            l_password := decrypt(p_req.user_pass);

            l_header := '<soap:Header>' ||
                            '<WsHeader xmlns="' || p_req.namespace || '">' ||
                                '<UserName>' || p_req.user_login || '</UserName>' ||
                                '<Password>' || l_password || '</Password>' ||
                            '</WsHeader>' ||
                        '</soap:Header>';
        end if;

        return l_header;
    end;

    procedure generate_envelope(p_req in out nocopy t_request,
                                p_env in out nocopy varchar2) as
    begin
      p_env := G_XMLHEAD || '<soap:Envelope ' ||
               'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' ||
               'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' ||
               'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' ||
               generate_header(p_req) ||
               '<soap:Body>' || '<' || p_req.method || ' xmlns="' ||
               p_req.namespace || '">' || p_req.body || '</' || p_req.method || '>' ||
               '</soap:Body>' || '</soap:Envelope>';
    end;

    ----
    -- отображает пакет
    --
    procedure show_envelope(p_env in varchar2) as
      l_i   pls_integer;
      l_len pls_integer;
    begin
      l_i   := 1;
      l_len := length(p_env);
      while (l_i <= l_len) loop
        dbms_output.put_line(substr(p_env, l_i, 255));
        l_i := l_i + 255;
      end loop;
    end;

    ----
    -- получает строку с ошибкой и генерирует исключение
    --
    procedure check_fault(p_resp in out nocopy t_response) as
      l_fault_node   xmltype;
      l_fault_code   varchar2(256);
      l_fault_string varchar2(32767);
    begin
      l_fault_node := p_resp.doc.extract('/soap:Fault',
                                         'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/');
      if (l_fault_node is not null) then
        l_fault_code   := l_fault_node.extract('/soap:Fault/faultcode/child::text()','xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/')
                          .getstringval();
        l_fault_string := l_fault_node.extract('/soap:Fault/faultstring/child::text()','xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/')
                          .getstringval();
        raise_application_error(-20000,
                                l_fault_code || ' - ' || l_fault_string);
      end if;
    end;

    ----
    -- вызов
    --
    function invoke(p_req in out nocopy t_request) return t_response as
      l_env         varchar2(32767);
      l_line        varchar2(32767);
      l_res         clob;
      l_http_req    utl_http.req;
      l_http_resp   utl_http.resp;
      l_resp        t_response;
      l_wallet_dir  varchar2(2000 char);
      l_wallet_pass varchar2(200 char);
    begin
      generate_envelope(p_req, l_env);

      utl_http.set_transfer_timeout(g_transfer_timeout);

      -- SSL соединение выполняем через wallet
      if (instr(lower(p_req.url), 'https://') > 0) then
          l_wallet_dir := decrypt(p_req.wallet_dir);
          l_wallet_pass := decrypt(p_req.wallet_pass);
          utl_http.set_wallet(l_wallet_dir, l_wallet_pass);
      end if;

      l_http_req := utl_http.begin_request(p_req.url, 'POST', 'HTTP/1.0');
      utl_http.set_header(l_http_req, 'Content-Type', 'text/xml;');
      utl_http.set_header(l_http_req, 'Content-Length', length(l_env));
      utl_http.set_header(l_http_req,
                          'SOAPAction',
                          p_req.namespace || p_req.method);
      logger.log('soap_rpc.invoke (envelope)', 1, l_env);
      utl_http.write_text(l_http_req, l_env);

      l_http_resp := utl_http.get_response(l_http_req);
      l_res       := null;
      begin
        loop
          utl_http.read_text(l_http_resp, l_line);
          l_res := l_res || l_line;
        end loop;
      exception
        when utl_http.end_of_body then
          null;
      end;
      utl_http.end_response(l_http_resp);

      logger.log('soap_rpc.invoke (response)', 1, l_res);

      l_resp.doc := xmltype.createxml(l_res);
      l_resp.doc := l_resp.doc.extract('/soap:Envelope/soap:Body/child::node()',
                                       'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
      check_fault(l_resp);
      return l_resp;
    end;

    ----
    -- возвращает параметр из ответа веб-сервиса
    --
    function get_return_value(p_resp      in out nocopy t_response,
                              p_name      in varchar2,
                              p_namespace in varchar2) return varchar2 as
    begin
      return p_resp.doc.extract('//' || p_name || '/child::text()',
                                p_namespace).getstringval();
    end;

    function urlencode(p_str in varchar2) return varchar2 is
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
          l_tmp := l_tmp || '%' ||
                   substr(l_hex, mod(trunc(l_num / 16), 16) + 1, 1) ||
                   substr(l_hex, mod(l_num, 16) + 1, 1);
        else
          l_tmp := l_tmp || l_char;
        end if;
      end loop;
      return l_tmp;
    end urlencode;

    function urldecode(p_str in varchar2) return varchar2 is
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
        l_ret := substr(l_ret, 1, l_idx - 1) ||
                 chr((instr(l_hex, substr(l_ret, l_idx + 1, 1)) - 1) * 16 +
                     instr(l_hex, substr(l_ret, l_idx + 2, 1)) - 1) ||
                 substr(l_ret, l_idx + 3);
      end loop;
      return l_ret;
    end urldecode;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/soap_rpc.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 