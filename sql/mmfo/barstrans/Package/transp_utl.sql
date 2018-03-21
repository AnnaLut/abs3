create or replace package transp_utl is

  -- Author  : OLEKSANDR.IVANENKO
  -- Created : 09.02.2018 17:01:51
  -- Purpose : utils_for_bars_transp

  -- Public type declarations
  --type <TypeName> is <Datatype>;

  -- Public constant declarations
  --<ConstantName> constant <Datatype> := <Value>;

  -- Public variable declarations
  --<VariableName> <Datatype>;

  -- Public function and procedure declarations
  --function <FunctionName>(<Parameter> <Datatype>) return <Datatype>;
  --

  g_header_version  constant varchar2(64) := 'version 1.0 14/02/2018';

  g_http_version constant varchar2(20) := 'HTTP/1.1';
  g_http_post    constant varchar2(20) := 'POST';
  g_http_get     constant varchar2(20) := 'GET';

  -- Content type
  g_ct_json constant varchar2(20) := 'application/json';
  g_ct_xml  constant varchar2(20) := 'text/xml';
  g_ct_html constant varchar2(20) := 'text/html';
  -- Content charset
  g_cc_utf8    constant varchar2(20) := 'charset=utf-8';
  g_cc_win1251 constant varchar2(20) := 'charset=windows-1251';

  g_status_code pls_integer;

  g_proxy_url varchar2(256);
  g_transfer_timeout constant number := 1800;

----------------------------------------------------------------------------

-- types

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
    bdoc blob,
    cdoc clob);

 -------------------------------------------------------------
 type t_add_param is record(
    param_type varchar2(10), --get/header
    tag varchar2(30), --тег
    value varchar2(255));
 type t_add_params is table of t_add_param index by pls_integer;


 type varchar2_list is table of varchar2(255) index by pls_integer;


procedure send_loger(p_req_id  number,
                      p_act     varchar2,
                      p_state   varchar2,
                      p_message varchar2,
                      p_sub_req number default null,
                      p_chk_req number default null,
                      loging    number default 1);
procedure send_req(p_start_id number, p_last_id number);

procedure prep_req(p_sess_id number);


  procedure resive(p_type    in varchar2,
                  p_body    in out clob,
                  p_params  in out clob,
                  p_err_txt varchar2);

  procedure send(p_body       clob,
                   p_add_params t_add_params,
                   p_send_type  varchar2,
                   p_send_kf    varchar2,
                   p_main_sess  out number);

  procedure send_group(p_body clob, p_add_params t_add_params, p_send_type varchar2, p_send_list varchar2_list, p_main_sess out number);

  procedure resive_status_ok(p_res_id number);

  procedure resive_status_err(p_res_id number, p_errmesage varchar2);

  procedure resive_status_start(p_res_id number);

  procedure resive_status_exec(p_res_id number);

  procedure chk_proc(p_type Varchar2, p_id number, p_resp out number, p_err out varchar2);

  procedure crt_date(p_type varchar2, p_resp number, p_err varchar2);


