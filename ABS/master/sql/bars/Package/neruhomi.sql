
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/neruhomi.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NERUHOMI 
IS
   g_header_version   CONSTANT VARCHAR2 (64) := 'version 1.1  13/02/2013';
   g_transfer_timeout constant number := 15;

-- Ф-ція отримання залишку %%
FUNCTION get_percent(p_key number)
	RETURN NUMBER;
-- Ф-ція отримання NLS(ASVO)
FUNCTION get_NLS(p_key number)
	RETURN NUMBER;

-- Ф-ція отримання FIO
FUNCTION get_FIO(p_key number)
	RETURN VARCHAR2;

--Повертає назву рахунку
FUNCTION get_nms(p_nls accounts.nls%type, p_kv accounts.kv%type)
RETURN VARCHAR2;

function encode_row_to_base(par varchar2) return varchar2;

--procedure transfer_xml(xml_body clob, ret_ out varchar2);

procedure transfer(p_FIO      varchar2, -- FIO      IS 'ФИО';
                     p_IDCODE   varchar2, -- IDCODE   IS 'Идентификационный код';
                     p_DOCTYPE  varchar2, -- DOCTYPE  IS 'Тип документа (1-паспорт,2-свидетельство о рождении,3-военный билет,0-прочее)';
                     p_PASP_S   varchar2, -- PASP_S   IS 'Серия паспорта (документа)';
                     p_PASP_N   varchar2, -- PASP_N   IS 'Номер паспорта (документа)';
                     p_PASP_W   varchar2, -- PASP_W   IS 'Кем выдан паспорт (документ)';
                     p_PASP_D   varchar2, -- PASP_D   IS 'Дата выдачи паспорта (документа)';
                     p_BIRTHDAT varchar2, -- BIRTHDAT IS 'Дата рождения';
                     p_BIRTHPL  varchar2, -- BIRTHPL  IS 'Место рождения';
                     p_SEX      varchar2, -- SEX      IS 'Пол (1-мужской, 2-женский)';
                     p_POSTIDX  varchar2, -- POSTIDX  IS 'Почтовый индекс';
                     p_REGION   varchar2, -- REGION   IS 'Область';
                     p_DISTRICT varchar2, -- DISTRICT IS 'Район';
                     p_CITY     varchar2, -- CITY     IS 'Город';
                     p_ADDRESS  varchar2, -- ADDRESS  IS 'Адрес (улица, дом, квартира)';
                     p_PHONE_H  varchar2, -- PHONE_H  IS 'Домашний телефон';
                     p_PHONE_J  varchar2, -- PHONE_J  IS 'Рабочий телефон';
                     p_REGDATE  varchar2, -- REGDATE  IS 'Дата регистрации вкладчика';
                     p_NLS      varchar2, -- NLS      IS 'Лицевой счет';
                     p_DATO     varchar2, -- DATO     IS 'Дата открытия основного вклада';
                     p_OST      varchar2, -- OST      IS 'Остаток на вкладе в коп.';
                     p_SUM      varchar2, -- SUM      IS 'Сумма в коп., которую нужно выплатить. Будет использоваться для наследников.';
                     p_DATN     varchar2, -- DATN     IS 'Дата, по!!! которую начислены проценты';
                     p_BRANCH   varchar2, -- BRANCH   IS 'Номер подразделения Ощадбанка в БАРСе';
                     p_BSD      varchar2, -- BSD      IS 'Бал. счет';
                     p_OB22DE   varchar2, -- OB22DE   IS 'OB22 вклада';
                     p_BSN      varchar2, -- BSN      IS 'Бал. счет начисленных процентов';
                     p_OB22IE   varchar2, -- OB22IE   IS 'OB22 начисленных процентов';
                     p_BSD7     varchar2, -- BSD7     IS 'Бал. счет процентных затрат';
                     p_OB22D7   varchar2, -- OB22D7   IS 'OB22 процентных затрат';
                     p_source   varchar2, -- source   IS 'Источник вклада';
                     p_kv       varchar2, -- KV       IS 'Код валюты вклада';
                     p_nd       varchar2, -- ND       IS 'Номер договора в депозитной системе';
                     p_dptid    varchar2, -- DPTID    IS 'ID в депозитной системе';
                     p_LANDCOD  varchar2, -- LANDCOD  IS 'Код страны (гражданство)';
                     p_FL       varchar2, -- fl       IS 'Флаг обработки';
                     p_DZAGR    varchar2, -- dzagr    IS 'Дата загрузки в АБС';
                     p_ref      varchar2, -- ref      IS 'Референс документа входной'
                     ret_       out varchar2);

PROCEDURE pay (p_key number, ref_ out oper.ref%type, err_ out varchar2);

PROCEDURE before_pay_to_6(p_key number);

PROCEDURE pay_to_6;

PROCEDURE before_pay_to_crnv(p_key number);

PROCEDURE pay_to_crnv;

PROCEDURE PAY_JOB;

/**
 * header_version - возвращает версию заголовка пакета NERUHOMI
 */
   FUNCTION header_version
      RETURN VARCHAR2;

/**
 * body_version - возвращает версию тела пакета NERUHOMI
 */
   FUNCTION body_version
      RETURN VARCHAR2;
