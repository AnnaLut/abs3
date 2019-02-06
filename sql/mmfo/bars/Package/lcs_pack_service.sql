CREATE OR REPLACE PACKAGE BARS.lcs_pack_service is

  -- Author  : RYTA.SHYGYDA
  -- Created : 07/07/2014 10:27:42
  -- Purpose :

  g_header_version constant varchar2(64) := 'version 2.2.4 21/01/2018';

  g_awk_header_defs constant varchar2(512) := '';

  g_transfer_timeout constant number := 1000;

  /*
  * header_version - версія заголовку документа
  */
  function header_version return varchar2;

  /*
  * body_version - версія тілу пакета
  */
  function body_version return varchar2;

  /*
  * get_param_webconfig - Отримання параметрів із  web_config
  */
  function get_param_webconfig(par varchar2) return web_barsconfig.val%type;

  /*
  * invoke - Виконання запиту
  */
  function invoke(p_req in out nocopy soap_rpc.t_request)
    return soap_rpc.t_response;

  /*
  * Формування запиту до веб сервісу щодо ліміту
  */
  function get_eqv(p_date varchar2, p_source_type varchar2, p_src_trans_id varchar2, p_mfo varchar2, p_branch varchar2, p_trans_crt_date varchar2, p_trans_bank_date varchar2, p_trans_code varchar2, p_s number, p_sq number, p_currency_code number, p_ex_rate_official number, p_ex_rate_sale number, p_doc_type_id varchar2, p_serial_doc varchar2, p_numb_doc varchar2, p_fio varchar2, p_birth_date varchar2, p_resident_flag number, p_cash_acc_flag number, p_approve_docs_flag number, p_exception_flag number, p_exception_description varchar2, p_staff_logname varchar2, p_staff_fio varchar2, p_recipient varchar2, p_purpose varchar2)
   return varchar2;
  /*
  *  Відміна транзакції
  */
   procedure back(p_src_trans_id varchar2, p_mfo varchar2, p_source_type varchar2);

  procedure ping(service_id varchar2, abonent_id varchar2, ret_ out varchar2);
  /*
  * Стоп правило на введення документа
  */
  function f_stop(p_ref in number) return number;
  /*
  * Функція переносу документів в базу
  */
  function lcs_transfer_doc_silent(p_ref in number) return number;
  /*
  * Підтвердження документа
  */
  procedure approve(p_src_trans_id varchar2, p_mfo varchar2, p_source_type varchar2);
  function f_check_transit (p_doc varchar2, p_sum number, p_type_oper varchar2, p_kv number) return varchar2;
  procedure set_return (p_src_trans_id varchar2, p_mfo varchar2, p_source_type varchar2);

  function f_get_black_list(p_ida   varchar2,
                          p_idb    varchar2,
                          p_mfoa   varchar2,
                          p_mfob   varchar2,
                          p_namea  varchar2,
                          p_nameb  varchar2,
                          p_nlsa   varchar2,
                          p_nlsb   varchar2) return varchar2;

end lcs_pack_service;
/