end transp_utl;
/
create or replace package body transp_utl is

  -- Private type declarations
  --type <TypeName> is <Datatype>;

  -- Private constant declarations
  --<ConstantName> constant <Datatype> := <Value>;

  -- Private variable declarations
  --<VariableName> <Datatype>;

  -- Function and procedure implementations
  --function <FunctionName>(<Parameter> <Datatype>) return <Datatype> is
  --  <LocalVariable> <Datatype>;
 -- begin
  --  <Statement>;
  --  return(<Result>);
 -- end;
  g_body_version  constant varchar2(64) := 'version 1.0 14/02/2018';

  -- g_service_url varchar2(256);

  g_request  t_request;
  -- g_response t_response;

  g_xmlhead  constant varchar2(100) := '<?xml version="1.0" encoding="utf-8"?>';

 procedure send_loger(p_req_id  number,
                      p_act     varchar2,
                      p_state   varchar2,
                      p_message varchar2,
                      p_sub_req number default null,
                      p_chk_req number default null,
                      loging    number default 1) is
     pragma autonomous_transaction;
     l_id number;
 begin
     if loging = 1 then
         l_id := s_transp_send_log.nextval;
         insert into transp_send_log
         values
             (l_id,
              p_req_id,
              p_sub_req,
              p_chk_req,
              p_act,
              p_state,
              p_message,
              localtimestamp);
         commit;
     end if;
 end;

 function encode_base64(p_blob in blob) return clob is
            l_clob           clob;
            l_result         clob;
            l_offset         integer;
            l_chunk_size     binary_integer := 23808;
            l_buffer_varchar varchar2(32736);
            l_buffer_raw     raw(32736);
          begin
            if (p_blob is null) then
              return null;
            end if;

            dbms_lob.createtemporary(l_clob, false);

            l_offset := 1;
            for i in 1 .. ceil(dbms_lob.getlength(p_blob) / l_chunk_size) loop
              dbms_lob.read(p_blob, l_chunk_size, l_offset, l_buffer_raw);
              l_buffer_raw     := utl_encode.base64_encode(l_buffer_raw);
              l_buffer_varchar := utl_raw.cast_to_varchar2(l_buffer_raw);
              dbms_lob.writeappend(l_clob, length(l_buffer_varchar), l_buffer_varchar);
              l_offset := l_offset + l_chunk_size;
            end loop;

            l_result := l_clob;
            dbms_lob.freetemporary(l_clob);

            return l_result;
        end;

 function decode_base64(p_clob_in in clob) return blob is
        l_blob           blob;
        l_result         blob;
        l_offset         integer;
        l_buffer_size    binary_integer := 32736;
        l_buffer_varchar varchar2(32736);
        l_buffer_raw     raw(32736);
      begin
        if p_clob_in is null then
          return null;
        end if;

        dbms_lob.createtemporary(l_blob, false);
        l_offset := 1;

        for i in 1 .. ceil(dbms_lob.getlength(p_clob_in) / l_buffer_size) loop
          dbms_lob.read(p_clob_in, l_buffer_size, l_offset, l_buffer_varchar);
          l_buffer_raw := utl_raw.cast_to_raw(l_buffer_varchar);
          l_buffer_raw := utl_encode.base64_decode(l_buffer_raw);
          dbms_lob.writeappend(l_blob, utl_raw.length(l_buffer_raw), l_buffer_raw);
          l_offset := l_offset + l_buffer_size;
        end loop;

        l_result := l_blob;
        dbms_lob.freetemporary(l_blob);

        return l_result;
    end;

    function blob_to_clob(p_blob in blob) return clob is
    l_clob         clob;
    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
  begin

    dbms_lob.createtemporary(l_clob, false);

    dbms_lob.converttoclob(dest_lob     => l_clob,
                           src_blob     => p_blob,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_offset,
                           src_offset   => l_src_offset,
                           blob_csid    => l_blob_csid,
                           lang_context => l_lang_context,
                           warning      => l_warning);
    return l_clob;
  end;

  function clob_to_blob(p_clob in clob) return blob is
    l_blob         blob;
    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
  begin

    dbms_lob.createtemporary(l_blob, false);


    dbms_lob.converttoblob(dest_lob     => l_blob,
                           src_clob     => p_clob,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_offset,
                           src_offset   => l_src_offset,
                           blob_csid    => l_blob_csid,
                           lang_context => l_lang_context,
                           warning      => l_warning);
    return l_blob;
  end;

  function blob2num(p_blob blob,
                    p_len  integer,
                    p_pos  integer) return number is
    rv number;
  begin
    rv := utl_raw.cast_to_binary_integer(dbms_lob.substr(p_blob,
                                                         p_len,
                                                         p_pos),
                                         utl_raw.little_endian);
    if rv < 0 then
      rv := rv + 4294967296;
    end if;
    return rv;
  end;

  function little_endian( p_big number, p_bytes pls_integer := 4 )
  return raw
  is
    t_big number := p_big;
  begin
    if t_big > 2147483647
    then
      t_big := t_big - 4294967296;
    end if;
    return utl_raw.substr( utl_raw.cast_from_binary_integer( t_big, utl_raw.little_endian ), 1, p_bytes );
  end;

  function get_filefromzip(p_zipped_blob blob) return blob is
    t_tmp      blob;
    t_ind      integer;
    t_hd_ind   integer;
    t_fl_ind   integer;
    t_len      integer;
    c_END_OF_CENTRAL_DIRECTORY constant raw(4) := hextoraw( '504B0506' ); -- End of central directory signature for zip
  begin
    t_ind := nvl(dbms_lob.getlength(p_zipped_blob), 0) - 21;
    loop
      exit when t_ind < 1 or dbms_lob.substr(p_zipped_blob, 4, t_ind) = c_end_of_central_directory;
      t_ind := t_ind - 1;
    end loop;
    --
    if t_ind <= 0 then
      return null;
    end if;
    --
    t_hd_ind := blob2num(p_zipped_blob, 4, t_ind + 16) + 1;
    for i in 1 .. blob2num(p_zipped_blob, 2, t_ind + 8)
    loop
        t_len := blob2num(p_zipped_blob, 4, t_hd_ind + 24); -- uncompressed length
        if t_len = 0 then
            -- empty file
            return empty_blob();
        end if;
        --
        if dbms_lob.substr(p_zipped_blob, 2, t_hd_ind + 10) in
           (hextoraw('0800') -- deflate
           ,
            hextoraw('0900') -- deflate64
            ) then
          t_fl_ind := blob2num(p_zipped_blob, 4, t_hd_ind + 42);
          t_tmp    := hextoraw('1F8B0800000000000003'); -- gzip header
          dbms_lob.copy(t_tmp,
                        p_zipped_blob,
                        blob2num(p_zipped_blob, 4, t_hd_ind + 20),
                        11,
                        t_fl_ind + 31 +
                        blob2num(p_zipped_blob, 2, t_fl_ind + 27) -- File name length
                        + blob2num(p_zipped_blob, 2, t_fl_ind + 29) -- Extra field length
                        );
          dbms_lob.append(t_tmp,
                          utl_raw.concat(dbms_lob.substr(p_zipped_blob,
                                                         4,
                                                         t_hd_ind + 16) -- CRC32
                                        ,
                                         little_endian(t_len) -- uncompressed length
                                         ));
          return utl_compress.lz_uncompress(t_tmp);
        end if;
        --
        if dbms_lob.substr(p_zipped_blob, 2, t_hd_ind + 10) =
           hextoraw('0000') -- The file is stored (no compression)
         then
          t_fl_ind := blob2num(p_zipped_blob, 4, t_hd_ind + 42);
          dbms_lob.createtemporary(t_tmp, true);
          dbms_lob.copy(t_tmp,
                        p_zipped_blob,
                        t_len,
                        1,
                        t_fl_ind + 31 +
                        blob2num(p_zipped_blob, 2, t_fl_ind + 27) -- File name length
                        + blob2num(p_zipped_blob, 2, t_fl_ind + 29) -- Extra field length
                        );
          return t_tmp;
        end if;
      t_hd_ind := t_hd_ind + 46 + blob2num(p_zipped_blob, 2, t_hd_ind + 28) -- File name length
                  + blob2num(p_zipped_blob, 2, t_hd_ind + 30) -- Extra field length
                  + blob2num(p_zipped_blob, 2, t_hd_ind + 32); -- File comment length
    end loop;
    --
    return null;
  end;

     function unpacking (p_body in blob, c_type varchar2 default null)
      return blob
   is
      l_blob   blob;
   begin
      l_blob := utl_compress.lz_uncompress (p_body);
      return l_blob;
   end;

   function packing (p_body in blob, c_type varchar2 default null)
      return blob
   is
      l_blob   blob;
   begin
      l_blob := utl_compress.lz_compress (p_body);
      return l_blob;
   end packing;

 -- URL-кодирует строку
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
  -- декодирует URL-кодированную строку
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


  -- инициализация \ подготовка запроса
  --
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
    if (instr(lower(p_url), 'https') = 1 and (p_wallet_path is null or p_wallet_pwd is null)) then
      raise_application_error(-20001, 'Для SSL з`єднання необхідно вказати параметри Wallet', false);
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
    if g_request.body  is null then
      dbms_lob.createtemporary(g_request.body,false);
    end if;

  end;
  --------------------------------------------------------------------------------
  -- добавляет параметр в запрос
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
  -- добавляет параметр в заголовок запроса
  --
  procedure add_header(p_name in varchar2, p_value in varchar2) as
    l_header t_header;
  begin
    l_header.p_header_name := p_name;
    l_header.p_header_value := p_value;
    g_request.headers(g_request.headers.count + 1) := l_header;
  end;

  -- вызов подготовленого запроса WebApi
  --

  procedure execute_api(
      p_response out clob)
  as
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
      l_response_raw raw(2000);
      eob            boolean;
  begin
    --trace_info('g_request.http_method=' || g_request.http_method );

    select value into l_db_charset from nls_database_parameters where parameter = 'NLS_CHARACTERSET';

    utl_http.set_transfer_timeout(g_transfer_timeout);

    -- SSL соединение выполняем через wallet
    if (instr(lower(g_request.url), 'https://') > 0) then
      utl_http.set_wallet(g_request.wallet_path, g_request.wallet_pwd);
    end if;

    -- add GET parameters to url
    for i in 1 .. g_request.parameters.count loop
      l_parameter := g_request.parameters(i);
      --trace_info('parameter: p_param_name=[' || l_parameter.p_param_name || '], p_param_value=[' || substr(l_parameter.p_param_value, 1, 2000) || ']');

      l_param_value  := url_encode(l_parameter.p_param_value);
      g_request.url := g_request.url || case
                            when i = 1 then
                             '?'
                            else
                             '&'
                          end || l_parameter.p_param_name || '=' || l_param_value;
    end loop;

    begin
      l_http_req := utl_http.begin_request(g_request.url, g_request.http_method, g_http_version);
    exception
      when others then
        if sqlcode = -29273 then
          raise_application_error(-20001, 'Не запущено сервіс за адресою [' || g_request.url || ']' || sqlerrm, false);
        else
          raise;
        end if;
    end;

    -- header
    for i in 1 .. g_request.headers.count loop
      l_header := g_request.headers(i);
      utl_http.set_header(l_http_req, l_header.p_header_name, l_header.p_header_value);
    end loop;

    -- тело запроса - blob
    if (g_request.blob_body is not null) then
        l_length := dbms_lob.getlength(g_request.blob_body);
        utl_http.set_header(r     => l_http_req,
                            name  => 'Content-Length',
                            value => l_length);

        l_offset := 1;
        while (l_offset < l_length) loop
            dbms_lob.read(g_request.blob_body, l_ammount, l_offset, l_buffer);
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
            l_tmp := utl_raw.cast_to_raw(dbms_lob.substr(g_request.body, l_length, 1));
          else
            l_tmp := utl_raw.convert(utl_raw.cast_to_raw(dbms_lob.substr(g_request.body, l_length, 1)),'american_america.al32utf8', 'american_america.'||lower(l_db_charset) );
          end if;

          utl_http.set_header(r     => l_http_req,
                              name  => 'Content-Length',
                              value => utl_raw.length(l_tmp) );

          utl_http.write_raw(l_http_req, l_tmp);
        elsif (l_length > 32767) then
          -- если длина xml-данных больше 32Кб
          -- тело запроса по кусочкам
          while (l_offset < l_length) loop
            dbms_lob.read(g_request.body, l_ammount, l_offset, l_buffer);
            if l_db_charset = 'AL32UTF8' then
              l_tmp := utl_raw.cast_to_raw(l_buffer);
            else
              l_tmp := utl_raw.convert(utl_raw.cast_to_raw(l_buffer),'american_america.al32utf8', 'american_america.'||lower(l_db_charset));
            end if;
            utl_http.write_raw(l_http_req, l_tmp);
            l_offset := l_offset + l_ammount;
          end loop;
        end if;
    end if;

    l_http_resp := utl_http.get_response(l_http_req);

    -- set response code, response http header and response cookies global
    g_status_code := l_http_resp.status_code;
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
    while not(eob)
    loop
      begin
        utl_http.read_raw(l_http_resp, l_response_raw, 2000);

        if l_db_charset = 'AL32UTF8' then
          l_buffer := utl_raw.cast_to_varchar2(l_response_raw);
        else
          l_buffer := utl_raw.cast_to_varchar2(utl_raw.convert(l_response_raw, 'american_america.'||lower(l_db_charset), 'american_america.al32utf8'));
        end if;

        if l_buffer is not null and length(l_buffer)>0 then
          dbms_lob.writeappend(l_result, length(l_buffer), l_buffer);
        end if;
      exception when utl_http.end_of_body then
        eob := true;
      end;
    end loop;


    utl_http.end_response(l_http_resp);

    bars.bars_audit.log_info('trans_utl.execute_api',
                             'g_status_code : ' || g_status_code || chr(10) ||
                             'url           : ' || g_request.url,
                             p_auxiliary_info => l_result);

    p_response := l_result;
  end;
 -------------------------------------------------------------------------------------------------------------------
    procedure run_parallel(p_task           in varchar2,
                           p_chunk          in varchar2,
                           p_stmt           in varchar2,
                           p_parallel_level number) is
    begin
          dbms_parallel_execute.create_task(p_task);
          dbms_parallel_execute.create_chunks_by_sql(p_task, p_chunk, false);
          dbms_parallel_execute.run_task(p_task,
                                         p_stmt,
                                         dbms_sql.native,
                                         parallel_level => p_parallel_level);
          dbms_parallel_execute.drop_task(p_task);
    end;
