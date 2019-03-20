
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/soap_rpc.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SOAP_RPC as

  ---------------------------------------------------------------------
  -- Author  : OLEG
  -- Created : 22.12.2008
  -- Purpose : Пакет процедур для вызова методов web-сервисов
  ---------------------------------------------------------------------

  g_header_version   constant varchar2(64) := 'version 1.03 18/03/2014';
  g_transfer_timeout number := 1800;

  ----
  -- Возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- Возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  -- тип, представляющий soap request
  --
  type t_request is record(
    url         varchar2(256),
    namespace   varchar2(256),
    method      varchar2(256),
    wallet_dir  varchar2(256),
    wallet_pass varchar2(256),
    body        clob);

  ----
  -- тип, представляющий  soap response
  --
  type t_response is record(
    doc xmltype);

  ----
  -- создает новый soap request
  --
  function new_request(p_url         in varchar2,
                       p_namespace   in varchar2,
                       p_method      in varchar2,
                       p_wallet_dir  in varchar2 default null,
                       p_wallet_pass in varchar2 default null)
    return t_request;

  ----
  -- добавляет параметр в soap request.
  --
  procedure add_parameter(p_req   in out nocopy t_request,
                          p_name  in varchar2,
                          p_value in clob);

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

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.SOAP_RPC as

  G_BODY_VERSION constant varchar2(64) := 'version 1.033 18/03/2014';
  G_XMLHEAD      constant varchar2(100) := '<?xml version="1.0" encoding="utf-8"?>';

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

  ----
  -- создает новый soap request
  --
  function new_request(p_url         in varchar2,
                       p_namespace   in varchar2,
                       p_method      in varchar2,
                       p_wallet_dir  in varchar2 default null,
                       p_wallet_pass in varchar2 default null)
    return t_request is
    l_req t_request;
  begin
    -- Проверяем что для SSL соединения указаны параметры wallet
    if (instr(lower(p_url), 'https://') > 0 and
       (p_wallet_dir is null or p_wallet_pass is null)) then
      raise_application_error(-20001,
                              'Для SSL з`єднання необхідно вказати параметри Wallet',
                              false);
    end if;

    l_req.method      := p_method;
    l_req.namespace   := p_namespace;
    l_req.url         := p_url;
    l_req.wallet_dir  := p_wallet_dir;
    l_req.wallet_pass := p_wallet_pass;

    dbms_lob.createtemporary(l_req.body, false);

    return l_req;
  end new_request;

  ---
  -- добавляет параметр в soap request
  --
  procedure add_parameter(p_req   in out nocopy t_request,
                          p_name  in varchar2,
                          p_value in clob) as
    l_opening_tag varchar2(1000) := '<' || p_name || '>';
    l_closing_tag varchar2(1000) := '</' || p_name || '>';

  begin
    dbms_lob.writeappend(p_req.body, length(l_opening_tag), l_opening_tag);
    dbms_lob.append(p_req.body, dbms_xmlgen.convert(p_value));
    dbms_lob.writeappend(p_req.body, length(l_closing_tag), l_closing_tag);
  end;

  procedure generate_envelope(p_req in out nocopy t_request,
                              p_env in out nocopy clob) as
  begin
    p_env := G_XMLHEAD || '<soap:Envelope ' ||
             'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' ||
             'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' ||
             'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' ||
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
  --  генерирует исключение ошибкой
  --
  procedure throw_fault(p_fault_code   in varchar2,
                        p_fault_string in varchar2) as
  begin
    raise_application_error(-20000,
                            p_fault_code || ' - ' || p_fault_string);
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
      throw_fault(l_fault_code, l_fault_string);
    end if;
  end;

  ----
  -- вызов
  --
  function invoke(p_req in out nocopy t_request) return t_response as
    l_env          clob;
    l_env_length   number;
    l_line         clob;
    l_res          clob;
    l_http_req     utl_http.req;
    l_http_resp    utl_http.resp;
    l_resp         t_response;
    l_fault_node   xmltype;
    l_fault_code   varchar2(256);
    l_fault_string varchar2(32767);
  begin
    generate_envelope(p_req, l_env);

    utl_http.set_transfer_timeout(g_transfer_timeout);

    -- SSL соединение выполняем через wallet
    if (instr(lower(p_req.url), 'https://') > 0) then
      utl_http.set_wallet(p_req.wallet_dir, p_req.wallet_pass);
    end if;

    -- формируем заголовки сообщения
    l_http_req := utl_http.begin_request(url          => p_req.url,
                                         method       => 'POST',
                                         http_version => utl_http.http_version_1_1);

    utl_http.set_header(l_http_req,
                        'Content-Type',
                        'text/xml; charset=windows-1251');

    utl_http.set_header(l_http_req,
                        'SOAPAction',
                        p_req.namespace || p_req.method);

    -- определяем длину сообщения
    l_env_length := dbms_lob.getlength(l_env);

    -- формируем тело запроса
    if (l_env_length <= 32767) then
      -- если длина xml-данных меньше 32Кб
      utl_http.set_header(r     => l_http_req,
                          name  => 'Content-Length',
                          value => l_env_length);

      -- тело запроса по целяком
      declare
        l_tmp varchar2(32767) := dbms_lob.substr(l_env, 32767, 1);
      begin
        dbms_output.put_line('l_tmp' || l_tmp);
        utl_http.write_text(l_http_req, l_tmp);
      end;
    elsif (l_env_length > 32767) then
      -- если длина xml-данных больше 32Кб
      utl_http.set_header(r     => l_http_req,
                          name  => 'Transfer-Encoding',
                          value => 'chunked');

      -- тело запроса по кусочкам
      declare
        l_offset  number := 1;
        l_ammount number := 2000;
        l_buffer  varchar2(2000);
      begin
        while (l_offset < l_env_length) loop
          dbms_lob.read(l_env, l_ammount, l_offset, l_buffer);
          utl_http.write_text(l_http_req, l_buffer);
          l_offset := l_offset + l_ammount;
        end loop;
      end;
    end if;

    -- получаем ответ
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

    begin
      l_resp.doc := xmltype.createxml(l_res);
      l_resp.doc := l_resp.doc.extract('/soap:Envelope/soap:Body/child::node()',
                                       'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
      l_fault_node := l_resp.doc.extract('/soap:Fault','xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/');
      if (l_fault_node is not null) then
          l_fault_code   := l_fault_node.extract('/soap:Fault/faultcode/child::text()','xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/')
                            .getstringval();
          l_fault_string := l_fault_node.extract('/soap:Fault/faultstring/child::text()','xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/')
                            .getstringval();
          throw_fault( l_fault_code, l_fault_string);
      end if;
     -- check_fault(l_resp);
    exception
      when others then
        if l_fault_code is not null and  l_fault_string is not null
          then throw_fault( l_fault_code, l_fault_string);
          else throw_fault('0', 'Помилка у відповіді! Текст відповіді: ' ||l_res);
        end if;
    end;

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
 
PROMPT *** Create  grants  SOAP_RPC ***
grant EXECUTE                                                                on SOAP_RPC        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/soap_rpc.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 