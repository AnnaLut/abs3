create or replace package transp_web is

  -- Author  : OLEKSANDR.IVANENKO
  -- Created : 14.06.2018 12:03:25
  -- Purpose : 
  
  g_http_version              constant varchar2(20) := 'HTTP/1.1';
  g_http_post                 constant varchar2(20) := 'POST';
  g_http_get                  constant varchar2(20) := 'GET';
  -- Content type
  g_ct_json                   constant varchar2(20) := 'application/json';
  g_ct_xml                    constant varchar2(20) := 'text/xml';
  g_ct_html                   constant varchar2(20) := 'text/html';
  -- Content charset
  g_cc_utf8                   constant varchar2(20) := 'charset=utf-8';
  g_cc_win1251                constant varchar2(20) := 'charset=windows-1251';

  g_transfer_timeout          constant number:= 1800;
  
  -- список header переменных
  type t_header is record(
    p_header_name  varchar2(256),
    p_header_value varchar2(1024));

  type t_headers is table of t_header index by binary_integer;

  g_headers t_headers;

  type t_parameter is record(
    p_param_name  varchar2(256),
    p_param_value clob,
    p_param_type  varchar2(256));

  type t_parameters is table of t_parameter index by binary_integer;

  g_parameters t_parameters;
  ----
  -- Объект запроса
  --
  type t_request is record(
    url             varchar2(32767),
    timeout         number,
    action          varchar2(256),
    http_method     varchar2(10),
    content_type    varchar2(256),
    content_charset varchar2(256),
    wallet_path     varchar2(256),
    wallet_pwd      varchar2(256),
    body            clob,
    blob_body       blob,
    parameters      t_parameters,
    headers         t_headers,
    namespace       varchar2(256),
    soap_method     varchar2(256),
    soap_login      varchar2(30 char),
    soap_password   varchar2(255 char)
    );

  ----
  -- Объект ответа
  --
  type t_response is record(
    cdoc clob,
    status number,
    headers t_headers);

  
   procedure prepare_request(p_url             in varchar2,
                           p_timeout         in number default null,
                           p_action          in varchar2 default null,
                           p_http_method     in varchar2 default g_http_get,
                           p_content_type    in varchar2 default g_ct_json,
                           p_content_charset in varchar2 default g_cc_utf8,
                           p_wallet_path     in varchar2 default null,
                           p_wallet_pwd      in varchar2 default null,
                           p_namespace       in varchar2 default null,
                           p_soap_method     in varchar2 default null,
                           p_soap_login      in varchar2 default null,
                           p_soap_password   in varchar2 default null,
                           p_body            in clob default null,
                           p_blob_body       in blob default null);
  procedure add_parameter(p_name  in varchar2,
                         p_value in clob,
                         p_type  in varchar2 default 'string');
  procedure add_header(p_name in varchar2, p_value in varchar2);
  
  procedure execute_api(p_response out t_response);

end transp_web;
/
create or replace package body transp_web is

g_request t_request;