-------------------------------------------------------------------------------------------------------
function crt_xml_params(p_req_id number) return clob is
    l_clob        clob;
    l_doc         dbms_xmldom.domdocument;
    l_root_node   dbms_xmldom.domnode;
    l_main_node   dbms_xmldom.domnode; --root
    l_heads_node  dbms_xmldom.domnode; --heads
    l_head_node   dbms_xmldom.domnode; --head
    l_value_node  dbms_xmldom.domnode;
    l_txt_node    dbms_xmldom.domnode;

    procedure lg_add_text_elem(m_node    dbms_xmldom.domnode,
                               node_name varchar2,
                               node_val  varchar2,
                               lp_doc    dbms_xmldom.domdocument) is
    begin
        l_value_node := dbms_xmldom.appendchild(m_node,
                                                dbms_xmldom.makenode(dbms_xmldom.createelement(lp_doc,
                                                                                               node_name)));

        l_txt_node := dbms_xmldom.appendchild(l_value_node,
                                              dbms_xmldom.makenode(dbms_xmldom.createtextnode(lp_doc,
                                                                                              node_val)));
    end;

begin
    dbms_lob.createtemporary(l_clob, true, 2);
    -- Create an empty XML document
    l_doc := dbms_xmldom.newdomdocument;
    dbms_xmldom.setVersion(l_doc, '1.0" encoding="utf-8');
    -- Create a root node
    l_root_node := dbms_xmldom.makenode(l_doc);
    -- Create a new Supplier Node and add it to the root node
    l_main_node := dbms_xmldom.appendchild(l_root_node,
                                           dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,
                                                                                          'root')));

    l_heads_node := dbms_xmldom.appendchild(l_main_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,
                                                                                           'headparams')));
    for param in (select p.param_type, p.tag, p.value
                    from transp_receive_resp_params p
                   where p.resp_id = p_req_id) loop
        l_head_node := dbms_xmldom.appendchild(l_heads_node,
                                               dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,
                                                                                              'headparam')));
        lg_add_text_elem(l_head_node, 'tag', param.tag, l_doc);
        lg_add_text_elem(l_head_node, 'value', param.value, l_doc);
    end loop;

        l_head_node := dbms_xmldom.appendchild(l_heads_node,
                                               dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,
                                                                                              'headparam')));
        lg_add_text_elem(l_head_node, 'tag', 'qqq', l_doc);
        lg_add_text_elem(l_head_node, 'value', 'www', l_doc);

        l_head_node := dbms_xmldom.appendchild(l_heads_node,
                                               dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,
                                                                                              'headparam')));
        lg_add_text_elem(l_head_node, 'tag', 'qqq', l_doc);
        lg_add_text_elem(l_head_node, 'value', 'www', l_doc);


    for param in (select t.id,
                         t.type_name,
                         t.type_desc,
                         t.sess_type,
                         t.act_type,
                         t.loging,
                         t.s_prior,
                         t.data_type,
                         t.cont_type,
                         t.conv_2_json,
                         t.compress_type,
                         t.base_64,
                         t.check_sum
                    from barstrans.transp_receive_type t
                   where t.id = (select d.type_id
                                   from barstrans.transp_receive_data d
                                  where d.id = p_req_id)) loop
        lg_add_text_elem(l_main_node, 'cont_type', param.cont_type, l_doc);
        lg_add_text_elem(l_main_node, 'conv_2_json', param.conv_2_json, l_doc);
        lg_add_text_elem(l_main_node, 'compress_type', param.compress_type, l_doc);
        lg_add_text_elem(l_main_node, 'base_64', param.base_64, l_doc);
        lg_add_text_elem(l_main_node, 'check_sum', param.check_sum, l_doc);
    end loop;

    dbms_xmldom.writetoclob(l_doc, l_clob);
    dbms_xmldom.freedocument(l_doc);
    return l_clob;