-------------------
END NERUHOMI;
/
CREATE OR REPLACE PACKAGE BODY BARS.NERUHOMI IS
  g_body_version CONSTANT VARCHAR2(64) := 'version 1.4  22/11/2017';
  g_is_error     boolean := false;
  g_cur_rep_id   number := -1;
  g_cur_block_id number := -1;
  G_XMLHEAD constant varchar2(100) := '<?xml version="1.0" encoding="utf-8"?>';

  procedure stop_batch
    is
    pragma autonomous_transaction;
    begin
      update batch_immobile b set b.status='INPROGRESS' where b.status='NEW';
      commit;
      end stop_batch;

  -- Ф-ція отримання залишку %%
  FUNCTION get_percent(p_key number) RETURN NUMBER IS
    ern CONSTANT POSITIVE := 208;
    err EXCEPTION;
    erm      VARCHAR2(80);
    l_dato   asvo_immobile.dato%type; --Дата открытия
    l_datn   asvo_immobile.datn%type; -- Дата по которую начислено %%
    l_ost    asvo_immobile.ost%type; -- Залишок на рахунку
    l_s      asvo_immobile.ost%type := 0; --Сума нарахованих відсотків
    l_day    number;
    l_branch varchar2(32) := sys_context('bars_context', 'user_branch_mask');
    i        number := 0;
  BEGIN
    -- Получение даты по которую начислено %%
    begin
      select nvl(datn, nvl(dato, to_date('01/01/1900', 'dd/mm/yyyy')) - 1) + 1,
             ost,
             dato
        into l_datn, l_ost, l_dato
        from asvo_immobile
       where key = p_key;
    exception
      when no_data_found then
        erm := '8001-Вклад с ключом ' || p_key || 'не знайдено';
        RAISE err;
    end;
    --

    -- Расчет
    begin
      FOR K IN (SELECT r, datprc, lag(prc, 1) over(order by r) prc
                  FROM (select rownum r, a.*
                          from (select to_date('01011800', 'ddmmyyyy') datprc,
                                       0 prc
                                  from dual
                                union all
                                SELECT p.datprc datprc, p.prc prc
                                  FROM asvo_immobile_percent p,
                                       asvo_immobile         a
                                 WHERE a.key = p_key
                                   AND a.branch = p.branch
                                   AND a.acc_card = p.acc_card
                                   AND a.mark = p.mark
                                   AND p.branch LIKE l_branch
                                UNION ALL
                                SELECT TRUNC(SYSDATE) - 1 datprc, p.prc prc
                                  FROM asvo_immobile_percent p,
                                       asvo_immobile         a
                                 WHERE a.key = p_key
                                   AND a.branch = p.branch
                                   AND a.acc_card = p.acc_card
                                   AND a.mark = p.mark
                                   AND p.branch LIKE l_branch
                                   AND p.datprc =
                                       (SELECT MAX(p.datprc)
                                          FROM asvo_immobile_percent p,
                                               asvo_immobile         a
                                         WHERE a.key = p_key
                                           AND a.branch = p.branch
                                           AND a.acc_card = p.acc_card
                                           AND a.mark = p.mark
                                           AND p.branch LIKE l_branch)) a
                         ORDER BY datprc)) loop
        begin
          if (l_datn < k.datprc) then
            if l_dato is null then
              erm := '8002-Не можливо розрахувати %% відсутня дата відкриття';
              RAISE err;
            end if;

            l_s    := l_s +
                      (l_ost * (k.prc / 100) / 365 * (k.datprc - l_datn) * 100);
            l_datn := k.datprc;
          else
            l_s := 0;
          end if;
        end;
      end loop;
    end;
    --
    return round(l_s / 100);
  END get_percent;

  -- Ф-ція отримання NLS(ASVO)
  FUNCTION get_NLS(p_key number) RETURN NUMBER IS
    l_nls asvo_immobile.nls%type;
  BEGIN
    begin
      select nls into l_nls from asvo_immobile where key = p_key;
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Не знайдено вклад з ключем ' || p_key);
    end;
    return l_nls;
  END;

  -- Ф-ція отримання FIO
  FUNCTION get_FIO(p_key number) RETURN VARCHAR2 IS
    l_fio asvo_immobile.fio%type;
  BEGIN
    begin
      select fio into l_fio from asvo_immobile where key = p_key;
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Не знайдено вклад з ключем ' || p_key);
    end;
    return l_fio;
  END;

  --Повертає назву рахунку
  FUNCTION get_nms(p_nls accounts.nls%type, p_kv accounts.kv%type)
    RETURN VARCHAR2 IS
    l_nms accounts.nms%type;
  BEGIN
    begin
      select substr(nms, 1, 38)
        into l_nms
        from accounts
       where nls = p_nls
         and kv = p_kv;
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Рахунок ' || p_nls || ', валюта ' || p_kv ||
                                ' не знайдено!');
    end;
    return l_nms;
  END;

  --
  function extract(p_xml       in xmltype,
                   p_xpath     in varchar2,
                   p_mandatory in number) return varchar2 is
  begin
    begin
      return p_xml.extract(p_xpath).getStringVal();
    exception
      when others then
        if p_mandatory is null or g_is_error then
          return null;
        else
          if sqlcode = -30625 then
            bars_error.raise_nerror('BCK',
                                    'XMLTAG_NOT_FOUND',
                                    p_xpath,
                                    g_cur_block_id,
                                    g_cur_rep_id);
          else
            raise;
          end if;
        end if;
    end;
  end;

  procedure generate_envelope(p_req in out nocopy soap_rpc.t_request,
                              p_env in out nocopy varchar2) as
  begin
    p_env := G_XMLHEAD || '<soap:Envelope ' ||
             'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' ||
             'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' ||
             'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' ||
             '<soap:Body>' || '<' || p_req.method || ' xmlns="' ||
             p_req.namespace || '">' || p_req.body || '</' || p_req.method || '>' ||
             '</soap:Body>' || '</soap:Envelope>';
  end;

  -- получает строку с ошибкой и генерирует исключение
  --
  procedure check_fault(p_resp in out nocopy soap_rpc.t_response) as
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

    utl_http.set_transfer_timeout(g_transfer_timeout);

    -- SSL соединение выполняем через wallet
    if (instr(lower(p_req.url), 'https://') > 0) then
      utl_http.set_wallet(p_req.wallet_dir, p_req.wallet_pass);
    end if;

    l_http_req := utl_http.begin_request(p_req.url, 'POST', 'HTTP/1.0');
    utl_http.set_body_charset(l_http_req, 'UTF-8');
    utl_http.set_header(l_http_req,
                        'Content-Type',
                        'text/xml; charset=UTF-8');
    utl_http.set_header(l_http_req,
                        'Content-Length',
                        lengthb(convert(l_env, 'utf8')));
    utl_http.set_header(l_http_req,
                        'SOAPAction',
                        p_req.namespace || p_req.method);
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

    l_resp.doc := xmltype.createxml(l_res);
    l_resp.doc := l_resp.doc.extract('/soap:Envelope/soap:Body/child::node()',
                                     'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
    check_fault(l_resp);
    return l_resp;
  end;

  --
  -- Возвращает параметр из web_config
  --
  function get_param_webconfig(par varchar2) return web_barsconfig.val%type is
    l_res web_barsconfig.val%type;
  begin
    select val into l_res from web_barsconfig where key = par;
    return trim(l_res);
  exception
    when no_data_found then
      raise_application_error(-20000,
                              'Не найден KEY=' || par ||
                              ' в таблице web_barsconfig!');
  end;

  ---
  -- Возвращает следующий свободный номер папки или той у которой статус NEW
  --
  function get_next_batch_id(p_direction varchar2, p_bsd varchar2, p_ob22 varchar2, p_kv varchar2, p_branch varchar2, p_userid number) return batch_immobile.id%type
    is
    l_batch_id batch_immobile.id%type;
    begin
     begin
      select b.id into l_batch_id from batch_immobile b
      where b.status='NEW' and direction = p_direction
      and bsd=p_bsd
      and ob22=p_ob22
      and kv=p_kv
      and branch=p_branch
      and userid=p_userid for update;
      exception when no_data_found then
        l_batch_id :=s_batch_immobile.nextval();
        end;
        return l_batch_id;
      end get_next_batch_id;

  function encode_row_to_base(par varchar2) return varchar2 is
    begin
      return utl_encode.text_encode(par, encoding => utl_encode.base64);
    end;

   /*function Encode(p_clob clob) return clob is
      l_clob   clob;
      l_len    number;
      l_pos    number := 1;
      l_buffer varchar2(32767);
      l_amount number := 10000;
      begin
          l_len := dbms_lob.getlength(p_clob);
          dbms_lob.createtemporary(l_clob, true);

          while l_pos <= l_len loop
              dbms_lob.read (p_clob, l_amount, l_pos, l_buffer);
              l_buffer := utl_encode.text_encode(l_buffer, encoding => utl_encode.base64);
              l_pos := l_pos + l_amount;
              dbms_lob.writeappend(l_clob, length(l_buffer), l_buffer);
          end loop;

          return l_clob;
      end;*/


 procedure transfer_xml(xml_body clob, ret_ out clob)
   is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_message  varchar2(4000);
    l_clob     clob;
   begin
      --подготовить реквест
    l_request := soap_rpc.new_request(p_url         => get_param_webconfig('Ner.Url'),
                                      p_namespace   => 'http://tempuri.org/',
                                      p_method      => 'BatchSet',
                                      p_wallet_dir  => get_param_webconfig('Ner.Wallet_dir'),
                                      p_wallet_pass => get_param_webconfig('Ner.Wallet_pass'));


    -- добавить параметры
    soap_rpc.add_parameter(l_request,
                           'BatchData',
                            xml_body
                           );

    -- позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);

     --Фикс неприятности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);

    ret_:=extract(l_tmp, '/BatchSetResponse/BatchSetResult/text()', null);

   end transfer_xml;

  ---
  -- Процедура передачи через WEB - сервис(старая)
  --
  procedure transfer(p_FIO      varchar2, -- FIO      IS 'ФИО';
                     p_IDCODE   varchar2, -- IDCODE   IS 'Идентификационный код';
                     p_DOCTYPE  varchar2, -- DOCTYPE  IS 'Тип документа (1-паспорт,2-свидетельство о рождении,3-военный билет,0-прочее)';
                     p_PASP_S   varchar2, -- PASP_S   IS 'Серия паспорта (документа)';
                     p_PASP_N   varchar2, -- PASP_N   IS 'Номер паспорта (документа)';
                     p_PASP_W   varchar2, -- PASP_W   IS 'Кем выдан паспорт (документ)';
                     p_PASP_D   varchar2, -- PASP_D   IS 'Дата выдачи паспорта (документа)';
                     p_BIRTHDAT varchar2, -- BIRTHDAT IS 'Дата рождения';
                     p_BIRTHPL  varchar2, -- BIRTHPL  IS 'Место рождения';
                     p_SEX      varchar2, -- SEX      IS 'Пол (1-мужской, 2-женский)';
                     p_POSTIDX  varchar2, -- POSTIDX  IS 'Почтовый индекс';
                     p_REGION   varchar2, -- REGION   IS 'Область';
                     p_DISTRICT varchar2, -- DISTRICT IS 'Район';
                     p_CITY     varchar2, -- CITY     IS 'Город';
                     p_ADDRESS  varchar2, -- ADDRESS  IS 'Адрес (улица, дом, квартира)';
                     p_PHONE_H  varchar2, -- PHONE_H  IS 'Домашний телефон';
                     p_PHONE_J  varchar2, -- PHONE_J  IS 'Рабочий телефон';
                     p_REGDATE  varchar2, -- REGDATE  IS 'Дата регистрации вкладчика';
                     p_NLS      varchar2, -- NLS      IS 'Лицевой счет';
                     p_DATO     varchar2, -- DATO     IS 'Дата открытия основного вклада';
                     p_OST      varchar2, -- OST      IS 'Остаток на вкладе в коп.';
                     p_SUM      varchar2, -- SUM      IS 'Сумма в коп., которую нужно выплатить. Будет использоваться для наследников.';
                     p_DATN     varchar2, -- DATN     IS 'Дата, по!!! которую начислены проценты';
                     p_BRANCH   varchar2, -- BRANCH   IS 'Номер подразделения Ощадбанка в БАРСе';
                     p_BSD      varchar2, -- BSD      IS 'Бал. счет';
                     p_OB22DE   varchar2, -- OB22DE   IS 'OB22 вклада';
                     p_BSN      varchar2, -- BSN      IS 'Бал. счет начисленных процентов';
                     p_OB22IE   varchar2, -- OB22IE   IS 'OB22 начисленных процентов';
                     p_BSD7     varchar2, -- BSD7     IS 'Бал. счет процентных затрат';
                     p_OB22D7   varchar2, -- OB22D7   IS 'OB22 процентных затрат';
                     p_source   varchar2, -- source   IS 'Источник вклада';
                     p_kv       varchar2, -- KV       IS 'Код валюты вклада';
                     p_nd       varchar2, -- ND       IS 'Номер договора в депозитной системе';
                     p_dptid    varchar2, -- DPTID    IS 'ID в депозитной системе';
                     p_LANDCOD  varchar2, -- LANDCOD  IS 'Код страны (гражданство)';
                     p_FL       varchar2, -- fl       IS 'Флаг обработки';
                     p_DZAGR    varchar2, -- dzagr    IS 'Дата загрузки в АБС';
                     p_ref      varchar2, -- ref      IS 'Референс документа входной'
                     ret_       out varchar2) is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_message  varchar2(4000);
    l_clob     clob;
  begin
    --подготовить реквест
    l_request := soap_rpc.new_request(p_url         => get_param_webconfig('Ner.Url'),
                                      p_namespace   => 'http://tempuri.org/',
                                      p_method      => 'Set',
                                      p_wallet_dir  => get_param_webconfig('Ner.Wallet_dir'),
                                      p_wallet_pass => get_param_webconfig('Ner.Wallet_pass'));

    --добавить параметры

    soap_rpc.add_parameter(l_request, 'p_FIO', p_FIO);
    soap_rpc.add_parameter(l_request, 'p_IDCODE', p_IDCODE);
    soap_rpc.add_parameter(l_request, 'p_DOCTYPE', p_DOCTYPE);
    soap_rpc.add_parameter(l_request, 'p_PASP_S', p_PASP_S);
    soap_rpc.add_parameter(l_request, 'p_PASP_N', p_PASP_N);
    soap_rpc.add_parameter(l_request, 'p_PASP_W', p_PASP_W);
    soap_rpc.add_parameter(l_request, 'p_PASP_D', p_PASP_D);
    soap_rpc.add_parameter(l_request, 'p_BIRTHDAT', p_BIRTHDAT);
    soap_rpc.add_parameter(l_request, 'p_BIRTHPL', p_BIRTHPL);
    soap_rpc.add_parameter(l_request, 'p_SEX', p_SEX);
    soap_rpc.add_parameter(l_request, 'p_POSTIDX', p_POSTIDX);
    soap_rpc.add_parameter(l_request, 'p_REGION', p_REGION);
    soap_rpc.add_parameter(l_request, 'p_DISTRICT', p_DISTRICT);
    soap_rpc.add_parameter(l_request, 'p_CITY', p_CITY);
    soap_rpc.add_parameter(l_request, 'p_ADDRESS', p_ADDRESS);
    soap_rpc.add_parameter(l_request, 'p_PHONE_H', p_PHONE_H);
    soap_rpc.add_parameter(l_request, 'p_PHONE_J', p_PHONE_J);
    soap_rpc.add_parameter(l_request, 'p_REGDATE', p_REGDATE);
    soap_rpc.add_parameter(l_request, 'p_NLS', p_NLS);
    soap_rpc.add_parameter(l_request, 'p_DATO', p_DATO);
    soap_rpc.add_parameter(l_request, 'p_OST', p_OST);
    soap_rpc.add_parameter(l_request, 'p_SUM', p_SUM);
    soap_rpc.add_parameter(l_request, 'p_DATN', p_DATN);
    soap_rpc.add_parameter(l_request, 'p_BRANCH', p_BRANCH);
    soap_rpc.add_parameter(l_request, 'p_BSD', p_BSD);
    soap_rpc.add_parameter(l_request, 'p_OB22DE', p_OB22DE);
    soap_rpc.add_parameter(l_request, 'p_BSN', p_BSN);
    soap_rpc.add_parameter(l_request, 'p_OB22IE', p_OB22IE);
    soap_rpc.add_parameter(l_request, 'p_BSD7', p_BSD7);
    soap_rpc.add_parameter(l_request, 'p_OB22D7', p_OB22D7);
    soap_rpc.add_parameter(l_request, 'p_source', p_source);
    soap_rpc.add_parameter(l_request, 'p_kv', p_kv);
    soap_rpc.add_parameter(l_request, 'p_nd', p_nd);
    soap_rpc.add_parameter(l_request, 'p_dptid', p_dptid);
    soap_rpc.add_parameter(l_request, 'p_LANDCOD', p_LANDCOD);
    soap_rpc.add_parameter(l_request, 'p_FL', p_FL);
    soap_rpc.add_parameter(l_request, 'p_DZAGR', p_DZAGR);
    soap_rpc.add_parameter(l_request, 'p_ref', p_ref);

    --позвать метод веб-сервиса
    l_response := invoke(l_request);

    --Фикс неприятности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);

    ret_ := extract(l_tmp, '/SetResponse/SetResult/text()', null);

  end transfer;

  --Процедура оплати
  PROCEDURE pay(p_key number, ref_ out oper.ref%type, err_ out varchar2) is
    l_bankdate   DATE;
    l_mfo        banks.mfo%type;
    l_kv         oper.kv%type;
    l_dk         number;
    l_vob        number;
    l_ref        oper.ref%type;
    l_s          oper.s%type;
    l_nazn       oper.nazn%type;
    l_tt         tts.tt%type;
    l_tt_cash    tts.tt%type;
    l_okpo_a     customer.okpo%type;
    l_okpo_b     customer.okpo%type;
    l_nls_a      accounts.nls%type;
    l_nls_b      accounts.nls%type;
    l_nam_a      oper.nam_a%type;
    l_nam_b      oper.nam_b%type;
    l_ost        asvo_immobile.ost%type;
    l_nls_b_cash accounts.nls%type;
    l_sk         oper.sk%type;
    l_fl         asvo_immobile.fl%type;
    l_bsd asvo_immobile.bsd%type;
    l_ob22de asvo_immobile.ob22de%type;
    l_branch asvo_immobile.branch%type;
  BEGIN

    l_bankdate   := gl.bdate;
    l_mfo        := f_ourmfo;
    l_dk         := 1;
    l_vob        := 88;
    l_ref        := null;
   -- l_s          := get_percent(p_key);
    l_nazn       := 'Закриття нерухомого вкладу №' || get_nls(p_key) || ' ' || get_fio(p_key);
    l_okpo_a     := f_ourokpo;
    l_okpo_b     := l_okpo_a;
    l_tt         := 'HPX';
    l_tt_cash    := 'DP1';
    l_nls_b_cash := tobopack.GetToboCASH;
    l_sk         := '55';

    begin
      select
             ost,
             fl, kv, bsd, ob22de, branch
        into  l_ost, l_fl, l_kv,l_bsd,l_ob22de,l_branch
        from asvo_immobile
       where key = p_key for update;
    exception
      when no_data_found then
        raise_application_error(-20000,'Не знайдено вклад з ключем ' || p_key);
    end;

    l_nls_b:=nbs_ob22_null(l_bsd,l_ob22de,l_branch);

    if l_nls_b is null then
      raise_application_error(-20000, 'Не знайдено рахунок '||l_bsd||'/'||l_ob22de||' для відділення "'||l_branch||'"');
      end if;

    if l_fl = 0 then
      l_nam_b := get_nms(l_nls_b_cash, l_kv);
      l_nam_a := get_nms(l_nls_b, l_kv);
      -- Сума на касу
    --  l_ost := l_ost + l_s;

      begin
        savepoint sp_before;

        gl.ref(l_ref);

        insert into oper
          (ref,
           tt,
           vob,
           nd,
           dk,
           pdat,
           vdat,
           datd,
           nam_a,
           nlsa,
           mfoa,
           id_a,
           nam_b,
           nlsb,
           mfob,
           id_b,
           kv,
           s,
           kv2,
           s2,
           nazn,
           userid,
           sk)
        values
          (l_ref,
           l_tt_cash,
           l_vob,
           l_ref,
           l_dk,
           sysdate,
           l_bankdate,
           l_bankdate,
           l_nam_a,
           l_nls_b,
           l_mfo,
           l_okpo_a,
           l_nam_b,
           l_nls_b_cash,
           l_mfo,
           l_okpo_b,
           l_kv,
           l_ost,
           l_kv,
           l_ost,
           substr(l_nazn, 1, 160),
           user_id,
           l_sk);
       /* --Оплата відсотків 26_8 --> 26_0
        paytt(null,
              l_ref,
              l_bankdate,
              l_tt,
              l_dk,
              l_kv,
              l_nls_a,
              l_s,
              l_kv,
              l_nls_b,
              l_s);*/
        --Оплата з 26_0 -->1002
        paytt(null,
              l_ref,
              l_bankdate,
              l_tt_cash,
              l_dk,
              l_kv,
              l_nls_b,
              l_ost,
              l_kv,
              l_nls_b_cash,
              l_ost);

        ref_ := l_ref;

        update asvo_immobile set fl = 5, refpay = l_ref where key = p_key;
      exception
        when others then
          l_ref := null;
          rollback to sp_before;
          err_ := SQLERRM;
      end;
    else
      err_ := 'По даному клієнту вже була виконана виплата!';
    end if;
  END;

  ----
  -- Оплата на 6 клас
  -- По розговору с Гудемчук понятно что платим суммы до 10.00 грн.
  --
  PROCEDURE pay_to_6 is
    l_ref      oper.ref%type;
    l_tt       tts.tt%type;
    l_vob      oper.vob%type := 6;
    l_dk       oper.dk%type := 1;
    l_bankdate date := gl.bDATE;
    l_nam_a    oper.nam_a%type;
    l_nls_a    oper.nlsa%type;
    l_mfo      oper.mfoa%type := gl.aMFO;
    l_okpo_a   oper.id_a%type := f_ourokpo;
    l_nam_b    oper.nam_b%type;
    l_nls_b    oper.nlsb%type;
    l_okpo_b   oper.id_b%type := f_ourokpo;
    l_kv       oper.kv%type;
    l_ost_eq   oper.s%type;
    l_nazn     oper.nazn%type;
    l_sk       oper.sk%type;
    l_rec_asvo asvo_immobile%rowtype;
    l_err      varchar2(4000);

  BEGIN

    --Останавливаем наполнение пачки и обрабатываем с статусом INPROGRESS and ERROR
     stop_batch;

    for l_rec_asvo in(select a.bsd, a.ob22de ob22, c.batch_id,a.kv, a.branch, b.userid, sum(ost) ost
                       from crnv_que c, batch_immobile b, asvo_immobile a
              where a.key=c.key
              and c.batch_id=b.id
              and b.direction='INTERNAL'
              and b.status in('INPROGRESS','ERROR')
              group by  a.bsd, a.ob22de,  c.batch_id,a.kv, a.branch, b.userid)
  loop
    ---
    -- Подбор счета Б (счет 6 класса)
    --
    begin
      select a.nls, substr(a.nms, 1, 38)
        into l_nls_b, l_nam_b
        from accounts a
       where nls = nbs_ob22_null('6110', '28', l_rec_asvo.branch)
         and kv = 980;
    exception
      when no_data_found then
        l_err := 'Не удалось найти счет 6110/28 для бранча "' ||
                 l_rec_asvo.branch || '"';
        update batch_immobile b set b.status='ERROR', b.last_time_refresh=sysdate
        where b.id=l_rec_asvo.batch_id;
        update asvo_immobile set fl = -1, errmsg = l_err
        where key in(select key from crnv_que where batch_id=l_rec_asvo.batch_id);
    end;

    ---
    -- Подбор котлового счета
    --
    begin
      select a.nls, substr(a.nms, 1, 38)
        into l_nls_a, l_nam_a
        from accounts a
       where nls like case l_rec_asvo.bsd when '2635' then '2630' else l_rec_asvo.bsd end ||'_00'||case l_rec_asvo.bsd when '2620' then '30' when '2630' then '46' when '2635' then '38' end||substr(l_rec_asvo.branch,11,4)
         and kv = l_rec_asvo.kv;
    exception
      when no_data_found then
        l_err := 'Не удалось найти счет ' ||
        case l_rec_asvo.bsd when '2635' then '2630' else l_rec_asvo.bsd end ||'_00'||case l_rec_asvo.bsd when '2620' then '30' when '2630' then '46' when '2635' then '38' end || substr(l_rec_asvo.branch,11,4);

        update batch_immobile b set b.status='ERROR', b.last_time_refresh=sysdate
        where b.id=l_rec_asvo.batch_id;
        update asvo_immobile set fl = -1, errmsg = l_err
        where key in(select key from crnv_que where batch_id=l_rec_asvo.batch_id);

    end;

    l_kv   := l_rec_asvo.kv;
    l_sk   := null;
    l_nazn := 'Перерахування на доходи банку';

    if l_rec_asvo.kv = 980 then
      l_tt     := 'NN6';
      l_ost_eq := l_rec_asvo.ost;
    else
      l_tt     := 'D06';
      l_ost_eq := gl.p_icurval(l_rec_asvo.kv, l_rec_asvo.ost, l_bankdate);
    end if;

    --Оплата
    begin
      savepoint sp_before;
      gl.ref(l_ref);
      insert into oper
        (ref,
         tt,
         vob,
         nd,
         dk,
         pdat,
         vdat,
         datd,
         datp,
         nam_a,
         nlsa,
         mfoa,
         id_a,
         nam_b,
         nlsb,
         mfob,
         id_b,
         kv,
         s,
         kv2,
         s2,
         nazn,
         userid,
         sk)
      values
        (l_ref,
         l_tt,
         l_vob,
         l_ref,
         l_dk,
         sysdate,
         l_bankdate,
         l_bankdate,
         l_bankdate,
         l_nam_a,
         l_nls_a,
         l_mfo,
         l_okpo_a,
         l_nam_b,
         l_nls_b,
         l_mfo,
         l_okpo_b,
         l_kv,
         l_rec_asvo.ost,
         980,
         l_ost_eq,
         substr(l_nazn, 1, 160),
         l_rec_asvo.userid,
         l_sk);

      paytt(null,
            l_ref,
            l_bankdate,
            l_tt,
            l_dk,
            l_kv,
            l_nls_a,
            l_rec_asvo.ost,
            980,
            l_nls_b,
            l_ost_eq);

        update batch_immobile b set b.status='SUCCEEDED', b.last_time_refresh=sysdate
        where b.id=l_rec_asvo.batch_id;

        update asvo_immobile set fl = 4, refout = l_ref, errmsg=null, batch_id=l_rec_asvo.batch_id
        where key in(select key from crnv_que where batch_id=l_rec_asvo.batch_id);

        delete from crnv_que where batch_id=l_rec_asvo.batch_id;

    exception
      when others then
        l_ref := null;
        rollback to sp_before;
        l_err := SQLERRM;
        --ставим отметку про ошибку
        update batch_immobile b set b.status='ERROR', b.last_time_refresh=sysdate
        where b.id=l_rec_asvo.batch_id;
        update asvo_immobile set fl = -1, errmsg = l_err
        where key in(select key from crnv_que where batch_id=l_rec_asvo.batch_id);
    end; -- конец оплаты
   end loop;
  END pay_to_6;

  ----
  -- Оплата на ЦРНВ
  --
  --
  /*
   1.1.   В АБС РУ формується 1 СЕП-кред.платіж на суму однорідних нерухомих, а саме:

   МФО-А = 302076  Рах-А = 2635 – деякий котловий рахунок картотеки нерухомих з АСВО деякого бранчу-3, що передається до ЦБД, або ж аналітичний рахунок реального вкладу із портфелю, по якому прийнято рішення про переведення в стан нерухомих та передачі в ЦБД.
   МФО-Б = 300465  Рах-Б = 2635314302076


   1.2.   А також в АБС РУ формується 1 СЕП-деб.запит на відшкодування кредитних ресурсів на суму (1.1), а саме:

   МФО-А = 302076 Рах-А = 3903914302076
   МФО-Б = 300465 Рах-Б = 3902714302076

  */
  PROCEDURE pay_to_crnv is
    l_ret varchar2(4000);
    l_ref                       oper.ref%type;
    l_tt                        tts.tt%type;
    l_vob                       oper.vob%type := 6;
    l_dk                        oper.dk%type := 1;
    l_bankdate                  date := gl.bDATE;
    l_nam_a                     oper.nam_a%type := substr(f_ourname_g,
                                                          1,
                                                          38);
    l_nls_a                     oper.nlsa%type;
    l_mfo_a                     oper.mfoa%type := gl.aMFO;
    l_mfo_b                     oper.mfoa%type := '300465';