--url_encode---------------------------------------------------------------------------------
 --URL-кодирует строку
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
             l_tmp := l_tmp || '%' ||
                      substr(l_hex, mod(trunc(l_num / 16), 16) + 1, 1) ||
                      substr(l_hex, mod(l_num, 16) + 1, 1);
         else
             l_tmp := l_tmp || l_char;
         end if;
     end loop;
     return l_tmp;
 end url_encode;

 --url_decode--------------------------------------------------------------------------------
 -- декодирует URL-кодированную строку
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
         l_ret := substr(l_ret, 1, l_idx - 1) ||
                  chr((instr(l_hex, substr(l_ret, l_idx + 1, 1)) - 1) * 16 +
                      instr(l_hex, substr(l_ret, l_idx + 2, 1)) - 1) ||
                  substr(l_ret, l_idx + 3);
     end loop;
     return l_ret;
 end url_decode;
 
 --prepare_request----------------------------------------------------------------------------
 -- инициализация \ подготовка запроса
 procedure prepare_request(p_url             in varchar2,
                           p_timeout         in number default null,
                           p_action          in varchar2 default null,
                           p_http_method     in varchar2 default g_http_get,
                           p_content_type    in varchar2 default g_ct_json,
                           p_content_charset in varchar2 default g_cc_utf8,
                           p_wallet_path     in varchar2 default null,
                           p_wallet_pwd      in varchar2 default null,
                           p_namespace       in varchar2 default null,
                           p_soap_method     in varchar2 default null,
                           p_soap_login      in varchar2 default null,
                           p_soap_password   in varchar2 default null,
                           p_body            in clob default null,
                           p_blob_body       in blob default null) as
 begin
     -- Проверяем что для SSL соединения указаны параметры wallet
     if (instr(lower(p_url), 'https') = 1 and
        (p_wallet_path is null or p_wallet_pwd is null)) then
         raise_application_error(-20001,
                                 'Для SSL з`єднання необхідно вказати параметри Wallet',
                                 false);
     end if;
     g_parameters.delete;
     g_headers.delete;
     g_request.url             := p_url;
     g_request.timeout         := p_timeout;
     g_request.action          := p_action;
     g_request.http_method     := p_http_method;
     g_request.content_type    := p_content_type;
     g_request.content_charset := p_content_charset;
     g_request.wallet_path     := p_wallet_path;
     g_request.wallet_pwd      := p_wallet_pwd;
     g_request.body            := p_body;
     g_request.blob_body       := p_blob_body;
     g_request.parameters      := g_parameters;
     g_request.headers         := g_headers;
     g_request.namespace       := p_namespace;
     g_request.soap_method     := p_soap_method;
     if g_request.body is null then
         dbms_lob.createtemporary(g_request.body, false);
     end if;

 end;

 --add_parameter------------------------------------------------------------------------------
 -- добавляет параметр в запрос
 procedure add_parameter(p_name  in varchar2,
                         p_value in clob,
                         p_type  in varchar2 default 'string') as
     l_parameter t_parameter;
 begin
     l_parameter.p_param_name := p_name;
     l_parameter.p_param_value := p_value;
     l_parameter.p_param_type := p_type;
     g_request.parameters(g_request.parameters.count + 1) := l_parameter;
 end;

 --add_header---------------------------------------------------------------------------------
 -- добавляет параметр в заголовок запроса
 procedure add_header(p_name in varchar2, p_value in varchar2) as
     l_header t_header;
 begin
     l_header.p_header_name := p_name;
     l_header.p_header_value := p_value;
     g_request.headers(g_request.headers.count + 1) := l_header;
 end;
 --execute_api-------------------------------------------------------------------------------
 --вызов подготовленого запроса WebApi
 procedure execute_api(p_response out nocopy t_response) as
     l_http_req     utl_http.req;
     l_http_resp    utl_http.resp;
     l_parameter    t_parameter;
     l_param_value  clob;
     l_length       number;
     l_tmp          raw(32767);
     l_offset       number := 1;
     l_ammount      number := 2000;
     l_buffer       varchar2(32767);
     l_header       t_header;
     l_name         varchar2(256);
     l_hdr_value    varchar2(1024);
     l_hdr          t_header;
     l_hdrs         t_headers;
     l_result       clob;
     l_db_charset   varchar2(100) := 'AL32UTF8';
     l_response_raw raw(32767);
     l_status_code  pls_integer;
     eob            boolean;
 begin
     --trace_info('g_request.http_method=' || g_request.http_method );

     select value
       into l_db_charset
       from nls_database_parameters
      where parameter = 'NLS_CHARACTERSET';

     utl_http.set_transfer_timeout(g_transfer_timeout);

     -- SSL соединение выполняем через wallet
     if (instr(lower(g_request.url), 'https://') > 0) then
         utl_http.set_wallet(g_request.wallet_path, g_request.wallet_pwd);
     end if;

     -- add GET parameters to url
     for i in 1 .. g_request.parameters.count loop
         l_parameter := g_request.parameters(i);
         --trace_info('parameter: p_param_name=[' || l_parameter.p_param_name || '], p_param_value=[' || substr(l_parameter.p_param_value, 1, 2000) || ']');

         l_param_value := url_encode(l_parameter.p_param_value);
         g_request.url := g_request.url || case
                              when i = 1 then
                               '?'
                              else
                               '&'
                          end || l_parameter.p_param_name || '=' ||
                          l_param_value;
     end loop;
     g_request.parameters.delete;

     begin
         l_http_req := utl_http.begin_request(g_request.url,
                                              g_request.http_method,
                                              g_http_version);
     exception
         when others then
             if sqlcode = -29273 then
                 raise_application_error(-20001,
                                         'Не запущено сервіс за адресою [' ||
                                         g_request.url || ']' || sqlerrm,
                                         false);
             else
                 raise;
             end if;
     end;
     /*
         trace_info('g_request.url             = [' || g_request.url || ']' || chr(10) ||
                    'g_request.body            = [' || substr(g_request.body, 1, 2000) || ']' || chr(10) ||
                    'g_request.blob_body.len   = [' || dbms_lob.getlength(g_request.blob_body) || ']' || chr(10) ||
                    'g_request.content_type    = [' || g_request.content_type || ']' || chr(10) ||
                    'g_request.content_charset = [' || g_request.content_charset || ']');
     */
     -- header
     for i in 1 .. g_request.headers.count loop
         l_header := g_request.headers(i);
         utl_http.set_header(l_http_req,
                             l_header.p_header_name,
                             l_header.p_header_value);
     end loop;

     -- тело запроса - blob
     if (g_request.blob_body is not null) then
         l_length := dbms_lob.getlength(g_request.blob_body);
         utl_http.set_header(r     => l_http_req,
                             name  => 'Content-Length',
                             value => l_length);

         l_offset := 1;
         while (l_offset < l_length) loop
             dbms_lob.read(g_request.blob_body,
                           l_ammount,
                           l_offset,
                           l_buffer);
             utl_http.write_raw(l_http_req, l_buffer);
             l_offset := l_offset + l_ammount;
         end loop;
         -- utl_http.write_raw(l_http_req, g_request.blob_body);
     else
         -- определяем длину сообщения
         l_length := dbms_lob.getlength(g_request.body);

         utl_http.set_header(r     => l_http_req,
                             name  => 'Transfer-Encoding',
                             value => 'chunked');

         -- формируем тело запроса
         if (l_length <= 32767 and l_length > 0) then
             if l_db_charset = 'AL32UTF8' then
                 l_tmp := utl_raw.cast_to_raw(dbms_lob.substr(g_request.body,
                                                              l_length,
                                                              1));
             else
                 l_tmp := utl_raw.convert(utl_raw.cast_to_raw(dbms_lob.substr(g_request.body,
                                                                              l_length,
                                                                              1)),
                                          'american_america.al32utf8',
                                          'american_america.' ||
                                          lower(l_db_charset));
             end if;

             utl_http.set_header(r     => l_http_req,
                                 name  => 'Content-Length',
                                 value => utl_raw.length(l_tmp));

             utl_http.write_raw(l_http_req, l_tmp);
         elsif (l_length > 32767) then
             -- если длина xml-данных больше 32Кб
             -- тело запроса по кусочкам
             while (l_offset < l_length) loop
                 dbms_lob.read(g_request.body,
                               l_ammount,
                               l_offset,
                               l_buffer);
                 if l_db_charset = 'AL32UTF8' then
                     l_tmp := utl_raw.cast_to_raw(l_buffer);
                 else
                     l_tmp := utl_raw.convert(utl_raw.cast_to_raw(l_buffer),
                                              'american_america.al32utf8',
                                              'american_america.' ||
                                              lower(l_db_charset));
                 end if;
                 utl_http.write_raw(l_http_req, l_tmp);
                 l_offset := l_offset + l_ammount;
             end loop;
         end if;
     end if;

     l_http_resp := utl_http.get_response(l_http_req);

     -- set response code, response http header and response cookies global
     l_status_code := l_http_resp.status_code;
     --trace_info('g_status_code = [' || g_status_code || ']');

     for i in 1 .. utl_http.get_header_count(l_http_resp) loop
         utl_http.get_header(l_http_resp, i, l_name, l_hdr_value);
         l_hdr.p_header_name := l_name;
         l_hdr.p_header_value := l_hdr_value;
         l_hdrs(i) := l_hdr;
         --trace_info('res header name=[' || l_name || '], value=[' || l_hdr_value || ']');
     end loop;

     g_headers := l_hdrs;

     -- читаем ответ
     dbms_lob.createtemporary(l_result, false);
     dbms_lob.open(l_result, dbms_lob.lob_readwrite);

     eob := false; -- END-OF-BODY flag (Boolean)
     while not (eob) loop
         begin
             utl_http.read_raw(l_http_resp, l_response_raw, 32767);

             if l_db_charset = 'AL32UTF8' then
                 l_buffer := utl_raw.cast_to_varchar2(l_response_raw);
             else
                 l_buffer := utl_raw.cast_to_varchar2(utl_raw.convert(l_response_raw,
                                                                      'american_america.' ||
                                                                      lower(l_db_charset),
                                                                      'american_america.al32utf8'));
             end if;

             if l_buffer is not null and length(l_buffer) > 0 then
                 dbms_lob.writeappend(l_result, length(l_buffer), l_buffer);
             end if;
         exception
             when utl_http.end_of_body then
                 eob := true;
         end;
     end loop;

     utl_http.end_response(l_http_resp);

     p_response.cdoc   := l_result;
     p_response.status := l_status_code;
     p_response.headers:= l_hdrs;
     g_request.headers.delete;
     g_request.parameters.delete;
 end;
end transp_web;
/