end;



    procedure pars_uri_params(p_req_id number, p_uri_params clob) is

    l_parser            dbms_xmlparser.parser;
    l_doc               dbms_xmldom.domdocument;
    l_params            dbms_xmldom.DOMNodeList;
    l_param             dbms_xmldom.DOMNode;

    type t_reqsw        is table of transp_receive_uri_params%rowtype;
    tr_reqsw            t_reqsw := t_reqsw();

    function l_get_node_val(p_node dbms_xmldom.DOMNode, p_node_name varchar2) return varchar2 is
      ll_temp varchar2(4000);
      begin
      dbms_xslprocessor.valueof(p_node, p_node_name||'/text()', ll_temp);
      ll_temp:=utl_i18n.unescape_reference(trim(ll_temp));
      ll_temp:=utl_i18n.unescape_reference(ll_temp);
      return ll_temp;
      end;
 begin
 l_parser := dbms_xmlparser.newparser;
  dbms_xmlparser.parseclob(l_parser, p_uri_params);
  l_doc := dbms_xmlparser.getdocument(l_parser);
  l_params := dbms_xmldom.getelementsbytagname(l_doc, 'getparam');

  for i in 0 .. dbms_xmldom.getlength(l_params)-1
  loop
     l_param := dbms_xmldom.item(l_params, i);
     tr_reqsw.extend;
     tr_reqsw(tr_reqsw.last).req_id:= p_req_id;
     tr_reqsw(tr_reqsw.last).param_type:= 'GET';
     tr_reqsw(tr_reqsw.last).tag:= upper(l_get_node_val(l_param, 'tag'));
     tr_reqsw(tr_reqsw.last).value:= l_get_node_val(l_param, 'value');
  end loop;

  l_params := dbms_xmldom.getelementsbytagname(l_doc, 'headparam');

  for i in 0 .. dbms_xmldom.getlength(l_params)-1
  loop
     l_param := dbms_xmldom.item(l_params, i);
     tr_reqsw.extend;
     tr_reqsw(tr_reqsw.last).req_id:= p_req_id;
     tr_reqsw(tr_reqsw.last).param_type:= 'HEADER';
     tr_reqsw(tr_reqsw.last).tag:= upper(l_get_node_val(l_param, 'tag'));
     tr_reqsw(tr_reqsw.last).value:= l_get_node_val(l_param, 'value');
  end loop;

  forall j in tr_reqsw.first .. tr_reqsw.last
      insert into transp_receive_uri_params values tr_reqsw(j);
      tr_reqsw.delete;
  dbms_xmlparser.freeparser(l_parser);
  DBMS_XMLDOM.freeDocument(l_doc);
 end;