CREATE OR REPLACE PACKAGE BODY BARS.lcs_pack_service is

 g_body_version constant varchar2(64) := 'version 3.4.0 21/01/2018';
 g_awk_body_defs constant varchar2(512) := '';
 g_cur_rep_id number := -1;
 g_cur_block_id number := -1;
 G_ERRMOD constant varchar2(3) := 'BCK';
 g_is_error boolean := false;
 G_XMLHEAD constant varchar2(100) := '<?xml version="1.0" encoding="utf-8"?>';

 g_default_birth_date varchar2(64):= '01.01.1090';
 g_ukraine_code number := 804;
 g_is_new_dictionary boolean:= false;
 g_is_account boolean:= false;
 g_account_individual varchar2(5) := '2620%';
 g_account_tansit varchar2(5) := '2909%';
 g_account_bpk varchar2(5) := '2625%';

 -- > 150 тис грн, перевырка на пыдтверджувальны документи
 g_approve_sum number := 15000000;

 /*
 * header_version - возвращает версию заголовка пакета
 */
 function header_version return varchar2 is
 begin
 return 'Package header lcs_pack__service ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_header_defs;
 end header_version;

 /*
 * body_version - возвращает версию тела пакета
 */
 function body_version return varchar2 is
 begin
 return 'Package body BARS.lcs_pack_service ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_body_defs;
  end body_version;

  function extract(p_xml in xmltype, p_xpath in varchar2, p_mandatory in number)
    return varchar2 is
  begin
    begin
      return p_xml.extract(p_xpath).getStringVal();
    exception
      when others then
        if p_mandatory is null or g_is_error then
          return null;
        else
          if sqlcode = -30625 then
            bars_error.raise_nerror(g_errmod, 'XMLTAG_NOT_FOUND', p_xpath, g_cur_block_id, g_cur_rep_id);
          else
            raise;
          end if;
        end if;
    end;
  end;

  /*
   * Возвращает параметр из web_config
   */
  function get_param_webconfig(par varchar2) return web_barsconfig.val%type is
    l_res web_barsconfig.val%type;
  begin
    select val into l_res from web_barsconfig where key = par;
    return trim(l_res);
  exception
    when no_data_found then
      raise_application_error(-20000, 'Не найден KEY=' || par ||
                               ' в таблице web_barsconfig!');
  end;


  procedure generate_envelope(p_req in out nocopy soap_rpc.t_request, p_env in out nocopy varchar2) as
  begin
    p_env := G_XMLHEAD || '<soap:Envelope ' ||
             'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' ||
             'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' ||
             'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' ||
             '<soap:Body>' || '<' || p_req.method || ' xmlns="' ||
             p_req.namespace || '">' || p_req.body || '</' || p_req.method || '>' ||
             '</soap:Body>' || '</soap:Envelope>';
  end;

  /*
   * Получает строку с ошибкой и генерирует исключение
   */
  procedure check_fault(p_resp in out nocopy soap_rpc.t_response) as
    l_fault_node   xmltype;
    l_fault_code   varchar2(256);
    l_fault_string varchar2(32767);
  begin
    l_fault_node := p_resp.doc.extract('/soap:Fault', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/');
    if (l_fault_node is not null) then
      l_fault_code   := l_fault_node.extract('/soap:Fault/faultcode/child::text()','xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/')
                        .getstringval();
      l_fault_string := l_fault_node.extract('/soap:Fault/faultstring/child::text()','xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/')
                        .getstringval();
      raise_application_error(-20000, l_fault_code || ' - ' ||
                               l_fault_string);
    end if;
  end;

  /*
  *
  */
  function invoke(p_req in out nocopy soap_rpc.t_request)
    return soap_rpc.t_response as
    l_env       varchar2(32767);
    l_line      varchar2(32767);
    l_res       clob;
    l_http_req  utl_http.req;
    l_http_resp utl_http.resp;
    l_resp      soap_rpc.t_response;
  begin
    generate_envelope(p_req, l_env);

    --SSL соединение выполняем через wallet
    if instr(lower(p_req.url), 'https://') > 0 then
      utl_http.set_wallet(p_req.wallet_dir, p_req.wallet_pass);
    end if;
    --bars_audit.info('val_service2');

    begin
      l_http_req := utl_http.begin_request(p_req.url, 'POST', 'HTTP/1.0');
    exception
      when others then
        if sqlcode = -29273 or sqlcode = -20097 or sqlcode = -20000 then
          if sqlcode = -29273 then
            bars_error.raise_nerror('BRS', 'TRANSFER_TIMEOUT');
          elsif sqlcode = -20097 or
                (sqlcode = -20000 and
                instr(sqlerrm, 'ORA-1034') + instr(sqlerrm, 'ORA-12518') > 0) then
            bars_error.raise_nerror('BRS', 'MISSING_CONNECTION');
          elsif sqlcode = -20000 then
            bars_error.raise_nerror('ORA', 'MISSING_CONNECTION_W');
          end if;
        else
          raise;
        end if;
    end;

    utl_http.set_transfer_timeout(l_http_req, timeout => g_transfer_timeout);

    utl_http.set_body_charset(l_http_req, 'UTF-8');
    utl_http.set_header(l_http_req, 'Content-Type', 'text/xml; charset=UTF-8');
    utl_http.set_header(l_http_req, 'Content-Length', lengthb(convert(l_env, 'utf8')));
    utl_http.set_header(l_http_req, 'SOAPAction', p_req.namespace ||
                         p_req.method);
    utl_http.write_text(l_http_req, l_env);
    begin
      l_http_resp := utl_http.get_response(l_http_req);
    exception
      when others then
        bars_audit.error('val_service0: sqlcode=' || to_char(sqlcode) ||
                         ', sqlerrm=' || sqlerrm);
        if sqlcode = -29273 or sqlcode = -20097 or sqlcode = -20000 then
          if sqlcode = -29273 then
            bars_error.raise_nerror('BRS', 'TRANSFER_TIMEOUT');
          elsif sqlcode = -20097 or
                (sqlcode = -20000 and
                instr(sqlerrm, 'ORA-1034') + instr(sqlerrm, 'ORA-12518') > 0) then
            bars_error.raise_nerror('BRS', 'MISSING_CONNECTION');
          elsif sqlcode = -20000 then
            bars_error.raise_nerror('ORA', 'MISSING_CONNECTION_W');
          end if;
        else
          raise;
        end if;
    end;
    l_res := null;
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
    exception
      when others then
        if sqlcode = -31011 or sqlcode = -20097 or
           (sqlcode = -20000 and
           instr(sqlerrm, 'ORA-1034') + instr(sqlerrm, 'ORA-12518') > 0) then
          bars_error.raise_nerror('BRS', 'MISSING_CONNECTION');
        elsif sqlcode = -20000 then
          bars_error.raise_nerror('ORA', 'MISSING_CONNECTION_W');
        else
          raise;
        end if;
    end;
    l_resp.doc := l_resp.doc.extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
    begin
      check_fault(l_resp);
    exception
      when others then
        bars_audit.error('lcs_pack_service: sqlcode=' || to_char(sqlcode) ||
                         ', sqlerrm=' || sqlerrm);
        if sqlcode = -20000 and
           instr(sqlerrm, 'ORA-1034') + instr(sqlerrm, 'ORA-12518') > 0 then
          bars_error.raise_nerror('BRS', 'MISSING_CONNECTION');
          --    raise;
        elsif sqlcode = -20000 then
          bars_error.raise_nerror('ORA', 'MISSING_CONNECTION_W');
        else
          raise;
        end if;
    end;
    return l_resp;
  end;
  /*
   * Add for correct string transfer
   */
  function encode_row_to_base(par varchar2) return varchar2 is
  begin
    return utl_encode.text_encode(par, encoding => utl_encode.base64);
  end;
  /*
  *  Set status of transaction "RETURN".
  */

  procedure set_return (p_src_trans_id varchar2, p_mfo varchar2, p_source_type varchar2) is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_message  varchar2(4000);
    l_clob     clob;
    l_return_ref operw.value%type;
  begin
    bars_audit.info ('LCS.SET_RETURN. p_src_trans_id:'||p_src_trans_id||' p_mfo: '||p_mfo||' p_source_type: '||p_source_type);
    -- Пошук коду операції, що необхідно виплатити
    -- REFT  - референс доумента відправки
    begin
    select w.value into l_return_ref from operw w where w.tag = 'REFT' and w.ref = p_src_trans_id ;
    exception
      when no_data_found then
            bars_error.raise_error('DOC',47,'LCS.SET_RETURN:  Операція не знайдена!');
    end;
    --подготуват запит
    l_request := soap_rpc.new_request(p_url => get_param_webconfig('LCS.Url'), p_namespace => 'http://tempuri.org/', p_method => 'SetReturn', p_wallet_dir => get_param_webconfig('LCS.WalletDir'), p_wallet_pass => get_param_webconfig('LCS.WalletPass'));

    --додати параметри
    soap_rpc.add_parameter(l_request, 'transactionId', l_return_ref );
    soap_rpc.add_parameter(l_request, 'mfo', p_mfo);
    soap_rpc.add_parameter(l_request, 'sourceType', p_source_type);

    --позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);

    --Фикс неприятности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);

    l_message := extract(l_tmp, '/SetReturnResponse/SetReturnResult/ErrorMessage/text()', null);
  end;

 /*
  * Cancel transaction. Status of transaction "CANCELED".
  */

  procedure back(p_src_trans_id varchar2, p_mfo varchar2, p_source_type varchar2) is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_message  varchar2(4000);
    l_clob     clob;
  begin
    --подготовить реквест
    l_request := soap_rpc.new_request(p_url => get_param_webconfig('LCS.Url'), p_namespace => 'http://tempuri.org/', p_method => 'Back', p_wallet_dir => get_param_webconfig('LCS.WalletDir'), p_wallet_pass => get_param_webconfig('LCS.WalletPass'));

    --добавить параметры
    soap_rpc.add_parameter(l_request, 'transactionId', to_char(p_src_trans_id));
    soap_rpc.add_parameter(l_request, 'mfo', to_char(p_mfo));
    soap_rpc.add_parameter(l_request, 'sourceType', to_char(p_source_type));

    --позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);

    --Фикс неприятности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);

    l_message := extract(l_tmp, '/BackResponse/BackResult/ErrorMessage/text()', null);
  end;


 /*
 * APPROVE
 */
  procedure approve(p_src_trans_id varchar2, p_mfo varchar2, p_source_type varchar2) is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_message  varchar2(4000);
    l_clob     clob;
  begin
    l_request := soap_rpc.new_request(p_url => get_param_webconfig('LCS.Url'),
                                      p_namespace => 'http://tempuri.org/',
                                      p_method => 'Approve',
                                      p_wallet_dir => get_param_webconfig('LCS.WalletDir'),
                                      p_wallet_pass => get_param_webconfig('LCS.WalletPass'));

    --добавить параметры
    soap_rpc.add_parameter(l_request, 'transactionId', to_char(p_src_trans_id));
    soap_rpc.add_parameter(l_request, 'mfo', to_char(p_mfo));
    soap_rpc.add_parameter(l_request, 'sourceType', to_char(p_source_type));

    --позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);

    --Фикс неприятности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);

    l_message := extract(l_tmp, '/ApproveResponse/ApproveResult/ErrorMessage/text()', null);
  end approve;
  /*
  * function for lcs
  */
  function get_eqv(p_date varchar2,
                   p_source_type varchar2,
                   p_src_trans_id varchar2,
                   p_mfo varchar2,
                   p_branch varchar2,
                   p_trans_crt_date varchar2,
                   p_trans_bank_date varchar2,
                   p_trans_code varchar2,
                   p_s number,
                   p_sq number,
                   p_currency_code number,
                   p_ex_rate_official number,
                   p_ex_rate_sale number,
                   p_doc_type_id varchar2,
                   p_serial_doc varchar2,
                   p_numb_doc varchar2,
                   p_fio varchar2,
                   p_birth_date varchar2,
                   p_resident_flag number,
                   p_cash_acc_flag number,
                   p_approve_docs_flag number,
                   p_exception_flag number,
                   p_exception_description varchar2,
                   p_staff_logname varchar2,
                   p_staff_fio varchar2,
                   p_recipient varchar2,
                   p_purpose varchar2)
    return varchar2 IS
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_message  varchar2(4000);
    l_clob     clob;
    l_ret_ping varchar2(4000);
  begin
    begin
      bars_audit.trace('get_eqv: start');
      --  подготовить реквест
      l_request := soap_rpc.new_request(p_url => get_param_webconfig('LCS.Url'), p_namespace => 'http://tempuri.org/', p_method => 'GetEquivalent', p_wallet_dir => get_param_webconfig('LCS.WalletDir'), p_wallet_pass => get_param_webconfig('LCS.WalletPass'));

      bars_audit.info ('LCS_PACK_SERVICE : get_eqv sp_date %s '||p_date|| ' p_source_type : '||p_source_type||
      '  p_src_trans_id : '||p_src_trans_id||
      ' p_mfo  : '||p_mfo||
      ' p_branch :'||p_branch||
      ' p_trans_crt_date : '||p_trans_crt_date||
      ' p_trans_bank_date : '||p_trans_bank_date||
      ' p_trans_code : '||p_trans_code||
      ' p_s  : '||to_char(p_s)||
      ' p_sq  :'||to_char(p_sq)||
      ' p_currency_code  :'||p_currency_code||
      ' p_ex_rate_official  :'||p_ex_rate_official||
      ' p_ex_rate_sale  :'||p_ex_rate_sale||
      ' p_doc_type_id :'||p_doc_type_id||
      ' p_serial_doc  :'||p_serial_doc||
      ' p_numb_doc :'||p_numb_doc||
      ' p_fio :'||p_fio||
      ' p_birth_date :'||p_birth_date||
      ' p_resident_flag :'||p_resident_flag||
      ' p_cash_acc_flag :'||p_cash_acc_flag||
      ' p_approve_docs_flag :'||to_char(p_approve_docs_flag)||
      ' p_exception_flag :'||to_char(p_exception_flag)||
      '  p_exception_description :'||p_exception_description||
      ' p_staff_logname  :'||p_staff_logname);

      --  добавить параметры
      soap_rpc.add_parameter(l_request, 'dateOperation', to_char(to_date(p_date, 'dd.mm.yyyy'), 'dd.mm.yyyy'));
      soap_rpc.add_parameter(l_request, 'sourceType', to_char(p_source_type));
      soap_rpc.add_parameter(l_request, 'transactionId', to_char(p_src_trans_id));
      soap_rpc.add_parameter(l_request, 'mfo ', to_char(p_mfo));
      soap_rpc.add_parameter(l_request, 'branch', to_char(p_branch));
      soap_rpc.add_parameter(l_request, 'transactionDate ', to_char(p_trans_crt_date));
      soap_rpc.add_parameter(l_request, 'transactionBankdate ', to_char(p_trans_bank_date));
      soap_rpc.add_parameter(l_request, 'transactionCode ', to_char(encode_row_to_base(p_trans_code)));
      soap_rpc.add_parameter(l_request, 'documentSum', to_char(p_s));
      soap_rpc.add_parameter(l_request, 'documentSumEquivalent', to_char(p_sq));
      soap_rpc.add_parameter(l_request, 'currencyCode', to_char(p_currency_code));
      soap_rpc.add_parameter(l_request, 'exchangeRateOfficial', to_char(p_ex_rate_official));
      soap_rpc.add_parameter(l_request, 'exchangeRateSale', to_char(p_ex_rate_sale));
      soap_rpc.add_parameter(l_request, 'documentTypeId', to_char(p_doc_type_id));
      soap_rpc.add_parameter(l_request, 'documentSerial', to_char(encode_row_to_base(p_serial_doc)));
      soap_rpc.add_parameter(l_request, 'documentNumber', to_char(encode_row_to_base(p_numb_doc)));
      soap_rpc.add_parameter(l_request, 'userSurname', to_char(encode_row_to_base(p_fio)));
      soap_rpc.add_parameter(l_request, 'birthDate',p_birth_date );
      soap_rpc.add_parameter(l_request, 'residentFlag', to_char(p_resident_flag));
      soap_rpc.add_parameter(l_request, 'cashAccFlag', to_char(p_cash_acc_flag));
      soap_rpc.add_parameter(l_request, 'approveDocumentFlag', to_char(p_approve_docs_flag));
      soap_rpc.add_parameter(l_request, 'exceptionFlag', to_char(p_exception_flag));
      soap_rpc.add_parameter(l_request, 'exceptionDescription', to_char(encode_row_to_base(p_exception_description)));
      soap_rpc.add_parameter(l_request, 'staffLogname', to_char(p_staff_logname));
      soap_rpc.add_parameter(l_request, 'staffName', to_char(encode_row_to_base(p_staff_fio)));
      soap_rpc.add_parameter(l_request, 'recipient', to_char(encode_row_to_base(p_recipient)));
      soap_rpc.add_parameter(l_request, 'purpose', to_char(encode_row_to_base(p_purpose)));
       --  позвать метод веб-сервиса (nb:invoke  - есть ограничения по размеру сообщения)
     bars_audit.info ('LCS_PACK_SERVICE : l_request '||l_request.body);
     -- l_request := '<Request><Method>GetEquivalent</Method><documentTypeId>1</documentTypeId><Status>50</Status><exchangeRateOfficial>1</exchangeRateOfficial><exchangeRateSale>1</exchangeRateSale><documentSumEquivalent>1</documentSumEquivalent><branch>/304665/000000/060000/</branch><staffName>U1RQRk9nbXQ=</staffName><staffLogname>STPFOgmt</staffLogname><mfo>304665</mfo></Request>';
      l_response := soap_rpc.invoke(l_request);

      bars_audit.info ('LCS_PACK_SERVICE : l_response.doc.getClobVal() '||l_response.doc.getClobVal());
      --  Фикс неприятности в работе xpath при указанных xmlns

      l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
          dbms_output.put_line (l_clob);
      l_tmp  := xmltype(l_clob);
      l_message := extract(l_tmp, '/GetEquivalentResponse/GetEquivalentResult/text()', null);

    exception
      when others
        then
            bars_error.raise_error('DOC',47,SQLERRM);

    end;
    return l_message;

  end get_eqv;


  /******************************************************************************************/
  procedure ping(service_id varchar2, abonent_id varchar2, ret_ out varchar2) is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_message  varchar2(4000);
    l_clob     clob;
  begin
    --подготовить реквест
    l_request := soap_rpc.new_request(p_url => get_param_webconfig('LCS.Url'),
                                      p_namespace => 'http://tempuri.org/',
                                      p_method => 'Ping',
                                      p_wallet_dir => get_param_webconfig('LCS.WalletDir'),
                                      p_wallet_pass => get_param_webconfig('LCS.WalletPass'));

    --добавить параметры
    soap_rpc.add_parameter(l_request, 'service_id', to_char(service_id));
    soap_rpc.add_parameter(l_request, 'abonent_id', to_char(abonent_id));

    --позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);

    --Фикс неприятности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);

    ret_ := extract(l_tmp, '/PingResponse/PingResult/text()', null);
  end;