--    l_mfo_b                     oper.mfoa%type := '303398';
    l_okpo_a                    oper.id_a%type := f_ourokpo;
    l_nam_b                     oper.nam_b%type := 'АТ "Ощадбанк"';
    l_nls_b                     oper.nlsb%type;
    l_okpo_b                    oper.id_b%type := '00032129';
    --l_okpo_b                    oper.id_b%type := '00032129';
    l_kv                        oper.kv%type;
    l_nazn                      oper.nazn%type;
    l_sk                        oper.sk%type;
   -- l_rec_asvo                  asvo_immobile%rowtype;
    l_rec_exchange_of_resources exchange_of_resources%rowtype;
    l_err                       varchar2(4000);
    ---
    -- Информ. платеж
    --
    l_ref_inf   oper.ref%type;
    l_dk_inf    oper.dk%type;
    l_tt_inf    tts.tt%type;
    l_nazn_inf  oper.nazn%type;
    l_nam_a_inf oper.nam_a%type := substr(f_ourname_g, 1, 38);
    l_nls_a_inf oper.nlsa%type;
    l_nam_b_inf oper.nam_b%type := 'АТ "Ощадбанк"';
    l_nls_b_inf oper.nlsb%type;
    l_xml_body clob;
    l_tabn staff.tabn%type;

  BEGIN
  tuda;
    select e.*
      into l_rec_exchange_of_resources
      from exchange_of_resources e
     where mfo = l_mfo_a;
     --Останавливаем наполнение пачки и обрабатываем с статусом INPROGRESS and ERROR
     stop_batch;

    for l_rec_asvo in(select a.bsd, a.ob22de ob22, c.batch_id,a.kv, a.branch, b.userid, sum(ost) ost
      from crnv_que c, batch_immobile b, asvo_immobile a
              where a.key=c.key
              and c.batch_id=b.id
              and b.direction='EXTERNAL'
              and b.status in('INPROGRESS','ERROR')
              group by  a.bsd, a.ob22de,  c.batch_id,a.kv, a.branch, b.userid)

  loop


    ---
    -- Подбор котлового счета (Счет А)
    --
    begin
      select a.nls
        into l_nls_a
        from accounts a
       where nls like case l_rec_asvo.bsd when '2635' then '2630' else l_rec_asvo.bsd end ||'_00'||case l_rec_asvo.bsd when '2620' then '30' when '2630' then '46' when '2635' then '38' end||substr(l_rec_asvo.branch,11,4)
         and kv = l_rec_asvo.kv;
    exception
      when no_data_found then
        l_err := 'Не удалось найти счет ' || case l_rec_asvo.bsd when '2635' then '2630' else l_rec_asvo.bsd end ||'_00'
                                          ||case l_rec_asvo.bsd when '2620' then '30' when '2630' then '46' when '2635' then '38' end
                                          ||substr(l_rec_asvo.branch,11,4);
        update batch_immobile b set b.status='ERROR', b.last_time_refresh=sysdate
        where b.id=l_rec_asvo.batch_id;
        update asvo_immobile set fl = -2, errmsg = l_err
        where key in(select key from crnv_que where batch_id=l_rec_asvo.batch_id);

    end;

    begin
     select tabn into l_tabn from staff$base  where id=l_rec_asvo.userid;
     exception when no_data_found then l_tabn:=null;
    end;

    l_kv        := l_rec_asvo.kv;
    l_sk        := null;
    l_nazn      := 'Перерахування нерухомих вкладів в ЦРНВ';
    if l_rec_asvo.kv=980 then
        l_tt        := 'DP3';
    else
        l_tt        := 'DPJ';
    end if;
    l_nazn_inf  := 'Запит на відшкодування кредитних ресурсів';
    l_tt_inf    := '014';
    l_dk_inf    := 2;
    l_nls_a_inf := l_rec_exchange_of_resources.nls_3903;
    l_nls_b_inf := l_rec_exchange_of_resources.nls_3902;
    l_nls_b     := vkrzn(substr(l_mfo_b,1,5),
    case l_rec_asvo.bsd
        when '2620' then '2620_030'||l_mfo_a
        when '2630' then '2630_046'||l_mfo_a
        when '2635' then '2630_038'||l_mfo_a
    end
    );

    --Оплата по ВПС + позвать создание Дебет информ. чтоб нам компенсировали ресурс
    begin
      savepoint sp_before;

      -- Реальные деньги
      gl.ref(l_ref);

      insert into oper
        (ref,
         tt,
         vob,
         nd,
         dk,
         pdat,
         vdat,
         datd,
         datp,
         nam_a,
         nlsa,
         mfoa,
         id_a,
         nam_b,
         nlsb,
         mfob,
         id_b,
         kv,
         s,
         kv2,
         s2,
         nazn,
         userid,
         sk)
      values
        (l_ref,
         l_tt,
         l_vob,
         l_ref,
         l_dk,
         sysdate,
         l_bankdate,
         l_bankdate,
         l_bankdate,
         l_nam_a,
         l_nls_a,
         l_mfo_a,
         l_okpo_a,
         l_nam_b,
         l_nls_b,
         l_mfo_b,
         l_okpo_a,
         l_kv,
         l_rec_asvo.ost,
         l_kv,
         l_rec_asvo.ost,
         substr(l_nazn, 1, 160),
         l_rec_asvo.userid,
         l_sk);

      paytt(null,
            l_ref,
            l_bankdate,
            l_tt,
            l_dk,
            l_kv,
            l_nls_a,
            l_rec_asvo.ost,
            l_kv,
            l_nls_b,
            l_rec_asvo.ost);

      -- + информ. Дт.
      gl.ref(l_ref_inf);
      gl.in_doc3(ref_   => l_ref_inf,
                 tt_    => l_tt_inf,
                 vob_   => 6,
                 nd_    => l_ref_inf,
                 pdat_  => sysdate,
                 vdat_  => l_bankdate,
                 dk_    => l_dk_inf,
                 kv_    => l_kv,
                 s_     => l_rec_asvo.ost,
                 kv2_   => l_kv,
                 s2_    => l_rec_asvo.ost,
                 sk_    => null,
                 data_  => l_bankdate,
                 datp_  => l_bankdate,
                 nam_a_ => l_nam_a_inf,
                 nlsa_  => l_nls_a_inf,
                 mfoa_  => l_mfo_a,
                 nam_b_ => l_nam_b_inf,
                 nlsb_  => l_nls_b_inf,
                 mfob_  => l_mfo_b,
                 nazn_  => substr(l_nazn_inf||'('||l_ref||')', 1, 160),
                 d_rec_ => null,
                 id_a_  => l_okpo_a,
                 id_b_  => l_okpo_b,
                 id_o_  => l_tabn,
                 sign_  => null,
                 sos_   => 0,
                 prty_  => null,
                 uid_   => l_rec_asvo.userid);


      /*transfer(p_FIO      =>l_rec_asvo.fio,
               p_IDCODE   =>l_rec_asvo.idcode,
               p_DOCTYPE  =>l_rec_asvo.doctype,
               p_PASP_S   =>l_rec_asvo.pasp_s,
               p_PASP_N   =>l_rec_asvo.pasp_n,
               p_PASP_W   =>l_rec_asvo.pasp_w,
               p_PASP_D   =>to_char(l_rec_asvo.pasp_d,'dd/mm/yyyy'),
               p_BIRTHDAT =>to_char(l_rec_asvo.birthdat,'dd/mm/yyyy'),
               p_BIRTHPL  =>l_rec_asvo.birthpl,
               p_SEX      =>l_rec_asvo.sex,
               p_POSTIDX  =>l_rec_asvo.postidx,
               p_REGION   =>l_rec_asvo.region,
               p_DISTRICT =>l_rec_asvo.district,
               p_CITY     =>l_rec_asvo.city,
               p_ADDRESS  =>l_rec_asvo.address,
               p_PHONE_H  =>l_rec_asvo.phone_h,
               p_PHONE_J  =>l_rec_asvo.phone_j,
               p_REGDATE  =>to_char(l_rec_asvo.regdate,'dd/mm/yyyy'),
               p_NLS      =>l_rec_asvo.nls,
               p_DATO     =>to_char(l_rec_asvo.dato,'dd/mm/yyyy'),
               p_OST      =>l_rec_asvo.ost,
               p_SUM      =>l_rec_asvo.sum,
               p_DATN     =>to_char(l_rec_asvo.datn,'dd/mm/yyyy'),
               p_BRANCH   =>l_rec_asvo.branch,
               p_BSD      =>l_rec_asvo.bsd,
               p_OB22DE   =>l_rec_asvo.ob22de,
               p_BSN      =>l_rec_asvo.bsn,
               p_OB22IE   =>l_rec_asvo.ob22ie,
               p_BSD7     =>l_rec_asvo.bsd7,
               p_OB22D7   =>l_rec_asvo.ob22d7,
               p_source   =>l_rec_asvo.source,
               p_kv       =>l_rec_asvo.kv,
               p_nd       =>l_rec_asvo.nd,
               p_dptid    =>l_rec_asvo.dptid,
               p_LANDCOD  =>l_rec_asvo.landcod,
               p_FL       =>5,
               p_DZAGR    =>to_char(sysdate, 'dd/mm/yyyy'),
               p_ref      =>l_rec_asvo.refout,
               ret_       =>l_ret);
*/



                select '<?xml version="1.0" encoding="windows-1251" ?>' ||
                 xmlelement("data_batch", xmlattributes(f_ourmfo_g as "mfo", c.batch_id as "batch_id", b.bsd as "bsd", b.ob22 as "ob22", b.kv as "kv", sum(nvl(a.ost,0)) as "sum", to_char(b.create_date,'yyyymmddhh24miss') as "batch_date"),
                 xmlagg(xmlelement("immdeposit",
                 xmlelement("FIO", encode_row_to_base(nvl(a.fio,'Empty'))),
                 xmlelement("IDCODE", a.idcode),
                 xmlelement("DOCTYPE", a.doctype),
                 xmlelement("PASP_S", encode_row_to_base(nvl(a.pasp_s,'  '))),
                 xmlelement("PASP_N", a.pasp_n),
                 xmlelement("PASP_W", encode_row_to_base(nvl(a.pasp_w,'Empty'))),
                 xmlelement("PASP_D",
                 to_char(a.pasp_d,'dd/mm/yyyy')),
                 xmlelement("BIRTHDAT", to_char(a.birthdat,'dd/mm/yyyy')),
                 xmlelement("BIRTHPL", encode_row_to_base(nvl(a.birthpl,'Empty'))),
                 xmlelement("SEX", a.sex),
                 xmlelement("POSTIDX", encode_row_to_base(nvl(a.postidx,'Empty'))),
                 xmlelement("REGION", encode_row_to_base(nvl(a.region,'Empty'))),
                 xmlelement("DISTRICT", encode_row_to_base(nvl(a.district,'Empty'))),
                 xmlelement("CITY", encode_row_to_base(nvl(a.city,'Empty'))),
                 xmlelement("ADDRESS", encode_row_to_base(nvl(a.address,'Empty'))),
                 xmlelement("PHONE_H", a.phone_h),
                 xmlelement("PHONE_J", a.phone_j),
                 xmlelement("REGDATE", to_char(a.regdate,'dd/mm/yyyy')),
                 xmlelement("NLS", a.nls), xmlelement("DATO", to_char(a.dato,'dd/mm/yyyy')),
                 xmlelement("OST", a.ost), xmlelement("SUM", a.sum),
                 xmlelement("DATN", to_char(a.datn,'dd/mm/yyyy')),
                 xmlelement("BRANCH", a.branch),
                 xmlelement("BSD", a.bsd),
                 xmlelement("OB22DE", a.ob22de),
                 xmlelement("BSN", a.bsn),
                 xmlelement("OB22IE", a.ob22ie),
                 xmlelement("BSD7", a.bsd7),
                 xmlelement("OB22D7", a.ob22d7),
                 xmlelement("source", encode_row_to_base(nvl(a.source,'Empty'))),
                 xmlelement("kv", a.kv),
                 xmlelement("nd", encode_row_to_base(nvl(a.nd,'Empty'))),
                 xmlelement("dptid", a.dptid),
                 xmlelement("LANDCOD", a.landcod),
                 xmlelement("FL", 5),
                 xmlelement("DZAGR", to_char(sysdate,'dd/mm/yyyy')),
                 xmlelement("ref", l_ref),
                 xmlelement("acc_card", a.acc_card),
                 xmlelement("id", a.id),
                 xmlelement("mark", a.mark),
                 xmlelement("kod_otd", a.kod_otd),
                 xmlelement("tvbv", a.tvbv),
                 xmlelement("attr", a.attr),
				 xmlelement("batch_id", c.batch_id)
                 ))).getclobval() into l_xml_body
                from asvo_immobile a, crnv_que c, batch_immobile b
               where a.key = c.key
               and c.batch_id=b.id
               and b.id=l_rec_asvo.batch_id
               group by f_ourmfo_g, c.batch_id,b.bsd, b.ob22,b.kv, to_char(b.create_date,'yyyymmddhh24miss');


            update batch_immobile b set b.status='SUCCEEDED', b.last_time_refresh=sysdate
            where b.id=l_rec_asvo.batch_id;

            update asvo_immobile set fl = 3, refout = l_ref, errmsg=null, batch_id=l_rec_asvo.batch_id
            where key in(select key from crnv_que where batch_id=l_rec_asvo.batch_id);

            delete from crnv_que where batch_id=l_rec_asvo.batch_id;

             transfer_xml(l_xml_body, l_ret);



             if l_ret<>'Ok' then
                --ставим отметку про ошибку
                raise_application_error(-20000, l_ret);
               end if;



 exception
      when others then
        l_ref := null;
        rollback to sp_before;
        l_err := SQLERRM;
        update batch_immobile b set b.status='ERROR', b.last_time_refresh=sysdate
        where b.id=l_rec_asvo.batch_id;
        update asvo_immobile set fl = -2, errmsg = l_err
        where key in(select key from crnv_que where batch_id=l_rec_asvo.batch_id);
     --   raise_application_error(-20000, l_err);
    end; -- конец оплаты
  end loop;
  END pay_to_crnv;

  ---
  -- Процедура установки флага и переноса в очередь при оплате на 6 класс
  --