---------------------------------------------------------------------------

 procedure resive(p_type    in varchar2,
                  p_body    in out clob,
                  p_params  in out clob,
                  p_err_txt varchar2) is
     l_reqtype transp_receive_type%rowtype;
     l_req_id  number;
     l_jobname varchar2(50);
     l_clob    clob;
     l_blob    blob;
 begin
     begin
         select ID,
                TYPE_NAME,
                TYPE_DESC,
                SESS_TYPE,
                ACT_TYPE,
                LOGING,
                S_PRIOR,
                DATA_TYPE,
                CONT_TYPE,
                CONV_2_JSON,
                COMPRESS_TYPE,
                BASE_64,
                CHECK_SUM
           into l_reqtype
           from transp_receive_type t
          where t.TYPE_NAME = upper(p_type);
     exception
         when no_data_found then
             raise_application_error(-20000,
                                     'Невідомий тип запиту "' || p_type || '"');
     end;
     l_req_id := s_transp_receive_data.nextval;

     if l_reqtype.BASE_64 = 1 and l_reqtype.COMPRESS_TYPE is not null then
         l_blob := decode_base64(p_body);
     elsif l_reqtype.BASE_64 = 1 and l_reqtype.COMPRESS_TYPE is null then
         l_clob := blob_to_clob(decode_base64(p_body));
     else
         l_clob := p_body;
     end if;

     if l_reqtype.COMPRESS_TYPE is not null then
         l_blob := unpacking(l_blob, l_reqtype.COMPRESS_TYPE);
         l_clob := blob_to_clob(l_blob);
     end if;

     insert into transp_receive_data
     values
         (l_req_id, l_reqtype.id, l_clob, null, localtimestamp, 0, null);

     pars_uri_params(l_req_id, p_params);

     if l_reqtype.act_type is not null and l_reqtype.sess_type = 1 then
         begin
             l_jobname := 'transp_utl_proc_sess_' || l_req_id;
             dbms_scheduler.create_job(job_name   => l_jobname,
                                       job_type   => 'PLSQL_BLOCK',
                                       job_action => 'begin ' ||
                                                     l_reqtype.act_type || '(' ||
                                                     l_req_id || '); end;',
                                       auto_drop  => true,
                                       enabled    => true);
         exception
             when others then
                 dbms_scheduler.drop_job(l_jobname, force => true);
                 raise;
         end;
     elsif l_reqtype.act_type is not null and l_reqtype.sess_type = 0 then
         begin
             execute immediate 'begin ' || l_reqtype.act_type || ' end;'
                 using l_req_id;
         end;
     end if;
 begin
     select r.d_clob, r.d_blob
       into l_clob, l_blob
       from transp_receive_resp r
      where id = l_req_id;
    exception when no_data_found then
        null;
        l_clob:= to_clob(l_req_id);
end;
     if length(l_clob) > 0 then
         p_body := l_clob;
     else
         p_body := blob_to_clob(l_blob);
     end if;
     p_params := crt_xml_params(l_req_id);
 end;