function get_doc_id(p_name varchar2) return PASSP.PASSP%type is
  l_id PASSPT.PASSPT%type;
begin
  begin

    select passpt
      into l_id
      from passpt
     where lower(trim(name)) like lower(trim(p_name));
     g_is_new_dictionary := true;

  exception
    when no_data_found then
      begin
        select passp
          into l_id
          from passp
         where lower(trim(name)) like lower(trim(p_name));
          g_is_new_dictionary := false;
      exception
        when no_data_found then
           return 1;
      end;
  end;
  return l_id;
end;


function user_type(p_rnk varchar2) return customer.custtype%type
is
l_cust_type customer.custtype%type;
begin
  begin
    select c.custtype into l_cust_type from customer c where c.rnk = p_rnk;
    exception when no_data_found
      then l_cust_type:=1;
  end;
  return l_cust_type;
end;
-- перевірка підтв документів
procedure p_check_approve_docs(p_trans_code   varchar2,
                               p_resid        number,
                               p_approve_docs number) is
begin
  if (p_trans_code in ('CAA', 'CAB', 'CAS') and p_resid = 2 and p_approve_docs = 0) then
    bars_error.raise_error('DOC',47,'Відсуті підтверджуючі документи для нерезидента.');
  end if;
end;
-- перевірка заповнення поля
procedure p_check_null (p_name varchar2, p_flag number, p_value varchar2 ) is
begin
  if ( p_flag = 1 and  p_value is null ) then
    bars_error.raise_error('DOC',47,'Необхідно заповнити '||p_name||'!');
  end if;