PROCEDURE before_pay_to_6(p_key number) is
    l_err varchar2(4000);
    l_batch_id batch_immobile.id%type;
    l_rec_asvo asvo_immobile%rowtype;
  BEGIN
     savepoint sp_before;

      select a.* into l_rec_asvo from asvo_immobile a
      where a.key=p_key for update;

      l_batch_id :=get_next_batch_id('INTERNAL', l_rec_asvo.bsd, l_rec_asvo.ob22de, l_rec_asvo.kv, l_rec_asvo.branch, user_id);

       begin
          update batch_immobile b
          set b.last_time_refresh=sysdate
          where id=l_batch_id;
          if sql%rowcount=0 then
            insert into batch_immobile(id, create_date, status, last_time_refresh, direction, bsd, ob22, kv, branch, userid)
            values(l_batch_id, sysdate, 'NEW', sysdate, 'INTERNAL', l_rec_asvo.bsd, l_rec_asvo.ob22de, l_rec_asvo.kv, l_rec_asvo.branch, user_id);
            end if;
          end;

    update asvo_immobile set fl = 2 where key = p_key;

    insert into crnv_que (key, userid, send_time, batch_id)
    values(p_key, user_id, sysdate, l_batch_id);

  exception
    when others then
      rollback to sp_before;
      l_err := SQLERRM;
      --ставим отметку про ошибку
      update asvo_immobile set fl = -1, errmsg = l_err where key = p_key;
  END before_pay_to_6;

  PROCEDURE before_pay_to_crnv(p_key number) is
    l_err varchar2(4000);
    l_batch_id batch_immobile.id%type;
    l_rec_asvo asvo_immobile%rowtype;
  BEGIN
     savepoint sp_before;

      select a.* into l_rec_asvo from asvo_immobile a
      where a.key=p_key for update;

      l_batch_id :=get_next_batch_id('EXTERNAL', l_rec_asvo.bsd, l_rec_asvo.ob22de, l_rec_asvo.kv, l_rec_asvo.branch, user_id);



       begin
          update batch_immobile b
          set b.last_time_refresh=sysdate
          where id=l_batch_id;
          if sql%rowcount=0 then
            insert into batch_immobile(id, create_date, status, last_time_refresh, direction, bsd, ob22, kv, branch, userid)
            values(l_batch_id, sysdate, 'NEW', sysdate, 'EXTERNAL', l_rec_asvo.bsd, l_rec_asvo.ob22de, l_rec_asvo.kv, l_rec_asvo.branch, user_id);
            end if;
          end;

    update asvo_immobile set fl = 1 where key = p_key;

    insert into crnv_que (key, userid, send_time, batch_id)
    values(p_key, user_id, sysdate, l_batch_id);

  exception
    when others then
      rollback to sp_before;
      l_err := SQLERRM;
      --ставим отметку про ошибку
      update asvo_immobile set fl = -2, errmsg = l_err where key = p_key;
  END before_pay_to_crnv;

  ---
  -- Процедура для автоматического разбора очереди
  --
  PROCEDURE PAY_JOB is
  BEGIN
    --
    bc.subst_mfo(f_ourmfo_g);
    --
     begin
        --Оплата на ЦРНВ
        pay_to_crnv;
        --Оплата на 6 клас
        pay_to_6;

      end;
    --
    bc.set_context;
    --
  END PAY_JOB;

  /*
  * header_version - возвращает версию заголовка пакета NERUHOMI
  */
  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package header NERUHOMI ' || g_header_version;
  END header_version;

  /*
  * body_version - возвращает версию тела пакета NERUHOMI
  */
  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package body NERUHOMI ' || g_body_version;
  END body_version;
  --------------
END NERUHOMI;
/
 show err;
 
PROMPT *** Create  grants  NERUHOMI ***
grant EXECUTE                                                                on NERUHOMI        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/neruhomi.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 