-------------------------------------------------------------------------------------------------------------------------------
 procedure send_req(p_start_id number, p_last_id number)
 is
     l_response       clob;
     l_wallet_path    varchar2(255);
     l_wallet_pwd     varchar2(255);
     l_send_uri       transp_uri%rowtype;
     l_send_type      transp_send_type%rowtype;
     l_clob           clob;
     l_attempts_count integer := 0;
     l_success_flag   boolean := false;
 begin

     for req in (select q.id, q.main_id, q.uri_id, q.type_id, q.state_id
                   from barstrans.transp_send_req q
                  where q.id between p_start_id and p_last_id) loop

         select u.uri_id,
                u.uri_desc,
                u.send_type,
                u.base_host,
                u.req_path,
                u.chk_path,
                u.auth_user,
                u.auth_path,
                u.is_active,
                u.is_local,
                u.is_default,
                u.kf
           into l_send_uri
           from transp_uri u
          where u.uri_id = req.uri_id
            and u.is_active = 1;

         select t.id,
                t.type_name,
                t.type_desc,
                t.sess_type,
                t.is_parallel,
                t.http_method,
                t.main_timeout,
                t.trys,
                t.proc_chk,
                t.loging,
                t.s_prior,
                t.chk_pause,
                t.chk_timeout,
                t.data_type,
                t.cont_type,
                t.acc_cont_type,
                t.conv_2_json,
                t.compress_type,
                t.base_64,
                t.check_sum,
                t.store_sess_id
           into l_send_type
           from transp_send_type t
          where t.id = req.type_id;

         select q.req_date
         into   l_clob
         from   barstrans.transp_send_main_req q
         where  id = req.main_id;

         l_wallet_path := bars.branch_attribute_utl.get_attribute_value('/', 'PATH_FOR_ABSBARS_WALLET');
         l_wallet_pwd := bars.branch_attribute_utl.get_attribute_value('/', 'PASS_FOR_ABSBARS_WALLET');

         prepare_request(p_url         => g_proxy_url,
                         p_http_method => g_http_post,
                         p_wallet_path => l_wallet_path,
                         p_wallet_pwd  => l_wallet_pwd,
                         p_body        => l_clob);
         for param in (select param_type, tag, value
                         from barstrans.transp_send_req_params qp
                        where qp.data_id = req.main_id) loop
             if param.param_type = 'GET' then
                 add_parameter(p_name => param.tag, p_value => param.value);
             elsif param.param_type = 'HEADER' then
                 add_header(p_name  => 'MyReqHead' || param.tag,
                            p_value => param.value);
             end if;
         end loop;

         add_header(p_name  => 'Content-Type',
                    p_value => g_ct_xml || '; ' || g_cc_utf8);
         add_header(p_name  => 'MyProxyMethod',
                    p_value => l_send_type.http_method);
         add_header(p_name  => 'MyProxyAccCT',
                    p_value => l_send_type.acc_cont_type);
         add_header(p_name  => 'MyProxyCT',
                    p_value => l_send_type.cont_type);
         add_header(p_name  => 'MyProxyTimeout',
                    p_value => 300000 /*l_send_type.timeout*/); -- milliseconds
         add_header(p_name  => 'MyProxyURI',
                    p_value => l_send_uri.base_host || l_send_uri.req_path || '/' ||
                               l_send_type.type_name);
         add_header(p_name  => 'MyReqHeadAuthorization',
                    p_value => 'Basic ' ||
                               utl_encode.text_encode(l_send_uri.auth_user || ':' ||
                                                      l_send_uri.auth_path,
                                                      encoding => utl_encode.base64));

         loop
             l_attempts_count := l_attempts_count + 1;

             begin
                 execute_api(l_response);

                 if (g_status_code = 200) then
                     send_loger(req.main_id, 'WEB_SERVICE_SEND' || req.id, 'INFO', 'Data sent');

                     update transp_send_req s
                     set    s.send_time = sysdate
                     where  s.id = req.id;

                     l_success_flag := true;
                 else
                      send_loger(req.main_id,
                                 'WEB_SERVICE_SEND' || req.id,
                                 'ERROR',
                                 substrb('Attempt: ' || l_attempts_count || chr(10) || dbms_lob.substr(l_response, 4000), 1, 4000));
                 end if;
             exception
                 when others then
                      send_loger(req.main_id,
                                 'WEB_SERVICE_SEND' || req.id,
                                 'ERROR',
                                 substrb('Attempt: ' || l_attempts_count || chr(10) ||
                                         sqlerrm || chr(10) || dbms_utility.format_error_backtrace() || chr(10) ||
                                         dbms_lob.substr(l_response, 4000), 1, 4000));
             end;

             exit when (l_success_flag or l_attempts_count >= nvl(l_send_type.trys, 1));
         end loop;

         if (l_response is not null) then
             if (regexp_like(l_response, '^\d+$')) then
                 update transp_send_req rq
                 set    rq.resp_num = to_number(l_response)
                 where  rq.id = req.id;
             else
                  update transp_send_req rq
                  set    rq.resp_clob = l_response
                  where  rq.id = req.id;
             end if;
         end if;

         for i in 1..g_headers.count loop
             if substr(g_headers(i).p_header_name,1,10) = 'MyRespHead' then
             insert into transp_send_resp_params values(req.id, 'HEADER', substr(g_headers(i).p_header_name,11), g_headers(i).p_header_value);
             end if;
         end loop;

         g_request.headers.delete;
         g_request.parameters.delete;
     end loop;
 end;