end;


function f_check_number (p_string in varchar2)
   return int
is
   l_new_num number;
begin
   l_new_num := to_number(p_string);
   return 1;
exception
when value_error then
   return 0;
end;

function f_set_hryvnia ( p_sum_in_penny in number )  return number
  is
  p_sum_in_hryvna number;
begin
  p_sum_in_hryvna := round ( p_sum_in_penny/100, 2);
  return p_sum_in_hryvna;
end;


/*
* STOP FUNCTION
*/
function f_stop(p_ref in number) return number is
  l_res            varchar2(4000);
  l_vidd           integer;
  l_doc_series     varchar2(10);
  l_doc_number     varchar2(20);
  l_rate           operw.value%type;
  l_sq             operw.value%type;
  l_fio            operw.value%type;
  l_resid          number;
  r_oper           oper%rowtype;
  r_staff          staff$base%rowtype;
  l_birthday_date  operw.value%type;
  l_approve_docs   operw.value%type;
  l_exception_flag operw.value%type;
  l_exception_desc operw.value%type;
  l_flag_trans     operw.value%type; --cash flag
  l_nls            varchar2(25);
  l_kuro           number(20, 8);
  l_branch         varchar(32) := sys_context('bars_context', 'user_branch');
  l_tmp            varchar2(150);
  l_rnk            customer.rnk%type;
  l_cust_type      customer.rnk%type;
  l_country_tran   customer.country%type;
  l_country        customer.country%type;
  l_ido            operw.value%type;
  l_atr            operw.value%type;
  l_fio2           operw.value%type := 'Не введено'; --Отримувач
  l_fio3           operw.value%type;
  l_nazn2          operw.value%type;

  l_passpt_resid passpt.resid%type;
  l_res_transit varchar2(4000):=' ';
  l_doc varchar2(20);



begin
  -- не є поточним рахунком
  g_is_account := false;

  select o.* into r_oper from oper o where o.ref = p_ref;
  select s.* into r_staff from staff$base s where s.id = gl.aUID;

  for i in (select w.tag, w.value from operw w where w.ref = p_ref) loop
    case i.tag
      when 'PASPN' then
        begin
          if (length(i.value) > 20) then
            bars_error.raise_error('DOC',
                                   47,
                                   'Перевищення довжини серії та номера документа!');
          end if;
         l_doc := i.value;
        end;
      when 'NAMED' then
        l_vidd := get_doc_id(i.value);
      when 'NAMET' then
        l_vidd := get_doc_id(i.value);
      when 'FIO ' then
        l_fio := i.value;
      when 'REZID' then
        l_resid :=  i.value;
      when 'DATN ' then
        l_birthday_date := i.value;
      when 'DT_R ' then
        l_birthday_date := i.value;
      when 'LCSFD' then
        l_approve_docs := i.value;
      when 'LCSFE' then
        l_exception_flag := i.value;
      when 'LCSFT' then
        l_flag_trans := i.value;
      when 'LCSDE' then
        l_exception_desc := i.value;
      when 'IDDO ' then
        l_ido := i.value;
      when 'ATRT ' then
        l_atr := i.value;
      when  'FIO2 '  then
        l_fio2 := i.value;
      when  '59   '  then
        l_fio3 := i.value; 
      when  '70   '  then
        l_nazn2 := i.value;
      else
        null;
    end case;

  end loop;

  -- Перевірка для SWIFT
  if (r_oper.tt in ('CFS', 'CFO', 'CFB', 'CVB', 'CVO', 'CVS')) then
    -- визначаємо юридична чи фізичн особа

    -- якщо 2909
    if ((r_oper.dk = 1 and r_oper.nlsa like g_account_tansit) or   (r_oper.dk = 2 and r_oper.nlsb like g_account_tansit)) then

    l_res_transit := f_check_transit( l_doc, r_oper.s, r_oper.tt , r_oper.kv);
      if ( l_res_transit = 'OK' )   then
         return 0;
      else   bars_error.raise_error('DOC', 47,l_res_transit);

    end if;
   -- якщо 2620
    elsif ( (r_oper.dk = 1 and r_oper.nlsa like g_account_individual) or (r_oper.dk = 2 and r_oper.nlsb like g_account_individual)) then
      -- заповнюємо з карточки клієнта
    begin
     select nvl(d.passp, 1),
             d.ser,
             d.numdoc,
             to_char(d.bday, 'dd.mm.yyyy'),
             c.nmk,
             nvl(c.country, g_ukraine_code)
        into l_vidd,
             l_doc_series,
             l_doc_number,
             l_birthday_date,
             l_fio,
             l_country
        from accounts a, person d, oper o, customer c
       where a.rnk = d.rnk
         and c.rnk = a.rnk
         and o.nlsa = a.nls
         and o.kv = a.kv
         and o.ref = p_ref;

      if l_country = g_ukraine_code then
        l_resid := 1;
      else
        l_resid := 2;
      end if;



      g_is_account := true;

      /*
      COBUSUPABS-3627  У довідник «Опис винятку»,
      що використовується при здійсненні операцій CFO, CFS, CFB для РУ та CVO, CVS, CVB для ЦА, додати опцію «Переказ ФО заборгованості за кредитом від нерезидента».

         заявка стосується безготівкових операцій з рахунків ФО (2620, 2625)
        Назва документу та його реквізити беруться з картки клієнта
        При опису винятку «Переказ ФО заборгованості за кредитом від нерезидента» необхідний контроль на резидентність (з картки клієнта!)
        Для нерезидента операція не виконується, видається зрозуміле повідомлення.
      */

       if (l_exception_flag = 1 and lower(l_exception_desc) like lower('%Переказ ФО заборгованості за кредитом від нерезидента%')  and l_resid != 1) then
            bars_error.raise_error('DOC',
                                 47,
                                 'Для данного опису винятку не відповідає значення резидентності '||l_resid);
            elsif (l_exception_flag = 1 and lower(l_exception_desc) like lower('%Переказ ФО заборгованості за кредитом від нерезидента%') and l_resid = 1) then
            return 0;
        end if;

      exception
        when no_data_found then  bars_error.raise_error('DOC', 47,  'Даних по рахунку не знайдено');
      end;
      -- якщо юридична особа або рахунок не контролюється

         -- якщо 2625
      elsif ( (r_oper.dk = 1 and r_oper.nlsa like g_account_bpk) or (r_oper.dk = 2 and r_oper.nlsb like g_account_bpk)) then
      -- заповнюємо з карточки клієнта
    begin
     select nvl(d.passp, 1),
             d.ser,
             d.numdoc,
             to_char(d.bday, 'dd.mm.yyyy'),
             c.nmk,
             nvl(c.country, g_ukraine_code)
        into l_vidd,
             l_doc_series,
             l_doc_number,
             l_birthday_date,
             l_fio,
             l_country
        from accounts a, person d, oper o, customer c
       where a.rnk = d.rnk
         and c.rnk = a.rnk
         and o.nlsa = a.nls
         and o.kv = a.kv
         and o.ref = p_ref;

      if l_country = g_ukraine_code then
        l_resid := 1;
      else
        l_resid := 2;
      end if;

      g_is_account := true;

      if (l_exception_flag = 1 and lower(l_exception_desc) like lower('%Переказ ФО заборгованості за кредитом від нерезидента%') and l_resid != 1) then
            bars_error.raise_error('DOC',
                                 47,
                                 'Для данного опису винятку не відповідає значення резидентності '||l_resid);
            elsif (l_exception_flag = 1 and lower(l_exception_desc) like lower('%Переказ ФО заборгованості за кредитом від нерезидента%') and l_resid = 1) then
            return 0;
        end if;

      exception
        when no_data_found then  bars_error.raise_error('DOC', 47,  'Даних по рахунку не знайдено');
      end;

    else
      return 0;
   end if; -- if 2620,2625


  end if; -- if CF%

 -- зарахування на рахунок фіз особи
  if (r_oper.tt in ('CNU','MUJ','MUU')) then
  -- заповнюємо з карточки клієнта
    begin
     select nvl(d.passp, 1),
             d.ser,
             d.numdoc,
             to_char(d.bday, 'dd.mm.yyyy'),
             c.nmk,
             nvl(c.country, g_ukraine_code)
        into l_vidd,
             l_doc_series,
             l_doc_number,
             l_birthday_date,
             l_fio,
             l_country
        from accounts a, person d, oper o, customer c
       where a.rnk = d.rnk
         and c.rnk = a.rnk
         and o.nlsb = a.nls
         and o.kv = a.kv
         and o.ref = p_ref and rownum = 1;

      if l_country = g_ukraine_code then
        l_resid := 1;
      else
        l_resid := 2;
      end if;

      g_is_account := true;

      exception
        when no_data_found then  bars_error.raise_error('DOC', 47,  'Даних по рахунку не знайдено');
      end;
   end if; -- CNU

  -- Оновлення статусу документа наступної заявки