-------------------------------------------------------------------------------------------------------------
  procedure prep_req(p_sess_id number) is
      l_reqtype     transp_send_type%rowtype;
      l_TYPE_ID     transp_send_main_req.send_type%type;
      l_parallel_ch number;
      l_start_id    number;
      l_end_id      number;
      l_chunk       varchar2(4000);
      l_stmt        varchar2(4000);
      l_blob        blob;
      l_clob        clob;
  begin
      begin
          SELECT Q.SEND_TYPE, C_DATA, B_DATA
            into l_TYPE_ID, l_clob, l_blob
            FROM BARSTRANS.transp_send_main_req Q
           WHERE Q.ID = p_sess_id;

          select t.id,
                 t.type_name,
                 t.type_desc,
                 t.sess_type,
                 t.is_parallel,
                 t.http_method,
                 t.main_timeout,
                 t.trys,
                 t.proc_chk,
                 t.loging,
                 t.s_prior,
                 t.chk_pause,
                 t.chk_timeout,
                 t.data_type,
                 t.cont_type,
                 t.acc_cont_type,
                 t.conv_2_json,
                 t.compress_type,
                 t.base_64,
                 t.check_sum,
                 t.store_sess_id
            into l_reqtype
            FROM BARSTRANS.TRANSP_SEND_TYPE t
           where t.id = l_TYPE_ID;
      exception
          when no_data_found then
              send_loger(p_sess_id,
                         'SELECT_TRANSP_TYPE',
                         'ERROR',
                         'Невідомий тип запиту з ІД "' || l_TYPE_ID || '"');
              raise_application_error(-20000,
                                      'Невідомий тип запиту з ІД "' ||
                                      l_TYPE_ID || '"');
      end;

      if l_reqtype.COMPRESS_TYPE is not null then
          IF LENGTH(l_clob) > 0 THEN
              l_blob := clob_to_blob(l_clob);
          end if;
          l_blob := packing(l_blob, l_reqtype.COMPRESS_TYPE);
      end if;

      if l_reqtype.BASE_64 = 1 and l_reqtype.COMPRESS_TYPE is not null then
          l_clob := encode_base64(l_blob);
      elsif l_reqtype.BASE_64 = 1 and l_reqtype.COMPRESS_TYPE is null then
          IF LENGTH(l_clob) > 0 THEN
              l_blob := clob_to_blob(l_clob);
          end if;
          l_clob := encode_base64(l_blob);
      end if;

      update transp_send_main_req q
      set q.req_date = l_clob
      where q.id = p_sess_id;

      if l_reqtype.is_parallel <> 0 then
          l_chunk := 'select t.id as start_id, t.id as end_id
        from transp_send_req t where t.main_id  = ' ||
                     p_sess_id;

          l_stmt := 'begin
                    transp_utl.send_req(:start_id, :end_id);
                 end;';

          if l_reqtype.is_parallel <> 1 then
              l_parallel_ch := l_reqtype.is_parallel;
          else
              select count(q.id) + 1
                into l_parallel_ch
                from transp_send_req q
               where q.main_id = p_sess_id;
          end if;

          run_parallel('transp_utl_send_ru' || to_char(p_sess_id),
                       l_chunk,
                       l_stmt,
                       l_parallel_ch);
      else
          select min(t.id) as start_id, max(t.id) as end_id
            into l_start_id, l_end_id
            from transp_send_req t
           where t.main_id = p_sess_id;

          transp_utl.send_req(l_start_id, l_end_id);
      end if;

  end;






    --send clob with get params----------------------------------------------------------------------------
    procedure send_group(p_body       clob,
                         p_add_params t_add_params,
                         p_send_type  varchar2,
                         p_send_list  varchar2_list,
                         p_main_sess  out number) is
        --asinc/parallel
        l_reqtype   transp_send_type%rowtype;
        l_main_sess number;
        l_sub_sess  number;
        l_uri_id    number;
        l_jobname   varchar2(50);

    begin
        --ІД основного запиту
        l_main_sess := s_transp_send_main_req.nextval;
        --визначаємо тип запиту
        begin
            select t.id,
                   t.type_name,
                   t.type_desc,
                   t.sess_type,
                   t.is_parallel,
                   t.http_method,
                   t.main_timeout,
                   t.trys,
                   t.proc_chk,
                   t.loging,
                   t.s_prior,
                   t.chk_pause,
                   t.chk_timeout,
                   t.data_type,
                   t.cont_type,
                   t.acc_cont_type,
                   t.conv_2_json,
                   t.compress_type,
                   t.base_64,
                   t.check_sum,
                   t.store_sess_id
              into l_reqtype
              FROM BARSTRANS.TRANSP_SEND_TYPE t
             where t.type_name = p_send_type;
        exception
            when no_data_found then
                send_loger(l_main_sess,
                           'SELECT_TRANSP_TYPE',
                           'ERROR',
                           'Невідомий тип запиту з ІД "' || p_send_type || '"');
                raise_application_error(-20000,
                                        'Невідомий тип запиту з ІД "' ||
                                        p_send_type || '"');
        end;
        --додаємо данні та та статус
        insert into transp_send_main_req
            (id, send_type, c_data, ins_date, status)
        values
            (l_main_sess, l_reqtype.id, p_body, localtimestamp, 0);
        send_loger(l_main_sess,
                   'INSERT_SEND_DATA',
                   'INFO',
                   'DATE INSERTED');
        --додаємо дані/переметри GET/HEADER
        for i in 1 .. p_add_params.count loop
            insert into transp_send_req_params
            values
                (l_main_sess,
                 p_add_params(i).param_type,
                 p_add_params(i).tag,
                 p_add_params(i).value);
        end loop;
        send_loger(l_main_sess,
                   'INSERT_SEND_URI_PARAMS',
                   'INFO',
                   'DATE INSERTED');
        --формуємо перелік підзапитів
        for i in 1 .. p_send_list.count loop
            l_sub_sess := s_transp_send_req.nextval;
            select uri_id
              into l_uri_id
              from transp_uri t
             where t.kf = p_send_list(i);
            insert into transp_send_req
                (id, main_id, uri_id, type_id, insert_time, state_id)
            values
                (l_sub_sess,
                 l_main_sess,
                 l_uri_id,
                 l_reqtype.id,
                 sysdate,
                 0);
        end loop;
        p_main_sess := l_main_sess;
        commit;
        if l_reqtype.sess_type = 1 then
            begin
                l_jobname := 'transp_utl_send_sess_' || l_main_sess;
                dbms_scheduler.create_job(job_name   => l_jobname,
                                          job_type   => 'PLSQL_BLOCK',
                                          job_action => 'begin barstrans.transp_utl.prep_req(' ||
                                                        l_main_sess ||
                                                        '); end;',
                                          auto_drop  => true,
                                          enabled    => true);
            exception
                when others then
                    dbms_scheduler.drop_job(l_jobname, force => true);
                    raise;
            end;
        else
            prep_req(l_main_sess);
        end if;
    end;