if ( r_oper.tt in ('CN3','CN4','MUB') )
    then
        set_return (to_char(p_ref),gl.aMFO,'BRS_EXCH');
    end if;

  -- Перевірка BLACK_LIST для кредитів.
if ( r_oper.tt in ('KK1','KK2') ) then

    l_res:= f_get_black_list(r_oper.ID_A, r_oper.ID_B, r_oper.mfoa, r_oper.mfob, r_oper.nam_a, r_oper.nam_b, r_oper.nlsa, r_oper.nlsb);
    if ( l_res = 'OK' )   then
        return 0;
    else   bars_error.raise_error('DOC', 47,l_res);
    end if;
end if;


  -- Перевірка OW6 на ліміти.
if  r_oper.tt in ('OW6','OW5')  then

     begin
        select a.nls, a.rnk into l_doc_number, l_doc_series
            from accounts a
            where a.nls =  r_oper.nlsa and A.KV = r_oper.KV;
        exception
        when no_data_found then  bars_error.raise_error('DOC', 47,  'Даних по рахунку не знайдено');
     end;

     l_vidd := 3;
     --bars_audit.info ('OW6_1: l_doc_number = '||l_doc_number||' l_doc_series = '||l_doc_series );

end if;


  -- Офіційний курс

  begin
    select rate_o / bsum
      into l_kuro
      from cur_rates$base
     where vdate = trunc(sysdate)
       and kv = r_oper.kv
       and branch = l_branch;
  exception
    when no_data_found then
      select rate_o / bsum
        into l_kuro
        from cur_rates$base
       where vdate = (select max(vdate)
                        from cur_rates$base
                       where kv = r_oper.kv
                         and branch = l_branch)
         and kv = r_oper.kv
         and branch = l_branch;
  end;
  -- курс продажу
  begin
    select rate_s / bsum
      into l_rate
      from cur_rates$base
     where vdate = trunc(sysdate)
       and kv = r_oper.kv
       and branch = l_branch;

    if l_rate is null then
      l_rate := to_char(l_kuro);
    end if;
  exception
    when no_data_found then
      l_rate := to_char(l_kuro);
  end;

 -- 2 літери  6 цифр
 if (l_vidd in (1,21) and g_is_account = false) then
    begin
      l_doc_number := substr(replace(trim(l_doc), ' '), 3, 17);
      l_doc_series := upper(substr(replace(trim(l_doc), ' '), 1, 2));
      l_doc_series := kl.recode_passport_serial(p_serial => l_doc_series);
      l_doc_number := kl.recode_passport_number(p_number => l_doc_number);
      exception
        when others then
          bars_error.raise_error('DOC',
                                 47,
                                 'Невірне значення серії або номеру документа для типу документа:'||l_vidd);
    end;


-- серія 2 літери,  номер-символи необежано (20)
   elsif (l_vidd in (5,6,15) and g_is_account = false) then
    begin
      l_doc_number := substr(replace(trim(l_doc), ' '), 3, 17);
      l_doc_series := upper(substr(replace(trim(l_doc), ' '), 1, 2));
      l_doc_series := kl.recode_passport_serial(p_serial => l_doc_series);

       exception
        when others then
          bars_error.raise_error('DOC',
                                 47,
                                 'Невірне значення серії або номеру документа для типу документа:'||l_vidd);
   end;
 -- лише цифрові значення
  elsif (l_vidd in (16,91,7) and g_is_account = false) then
    begin

    l_doc_number := l_doc;
    l_doc_series := NULL;

        if (length(l_doc_number) > 20) then
          bars_error.raise_error('DOC',
                                 47,
                                 'Номер посвідчення\посвідки перевищує 20 символів!');
        end if;

        if (f_check_number(l_doc_number) = 0 and g_is_account = false) then
          bars_error.raise_error('DOC',
                                 47,
                                 'Номер посвідки\посвідчення\паспорту має містити лише цифрові значення!');
        end if;

         if (l_vidd = 7 and length(l_doc_number) <> 9 ) then
          bars_error.raise_error('DOC',
                                 47,
                                 'Номер паспорту у формі пластикової карти повинен містити 9 цифр!');
        end if;

        if (l_vidd = 7 and (length(l_doc_number) <> 9 or l_ido is null or l_atr is null) ) then
          bars_error.raise_error('DOC',
                                 47,
                                 'Для паспорту у формі пластикової карти повинні бути заповнені обов`язкові атрибути "Ким і коли видано документ" і "Дійсний до"!');
        end if;
     /* exception
        when others then
          bars_error.raise_error('DOC',
                                 47,
                                 'Невірне значення номеру документа для типу документа:'||l_vidd); */
   end;
  --    Для виду док. 17, прибираємо введені пробіли, можна писати що хочеш, як хочеш
 elsif  (l_vidd = 17 and g_is_account = false) then
   l_doc_number := REPLACE(l_doc,' ');
   l_doc_series := NULL;
    -- Для док.18,20,90 перевірка на латиницю
 elsif (l_vidd in (18,20,90) and g_is_account = false) then
    begin
      l_doc_number := substr(replace(trim(l_doc), ' '), 3, 17);
      l_doc_series := upper(substr(replace(trim(l_doc), ' '), 1, 2));
      l_doc_series := rtrim(l_doc_series,'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ0123456789');
      l_doc_number := kl.recode_passport_number(p_number => l_doc_number);
      exception
        when others then
          bars_error.raise_error('DOC',
                                 47,
                                 'Невірне значення серії або номеру документа для типу документа:'||l_vidd);
    end;
 elsif (l_vidd in (3) and g_is_account = false and r_oper.tt not in ('OW6','OW5')) then
 begin
      l_doc_number := substr(replace(trim(l_doc), ' '), -6);
      l_doc_series := substr(replace(rtrim(trim(l_doc),'1234567890'), ' '), 1, 4);
      exception
        when others then
          bars_error.raise_error('DOC',
                                 47,
                                 'Невірне значення серії або номеру документа для типу документа:'||l_vidd);
    end;
 elsif (l_vidd in (3) and  r_oper.tt in ('OW6','OW5')) then
      l_resid := 1;
 end if;

  -- Перевірка на резидентність
 begin

   select resid
     into l_passpt_resid
     from passpt p
    where p.passpt = l_vidd
      and rownum = 1;

   if (l_passpt_resid != l_resid and g_is_account = false) then
     bars_error.raise_error('DOC',
                            47,
                            'Невідповідність між резидентністю та типом документа!');
   end if;

 exception
   when no_data_found then
     null;
 end;

 -- Перевірка підтв документів
 if (l_approve_docs = 0 and l_resid = 2 and  to_number(r_oper.s) * l_kuro > g_approve_sum) then
   bars_error.raise_error('DOC',
                          47,
                          'Відсутні підтверджуючі документи для нерезидента !');
 end if;

 if (l_approve_docs = 0 and
    lower(l_exception_desc) not like ('переказ в межах україни')) then
   bars_error.raise_error('DOC',
                          47,
                          'Відсутні підтверджуючі документи при встановленні ознаки виключення!');
 end if;

 -- Валідація полів

 p_check_null(p_name  => 'опис виключення',
              p_flag  => l_exception_flag,
              p_value => l_exception_desc);
 p_check_null(p_name  => 'номер документа',
              p_flag  => 1,
              p_value => trim(l_doc_number));

 if (l_vidd in (18,20,90)) then
   p_check_null(p_name  => 'серію документа латинськими символами',
                p_flag  => 1,
                p_value => l_doc_series);

    elsif (r_oper.tt != 'CNU' and l_vidd not in (16,17,91,7)) then
   p_check_null(p_name  => 'серія документа',
                p_flag  => 1,
                p_value => l_doc_series);

 end if;