--------------------------------------------------------------------------------------------------------------------------
    procedure send(p_body       clob,
                   p_add_params t_add_params,
                   p_send_type  varchar2,
                   p_send_kf    varchar2,
                   p_main_sess  out number) is
        --asinc/parallel
        l_reqtype   transp_send_type%rowtype;
        l_main_sess number;
        l_sub_sess  number;
        l_uri_id    number;
    begin
        --ІД основного запиту
        l_main_sess := s_transp_send_main_req.nextval;
        --визначаємо тип запиту
        begin
            select t.id,
                   t.type_name,
                   t.type_desc,
                   t.sess_type,
                   t.is_parallel,
                   t.http_method,
                   t.main_timeout,
                   t.trys,
                   t.proc_chk,
                   t.loging,
                   t.s_prior,
                   t.chk_pause,
                   t.chk_timeout,
                   t.data_type,
                   t.cont_type,
                   t.acc_cont_type,
                   t.conv_2_json,
                   t.compress_type,
                   t.base_64,
                   t.check_sum,
                   t.store_sess_id
              into l_reqtype
              FROM BARSTRANS.TRANSP_SEND_TYPE t
             where t.type_name = p_send_type;
        exception
            when no_data_found then
                send_loger(l_main_sess,
                           'SELECT_TRANSP_TYPE',
                           'ERROR',
                           'Невідомий тип запиту з ІД "' || p_send_type || '"');
                raise_application_error(-20000,
                                        'Невідомий тип запиту з ІД "' ||
                                        p_send_type || '"');
        end;
        --додаємо данні та та статус
        insert into transp_send_main_req
            (id, send_type, c_data, ins_date, status)
        values
            (l_main_sess, l_reqtype.id, p_body, localtimestamp, 0);
        send_loger(l_main_sess,
                   'INSERT_SEND_DATA',
                   'INFO',
                   'DATE INSERTED');
        --додаємо дані/переметри GET/HEADER
        for i in 1 .. p_add_params.count loop
            insert into transp_send_req_params
            values
                (l_main_sess,
                 p_add_params(i).param_type,
                 p_add_params(i).tag,
                 p_add_params(i).value);
        end loop;
        send_loger(l_main_sess,
                   'INSERT_SEND_URI_PARAMS',
                   'INFO',
                   'DATE INSERTED');
        --формуємо перелік підзапитів
            l_sub_sess := s_transp_send_req.nextval;
            select uri_id
              into l_uri_id
              from transp_uri t
             where t.kf = p_send_kf;
            insert into transp_send_req
                (id, main_id, uri_id, type_id, insert_time, state_id)
            values
                (l_sub_sess,
                 l_main_sess,
                 l_uri_id,
                 l_reqtype.id,
                 sysdate,
                 0);
        p_main_sess := l_main_sess;
        commit;
        prep_req(l_main_sess);
    end;
 ------------------------------------------------------------------------------------------------

procedure resive_status_ok(p_res_id number) is
    pragma autonomous_transaction;
begin
    update transp_receive_data r
       set r.processed_time = localtimestamp,
           r.state_id       = 4,
           r.d_clob         = EMPTY_CLOB(),
           r.d_blob         = EMPTY_BLOB()
     where r.id = p_res_id;
    commit;
end;

procedure resive_status_err(p_res_id number, p_errmesage varchar2) is
    pragma autonomous_transaction;
begin
    update transp_receive_data r
       set r.processed_time = localtimestamp, r.state_id = 3
     where r.id = p_res_id;
    commit;
end;

procedure resive_status_start(p_res_id number) is
    pragma autonomous_transaction;
begin

    update transp_receive_data r set r.state_id = 1 where r.id = p_res_id;
    commit;
end;

procedure resive_status_exec(p_res_id number) is
    pragma autonomous_transaction;
begin
    update transp_receive_data r set r.state_id = 2 where r.id = p_res_id;
    commit;
end;


    procedure chk_proc(p_type Varchar2, p_id number, p_resp out number, p_err out varchar2)
        is
        begin
            null;
        end;

    procedure crt_date(p_type varchar2, p_resp number, p_err varchar2)
        is
        begin
            null;
        end;

begin
    g_proxy_url := bars.branch_attribute_utl.get_attribute_value('/', 'LINK_FOR_ABSBARS_WEBAPISERVICES', p_raise_expt => 0, p_check_exist => 0);

    if (g_proxy_url is null) then
        raise_application_error(-20000, 'Не вказаний URL веб-сервера АБС для передачі даних через транспортний механізм');
    end if;

    if (g_proxy_url not like '%/') then
        g_proxy_url := g_proxy_url || '/';
    end if;

    g_proxy_url := g_proxy_url || 'transp/ProxyV1/Direct';
end transp_utl;
/