if (to_number(r_oper.s) * l_kuro > g_approve_sum) then
 p_check_approve_docs(p_trans_code   => r_oper.tt,
                      p_resid        => l_resid,
                      p_approve_docs => l_approve_docs);
end if;

 if (to_number(r_oper.s) * l_kuro > g_approve_sum and l_approve_docs = 0 and
    (g_is_account = true or r_oper.tt in ('436', 'CVS', 'CVB'))) then
   bars_error.raise_error('DOC',
                          47,
                          'Відсутні підтверджуючі документи при проведенні одноразово операції  більш ніж '||g_approve_sum/100||' грн.!');
 end if;

  -- Переказ в межах України не отображаем
  /*if ( l_exception_flag = 1 and lower(l_exception_desc) like lower('%переказ в межах україни%' ) and nvl(l_country_tran,g_ukraine_code) like '%804%' ) then
      bars_error.raise_error('DOC',
                             47,
                             'Переказ не є в межах України!  Код країни перерахування/надходження переказу '||to_char(l_country_tran));
  end if;*/

  if (to_number(r_oper.s) * l_kuro > g_approve_sum 
      and l_exception_flag = 0 
      and r_oper.tt in ('CFS', 'CFO', 'CFB', 'CVB', 'CVO', 'CVS')) then
   bars_error.raise_error('DOC',
                          47,
                          'Відсутня ознака винятку при проведенні операції  більш ніж '||g_approve_sum/100||' грн.!');
  end if;
  
  if (l_exception_flag = 1 and
     (lower(l_exception_desc) like lower('%переказ в межах україни%') or  lower(l_exception_desc) like lower('%Переказ ФО - повернення інвестиції%')) ) then
    return 0;
  end if;

  --Установка кассы, для USER4INPUT = 1 не вносится в operw ???
  if (l_flag_trans is null) then
    if (r_oper.tt in ('436', 'CAA', 'CAB', 'CAS')) then
      l_flag_trans := 1;
    else
   l_flag_trans := 0;
    end if;
  end if;
  -- Call get eqv
  l_res := get_eqv(to_char(gl.bdate, 'dd.mm.yyyy'), -- p_date varchar2,
                   'BRS_EXCH', -- p_source_type varchar2,
                   to_char(p_ref), -- p_src_trans_id varchar2,
                   nvl(gl.aMFO, '1'), -- p_mfo varchar2,
                   nvl(l_branch, '1'), -- p_branch varchar2,
                   to_char(r_oper.pdat, 'dd.mm.yyyy'), --  _trans_crt_date varchar2,
                   to_char(nvl(gl.bdate, sysdate), 'dd.mm.yyyy'), -- p_trans_bank_date varchar2,
                   r_oper.tt, -- p_trans_code varchar2,
                   to_number(r_oper.s), -- p_s number, не в копейках
                   to_number(r_oper.s) * l_kuro, -- p_sq number, е в копейках
                   r_oper.kv, -- p_currency_code number,
                   l_kuro, -- p_ex_rate_official number,
                   to_number(l_rate), -- p_ex_rate_sale number,
                   nvl(l_vidd, 1), -- p_doc_type_id varchar2,
                   nvl(l_doc_series, ' '), -- p_serial_doc varchar2,
                   l_doc_number, -- p_numb_doc varchar2,
                   nvl(l_fio, 'Underfine'), -- p_fio varchar2,
                   nvl(l_birthday_date, g_default_birth_date), -- p_birth_date varchar2,
                   nvl(l_resid, 0), -- p_resident_flag number,
                   nvl(l_flag_trans, 0), -- p_cash_acc_flag number,
                   nvl(l_approve_docs, 0), -- p_approve_docs_flag number,
                   nvl(l_exception_flag, 0), -- p_exception_flag number,
                   nvl(l_exception_desc, ' '), -- p_exception_description varchar2,
                   r_staff.logname, -- p_staff_logname varchar2,
                   r_staff.fio,
                   nvl(l_fio3,l_fio2), -- Отримувач
                   nvl(l_nazn2,r_oper.nazn));
  logger.info('l_res: ' || l_res);

  if (l_res = 'OK') then
    return 0;
  else
    bars_error.raise_error('DOC', 47, l_res);
  end if;
end f_stop;

  /*
  * Перевірка транзитного рахунку на провавдення касової операції
  */

  function f_check_transit (p_doc varchar2, p_sum number, p_type_oper varchar2, p_kv number) return varchar2 is
   l_count_сash number;
   l_count_swift number;
   l_day_delay number:=8;
  begin



    select count(*) into l_count_сash from oper o, operw w
        where o.ref=w.ref
        --14.04.2015 додати проміжок вісім днів
        and o.pdat>=trunc(sysdate)-l_day_delay
        and o.sos > 0
        and w.tag ='PASPN'
        and w.value =  p_doc
        and o.s = p_sum
        and o.kv = p_kv
        and o.tt in ('CAA','CAB', 'CAS');

      select count(*) into l_count_swift from oper o, operw w
        where o.ref=w.ref
        --14.04.2015 додати проміжок вісім днів
        and o.pdat>=trunc(sysdate)-l_day_delay
        and o.sos >= 0
        and w.tag ='PASPN'
        and w.value = p_doc
        and o.kv = p_kv
        and o.s = p_sum
        and o.tt in ('CFO','CFB','CFS','CVS','CVO','CVB');

       bars_audit.info ('f_check_transit: Doc '||p_doc||' oper type'||p_type_oper ||' Summ '||to_char (p_sum)||' Count '||to_char (l_count_swift) );
     if ( l_count_сash = 0 ) then
       return 'Не знайдено відповідної операції готівкового переказу: САА,САВ, САS';
     elsif  ( l_count_swift - l_count_сash) >= 1 then
       return  'Спроба повторно провести ідентичну операцію';
    end if;
   return 'OK';
 end;
function lcs_transfer_doc_silent(p_ref in number) return number is
  l_res            varchar2(4000);
  l_vidd           integer;
  l_doc_series     varchar2(10);
  l_doc_number     varchar2(20);
  l_rate           operw.value%type;
  l_sq             operw.value%type;
  l_fio            operw.value%type;
  l_fio2           operw.value%type := 'Не введено';
  l_fio3           operw.value%type;
  l_nazn2          operw.value%type;
  l_resid          number;
  r_oper           oper%rowtype;
  r_staff          staff$base%rowtype;
  l_birthday_date  operw.value%type;
  l_approve_docs   operw.value%type;
  l_exception_flag operw.value%type;
  l_exception_desc operw.value%type;
  l_flag_trans     operw.value%type; --cash flag
  l_nls            varchar2(25);
  l_kuro           number(20, 8);
  l_branch         varchar(32) := sys_context('bars_context', 'user_branch');
  l_tmp            varchar2(150);
  l_rnk            customer.rnk%type;
  l_cust_type      customer.rnk%type;
  l_country_tran   customer.country%type;
  l_country        customer.country%type;


  l_passpt_resid passpt.resid%type;
  l_res_transit varchar2(4000):=' ';
  l_doc varchar2(20);

  g_default_birth_date varchar2(64):= '01.01.1090';
  g_ukraine_code number := 804;
  g_is_new_dictionary boolean:= false;
  g_is_account  boolean:= false;
  g_account_individual varchar2(5) := '2620%';
  g_account_tansit varchar2(5) := '2909%';
  g_account_bpk varchar2(5) := '2625%';

begin
  -- не є поточним рахунком
  g_is_account := false;

  select o.* into r_oper from oper o where o.ref = p_ref;
  select s.* into r_staff from staff$base s, oper o  where s.id = o.userid and o.ref = p_ref;

  l_branch := r_oper.branch;

  for i in (select w.tag, w.value from operw w where w.ref = p_ref) loop
    case i.tag
      when 'PASPN' then
        begin
          if (length(i.value) > 20) then
            bars_error.raise_error('DOC',
                                   47,
                                   'Перевищення довжини серії та номера документа!');
          end if;
         l_doc := i.value;
        end;
      when 'NAMED' then
        l_vidd :=get_doc_id(i.value);
      when 'NAMET' then
        l_vidd := get_doc_id(i.value);
      when 'FIO ' then
        l_fio := i.value;
      when 'REZID' then
        l_resid :=  i.value;
      when 'DATN ' then
        l_birthday_date := i.value;
      when 'DT_R ' then
        l_birthday_date := i.value;
      when 'LCSFD' then
        l_approve_docs := i.value;
      when 'LCSFE' then
        l_exception_flag := i.value;
      when 'LCSFT' then
        l_flag_trans := i.value;
      when 'LCSDE' then
        l_exception_desc := i.value;
      when  'FIO2 '  then
        l_fio2 := i.value;
      when  '59   '  then
        l_fio3 := i.value; 
      when  '70   '  then
        l_nazn2 := i.value;
      else
        null;
    end case;

  end loop;

  -- Перевірка для SWIFT
  if (r_oper.tt in ('CFS', 'CFO', 'CFB', 'CVB', 'CVO', 'CVS')) then
    -- визначаємо юридична чи фізичн особа


   -- якщо 2620
    if ( (r_oper.dk = 1 and r_oper.nlsa like g_account_individual) or (r_oper.dk = 2 and r_oper.nlsb like g_account_individual)) then
      -- заповнюємо з карточки клієнта
    begin
     select nvl(d.passp, 1),
             d.ser,
             d.numdoc,
             to_char(d.bday, 'dd.mm.yyyy'),
             c.nmk,
             nvl(c.country, g_ukraine_code)
        into l_vidd,
             l_doc_series,
             l_doc_number,
             l_birthday_date,
             l_fio,
             l_country
        from accounts a, person d, oper o, customer c
       where a.rnk = d.rnk
         and c.rnk = a.rnk
         and o.nlsa = a.nls
         and o.kv = a.kv
         and o.ref = p_ref;

      if l_country = g_ukraine_code then
        l_resid := 1;
      else
        l_resid := 2;
      end if;

      g_is_account := true;

      exception
        when no_data_found then  bars_error.raise_error('DOC', 47,  'Даних по рахунку не знайдено');
      end;
      -- якщо юридична особа або рахунок не контролюється


      -- якщо 2625
      elsif ( (r_oper.dk = 1 and r_oper.nlsa like g_account_bpk) or (r_oper.dk = 2 and r_oper.nlsb like g_account_bpk)) then
      -- заповнюємо з карточки клієнта
    begin
     select nvl(d.passp, 1),
             d.ser,
             d.numdoc,
             to_char(d.bday, 'dd.mm.yyyy'),
             c.nmk,
             nvl(c.country, g_ukraine_code)
        into l_vidd,
             l_doc_series,
             l_doc_number,
             l_birthday_date,
             l_fio,
             l_country
        from accounts a, person d, oper o, customer c


       where a.rnk = d.rnk
         and c.rnk = a.rnk
         and o.nlsa = a.nls

         and o.kv = a.kv
         and o.ref = p_ref;

      if l_country = g_ukraine_code then

        l_resid := 1;
      else
        l_resid := 2;
      end if;

      g_is_account := true;


      exception

        when no_data_found then  bars_error.raise_error('DOC', 47,  'Даних по рахунку не знайдено');
      end;


   end if; -- if 2620,2625


  end if; -- if CF%

 -- зарахування на рахунок фіз особи
  if (r_oper.tt in ('CNU','MUU','MUJ')) then
  -- заповнюємо з карточки клієнта
    begin
     select nvl(d.passp, 1),
             d.ser,
             d.numdoc,
             to_char(d.bday, 'dd.mm.yyyy'),
             c.nmk,
             nvl(c.country, g_ukraine_code)
        into l_vidd,
             l_doc_series,
             l_doc_number,
             l_birthday_date,
             l_fio,
             l_country
        from accounts a, person d, oper o, customer c
       where a.rnk = d.rnk
         and c.rnk = a.rnk
         and ( o.nlsb = a.nls or o.nlsa = a.nls)
         and o.kv = a.kv
         and o.ref = p_ref and rownum = 1;

      if l_country = g_ukraine_code then
        l_resid := 1;
      else
        l_resid := 2;
      end if;

      g_is_account := true;

      exception
        when no_data_found then  bars_error.raise_error('DOC', 47,  'Даних по рахунку не знайдено');
      end;
   end if; -- CNU

  -- Оновлення статусу документа наступної заявки
if ( r_oper.tt in ('CN3','CN4','MUB') )
    then
       set_return (to_char(p_ref),gl.aMFO,'BRS_EXCH');
    end if;


  -- Офіційний курс

  begin
    select rate_o / bsum
      into l_kuro
      from cur_rates$base
     where vdate = trunc(r_oper.vdat)
       and kv = r_oper.kv
       and branch = l_branch;
  exception
    when no_data_found then
      select rate_o / bsum
        into l_kuro
        from cur_rates$base
       where vdate = (select max(vdate)
                        from cur_rates$base
                       where kv = r_oper.kv
                         and branch = l_branch)
         and kv = r_oper.kv
         and branch = l_branch;
  end;
  -- курс продажу
  begin
    select rate_s / bsum
      into l_rate
      from cur_rates$base
     where vdate = trunc(r_oper.vdat)
       and kv = r_oper.kv
       and branch = l_branch;

    if l_rate is null then
      l_rate := to_char(l_kuro);
    end if;
  exception
    when no_data_found then
      l_rate := to_char(l_kuro);
  end;


 -- 2 літери  6 цифр
 if (l_vidd in (1,21) and g_is_account = false) then
    begin
      l_doc_number := substr(replace(trim(l_doc), ' '), 3, 17);
      l_doc_series := upper(substr(replace(trim(l_doc), ' '), 1, 2));
      l_doc_series := kl.recode_passport_serial(p_serial => l_doc_series);
      l_doc_number := kl.recode_passport_number(p_number => l_doc_number);
      exception
        when others then
          bars_error.raise_error('DOC',
                                 47,
                                 'Невірне значення серії або номеру документа для типу документа:'||l_vidd);
    end;


-- серія 2 літери,  номер-символи необежано (20)
   elsif (l_vidd in (5,6,15) and g_is_account = false) then
    begin
      l_doc_number := substr(replace(trim(l_doc), ' '), 3, 17);
      l_doc_series := upper(substr(replace(trim(l_doc), ' '), 1, 2));
      l_doc_series := kl.recode_passport_serial(p_serial => l_doc_series);

       exception
        when others then
          bars_error.raise_error('DOC',
                                 47,
                                 'Невірне значення серії або номеру документа для типу документа:'||l_vidd);
   end;
 -- лише цифрові значення
  elsif (l_vidd in (16,91) and g_is_account = false) then
    begin

    l_doc_number := l_doc;
    l_doc_series := NULL;
   end;
  --   Для виду док. 17, прибираємо введені пробіли, можна писати що хочеш, як хочеш
 elsif  (l_vidd = 17 and g_is_account = false) then
   l_doc_number := REPLACE(l_doc,' ');
   l_doc_series := NULL;
   -- Для док.18,20,90 спробую зробити тільки латиницю
 elsif (l_vidd in (18,20,90) and g_is_account = false) then
    begin
      l_doc_number := substr(replace(trim(l_doc), ' '), 3, 17);
      l_doc_series := upper(substr(replace(trim(l_doc), ' '), 1, 2));
      l_doc_series := rtrim(l_doc_series,'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ0123456789');
      l_doc_number := kl.recode_passport_number(p_number => l_doc_number);
      exception
        when others then
          bars_error.raise_error('DOC',
                                 47,
                                 'Невірне значення серії або номеру документа для типу документа:'||l_vidd);
    end;
 end if;


  -- Call get eqv
  l_res := get_eqv(to_char(r_oper.pdat, 'dd.mm.yyyy'), -- p_date varchar2,
                   'BRS_EXCH', -- p_source_type varchar2,
                   to_char(p_ref), -- p_src_trans_id varchar2,
                   nvl(gl.aMFO, '1'), -- p_mfo varchar2,
                   nvl(l_branch, '1'), -- p_branch varchar2,
                   to_char(r_oper.pdat, 'dd.mm.yyyy'), --  _trans_crt_date varchar2,
                   to_char(r_oper.vdat, 'dd.mm.yyyy'), -- p_trans_bank_date varchar2,
                   r_oper.tt, -- p_trans_code varchar2,
                   to_number(r_oper.s), -- p_s number, не в копейках
                   to_number(r_oper.s) * l_kuro, -- p_sq number, е в копейках
                   r_oper.kv, -- p_currency_code number,
                   l_kuro, -- p_ex_rate_official number,
                   to_number(l_rate), -- p_ex_rate_sale number,
                   nvl(l_vidd, 1), -- p_doc_type_id varchar2,
                   nvl(l_doc_series, ' '), -- p_serial_doc varchar2,
                   l_doc_number, -- p_numb_doc varchar2,
                   nvl(l_fio, 'Underfine'), -- p_fio varchar2,
                   nvl(l_birthday_date, g_default_birth_date), -- p_birth_date varchar2,
                   nvl(l_resid, 0), -- p_resident_flag number,
                   nvl(l_flag_trans, 0), -- p_cash_acc_flag number,
                   nvl(l_approve_docs, 0), -- p_approve_docs_flag number,
                   nvl(l_exception_flag, 0), -- p_exception_flag number,
                   nvl(l_exception_desc, ' '), -- p_exception_description varchar2,
                   r_staff.logname, -- p_staff_logname varchar2,
                   r_staff.fio,
                   nvl(l_fio3,l_fio2), -- Отримувач
                   nvl(l_nazn2,r_oper.nazn));
  logger.info('l_res: ' || l_res);

  if (l_res = 'OK') then
    return 0;
  else
    bars_error.raise_error('DOC', 47, l_res);
  end if;
end lcs_transfer_doc_silent;

function f_get_black_list(p_ida    varchar2,
                          p_idb    varchar2,
                          p_mfoa   varchar2,
                          p_mfob   varchar2,
                          p_namea  varchar2,
                          p_nameb  varchar2,
                          p_nlsa   varchar2,
                          p_nlsb   varchar2) return varchar2 IS
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_message  varchar2(4000);
    l_clob     clob;
    l_ret_ping varchar2(4000);
  begin
    begin
      bars_audit.info('f_get_black_list: start');
      --  подготовить реквест
      l_request := soap_rpc.new_request(p_url => get_param_webconfig('LCS.Url'), p_namespace => 'http://tempuri.org/', p_method => 'GetBlackList', p_wallet_dir => get_param_webconfig('LCS.WalletDir'), p_wallet_pass => get_param_webconfig('LCS.WalletPass'));

      --  добавить параметры
      soap_rpc.add_parameter(l_request, 'ida', to_char(p_ida));
      soap_rpc.add_parameter(l_request, 'idb', to_char(p_idb));
      soap_rpc.add_parameter(l_request, 'mfoa', to_char(p_mfoa));
      soap_rpc.add_parameter(l_request, 'mfob', to_char(p_mfob));
      soap_rpc.add_parameter(l_request, 'namea', to_char(encode_row_to_base(p_namea)));
      soap_rpc.add_parameter(l_request, 'nameb', to_char(encode_row_to_base(p_nameb)));
      soap_rpc.add_parameter(l_request, 'nlsa', to_char(p_nlsa));
      soap_rpc.add_parameter(l_request, 'nlsb', to_char(p_nlsb));
       --  позвать метод веб-сервиса (nb:invoke  - есть ограничения по размеру сообщения)
     bars_audit.info ('LCS_PACK_SERVICE : l_request '||l_request.body);
     -- l_request := '<Request><Method>GetEquivalent</Method><documentTypeId>1</documentTypeId><Status>50</Status><exchangeRateOfficial>1</exchangeRateOfficial><exchangeRateSale>1</exchangeRateSale><documentSumEquivalent>1</documentSumEquivalent><branch>/304665/000000/060000/</branch><staffName>U1RQRk9nbXQ=</staffName><staffLogname>STPFOgmt</staffLogname><mfo>304665</mfo></Request>';
      l_response := soap_rpc.invoke(l_request);

      bars_audit.info ('LCS_PACK_SERVICE : l_response.doc.getClobVal() '||l_response.doc.getClobVal());
      --  Фикс неприятности в работе xpath при указанных xmlns

      l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
          dbms_output.put_line (l_clob);
      l_tmp  := xmltype(l_clob);
      l_message := extract(l_tmp, '/GetBlackListResponse/GetBlackListResult/text()', null);

    exception
      when others
        then
            bars_error.raise_error('DOC',47,SQLERRM);

    end;
    return l_message;
end f_get_black_list;

end lcs_pack_service;
/
 show err;
 
PROMPT *** Create  grants  LCS_PACK_SERVICE ***
grant EXECUTE                                                                on LCS_PACK_SERVICE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/lcs_pack_service.sql =========*** En
 PROMPT ===================================================================================== 