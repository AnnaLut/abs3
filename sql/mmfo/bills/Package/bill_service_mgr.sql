
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/package/bill_service_mgr.sql =========*** R
 PROMPT ===================================================================================== 
 
create or replace package BILL_SERVICE_MGR
is
    --
    -- Передача данных по векселям [РУ - ММФО]/Банк - Казначейство
    --
    g_header_version  constant varchar2(64)  := 'version 1.7.0 23/10/2018';

    g_wallet_path                varchar2(128);
    g_wallet_pwd                 varchar2(128);
    --
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2;

    --
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2;

    --
    -- Обертка для получения текущего МФО (из контекста или глобального)
    --
    function f_ourmfo return varchar2;

    --
    -- Обертка для получения текущего имени пользователя
    --
    function f_username return varchar2;

    --
    -- Обертка для получения текущего отделения пользователя
    --
    function f_user_branch return varchar2;
    
    --
    -- Получение ошибки из логов барстранса
    --
    function f_get_transp_error (p_main_sess in varchar2) return XMLtype;

    --
    -- Отправка запроса на вебсервис
    --
    function f_send (p_request in XMLtype, p_bypass_request boolean default false) return XMLtype;

    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------

    --
    -- Получение данных по решению (от ЦА)
    --
    procedure request_resolution (p_res_code in resolutions.res_code%type,
                                  p_res_date in resolutions.res_date%type,
                                  p_err_text out varchar2);

    --
    -- Создать запрос по получателю / обновить по нему данные (в зависимости, есть ли по нему req_id)
    --
    procedure create_receiver_request (p_exp_id   in  receivers.exp_id%type,
                                       p_new_receiver in boolean,
                                       p_err_text out varchar2);

    --
    -- Создать запрос на передачу приложенного файла
    --
    procedure create_attachfile_request (p_doc_id       in documents.doc_id%type,
                                         p_err_text out varchar2);

    --
    -- Создать запрос на удаление приложенного файла
    --
    procedure create_deletefile_request (p_doc_id       in documents.doc_id%type,
                                         p_err_text out varchar2);

    --
    -- Создать запрос на печать заявления получателя
    --
    procedure create_printbill_request  (p_rec_id   in  documents.rec_id%type,
                                         p_name     in varchar2,
                                         p_err_text out varchar2);
                                         
    --
    -- Создать запрос на печать расчета сум реструктуризированной задолженности
    --
    procedure create_CalcRequest_request (p_request_id out calc_request.request_id%type,
                                          p_date_from  in date,
                                          p_err_text   out varchar2);

    --
    -- Создать запрос на передачу скана расчета суммы комиссии (=реструктуризированной задолженности)
    --
    procedure create_sendCalcRequest_request (p_request_id  in  calc_request.request_id%type,
                                              p_err_text    out varchar2);

    --
    -- Создать запрос на подтверждение запроса на выплату
    --
    procedure create_confirmation_request (p_exp_id       in receivers.exp_id%type,
                                           p_err_text     out varchar2);

    --
    -- Создать запрос на подтверждение запросов на выплату ("витяг")
    --
    procedure create_CRL_request (p_err_text    out varchar2);

    --
    -- Создать запрос на добавление комментария
    --
    procedure create_comment_request (p_request_id   in receivers.req_id%type,
                                      p_comment      in varchar2,
                                      p_err_text    out varchar2);

    --
    -- Создать запрос на обновление истории комментариев
    --
    procedure create_comment_history_request (p_request_id   in receivers.req_id%type,
                                              p_err_text    out varchar2);

    --
    -- Создать запрос на получение векселей по своему региону
    --
    procedure create_get_bills_request (p_err_text out varchar2);
    --
    -- Создать запрос на получение векселей по своему региону (внутри банка)
    --
    procedure create_get_bills_local_request (p_err_text out varchar2);
    --
    -- Создать запрос на получение статусов по своему региону
    --
    procedure create_getReqStatuses_request (p_force in number, p_err_text out varchar2);
    --
    -- Создать запрос на отзыв запроса получателя
    --
    procedure create_RevokeRequest_request (p_exp_id    in ca_receivers.exp_id%type, 
                                            p_err_text out varchar2);
    --
    -- Создать запрос на уведомление ДКСУ о выдаче векселей
    --
    procedure create_SetBillsHanded_request (p_exp_id    in receivers.exp_id%type, 
                                             p_err_text out varchar2);

    --
    -- Создать запрос на отказ от работы с получателем
    --
    procedure create_ClearRequest_request (p_exp_id       in receivers.exp_id%type,
                                           p_err_text     out varchar2);
    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------
    --
    -- Передача запроса в Казначейство; получение ответа, возврат ответа
    --
    procedure bypass_request (p_request_id in varchar2);

    --
    -- Обработать РУшный запрос на стороне ЦА
    --
    procedure process_request (p_request  in XMLtype, 
                               p_response in XMLtype, 
                               p_method   in varchar2 default null);

    --
    -- Обновление статусов ДКСУ для ca_receivers / receivers
    --
    procedure store_req_statuses (p_xml in XMLtype, p_local in boolean);

    --
    -- Сохранение (обновление / вставка) векселей из XML
    --
    procedure store_bills (p_xml in XMLtype, p_status in rec_bills.status%type);

    --
    -- Сохранить получателей с РУ в базу ЦА
    --
    procedure store_ca_receivers (p_xml     in XMLtype, 
                                  p_exp_id  in ca_receivers.exp_id%type, 
                                  p_req_id  in ca_receivers.req_id%type);

    --
    -- Разбор ответа с получателями и сохранение в БД
    --
    procedure store_expected_receivers (p_xml XMLtype, p_errorText out varchar2);

    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------
    --
    -- Получение xml для подтверждения данных по запросу - SetReqReqRec
    --
    function generate_ClearRequest_xml (p_exp_id in ca_receivers.exp_id%type)
    return XMLtype;
    --
    -- Получение xml для уведомления ДКСУ о выдаче векселей - SetBillsHanded
    --
    function generate_SetBillsHanded_xml (p_exp_id in receivers.exp_id%type)
    return XMLtype;
    --
    -- Получение xml для отзыва запроса с ДКСУ - RevokeRequest
    --
    function generate_getRevokeRequest_xml (p_exp_id in ca_receivers.exp_id%type)
    return XMLtype;
    --
    -- Получение xml со списком статусов получателей по региону (локально)
    --
    function generate_respReqStatuses_xml (p_kf in varchar2)
    return XMLtype;
    --
    -- Получение xml для запроса статусов с ЦА на ДКСУ - GetReqStatuses
    --
    function generate_getReqStatuses_xml (p_force in number)
    return XMLtype;
    --
    -- Получение xml со списком векселей по региону (локально)
    --
    function generate_resp_bills_local_xml (p_kf in varchar2)
    return XMLtype;
    --
    -- Получение xml для запроса векселей с ЦА на РУ - GetBillsLocal
    --
    function generate_get_bills_local_xml
    return XMLtype;
    --
    -- Получение xml для запроса векселей - GetBills
    --
    function generate_get_bills_xml
    return XMLtype;
    --
    -- Получение xml для подтверждения данных по запросам / формирование "витяга" - ConfirmRequestList
    --
    function generate_comment_history_xml (p_request_id in receivers.req_id%type)
    return XMLtype;
    --
    -- Получение xml для подтверждения данных по запросам / формирование "витяга" - ConfirmRequestList
    --
    function generate_comment_xml (p_request_id in receivers.req_id%type,
                                   p_comment    in varchar2)
    return XMLtype;
    --
    -- Получение xml для подтверждения данных по запросам / формирование "витяга" - ConfirmRequestList
    --
    function generate_CRL_xml
    return XMLtype;
    --
    -- Получение xml для подтверждения данных по запросу - SetReqReqRec
    --
    function generate_confirmation_xml (p_rec_id in receivers.exp_id%type)
    return XMLtype;

    --
    -- Получение xml для запроса на печать - PrintBillRequest
    --
    function generate_print_bill_xml (p_rec_id in receivers.exp_id%type)
    return XMLtype;

    --
    -- Получение xml для запроса на печать - AmountOfRestructuredDebt - CalcRequest
    --
    function generate_CalcRequest_xml (p_date_from in date)
    return XMLtype;

    --
    -- Получение xml по скану расчета суммы реструктуризированной задолженности для отправки - AddCommissionCalculate
    --
    function generate_sendCalcRequest_xml (p_request_id in calc_request.request_id%type)
    return XMLtype;

    --
    -- Получение xml по приложенному файлу для отправки - AttachFile
    --
    function generate_attach_file_xml (p_doc_id in documents.doc_id%type)
    return XMLtype;

    --
    -- Получение xml по удалению приложенного файла - DeleteFile
    --
    function generate_delete_file_xml (p_doc_id   in documents.doc_id%type)
    return XMLtype;

    --
    -- Получение xml по решению для отправки; метод - SearchResolution
    --
    function generate_resolution_xml (p_res_code in resolutions.res_code%type,
                                      p_res_date in resolutions.res_date%type) return clob;

    --
    -- Получение xml по получателю векселя; метод - CreateResolutionRequest
    --
    function generate_receiver_xml (p_exp_id in number, p_method in varchar2)
    return XMLtype;

    --
    -- Генерация xml ответа-ошибки
    --
    function generate_errorResp_xml (p_message in varchar2)
    return XMLtype;

    --
    -- Генерация xml header для вебсервиса Казначейства; header требует обертки в xmlns soapenv и bil
    --
    function generate_header_xml (p_method in varchar2, 
                                  p_action in varchar2 default 'BillsServices',
                                  p_signer in varchar2 default null,
                                  p_sign   in clob default null)
    return XMLtype;

end;
/
create or replace package body BILL_SERVICE_MGR
is
    g_body_version      constant varchar2(64) := 'Version 1.7.0 23/10/2018';
    G_TRACE             constant varchar2(20) := 'bill_service_mgr.';
    G_TREASURY_USER              varchar2(64);
    G_TARGET_MFO        constant number       := 300465;
    g_bills_url         constant varchar2(64) := 'http://billstrans.org/';
    g_billsservice_url  constant varchar2(64) := 'http://billsservice.org/';
    g_soap_url          constant varchar2(64) := 'http://schemas.xmlsoap.org/soap/envelope/';
    g_billsserv_nmsps   constant varchar2(64) := 'xmlns="'||g_billsservice_url||'"';
    g_out_nmsps         constant varchar2(128):= 'xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/ xmlns:bil="http://billstrans.org/"';
    g_bill_service_url           varchar2(64);

    --
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2 is
    begin
        return 'Package header '||G_TRACE|| g_header_version;
    end header_version;

    --
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2 is
    begin
        return 'Package body '||G_TRACE|| g_body_version;
    end body_version;

    --
    -- Обертка для получения текущего МФО (из контекста или глобального)
    --
    function f_ourmfo return varchar2
        is
    begin
        return bars.f_ourmfo;
    exception
        when others then
            if sqlcode = -20000 then
                return bars.f_ourmfo_g;
            end if;
    end f_ourmfo;

    --
    -- Обертка для получения текущего имени пользователя
    --
    function f_username return varchar2
        is
    begin
        return bars.user_name;
    end f_username;

    --
    -- Обертка для получения текущего отделения пользователя
    --
    function f_user_branch return varchar2
        is
    begin
        return sys_context('BARS_CONTEXT', 'USER_BRANCH');
    end f_user_branch;

    --
    -- Получение ошибки из логов барстранса
    --
    function f_get_transp_error (p_main_sess in varchar2) return XMLtype
        is
    l_req_result XMLtype;
    begin
        select generate_errorResp_xml(substr(c.big_message, 1, 2000))
        into l_req_result
        from barstrans.output_log c
        where req_id = p_main_sess
        and c.State = 'ERROR'
        and rownum = 1;
        return l_req_result;
    end f_get_transp_error;

    --
    -- Отправка запроса на вебсервис
    --
    function f_send (p_request in XMLtype, p_bypass_request boolean default false) return XMLtype
        is
    l_main_sess varchar2(250);
    params barstrans.transp_utl.t_add_params;
    l_response clob;
    begin
        -- отправка на головной офис (синхронно)
        barstrans.transp_utl.send(p_body       => p_request.getClobVal,
                                  p_add_params => params,
                                  p_send_type  => case when p_bypass_request then 'BILLS_SERVICE' else 'BILLS_REQUEST' end,
                                  p_send_kf    => case when p_bypass_request then 1 else G_TARGET_MFO end,
                                  p_main_sess  => l_main_sess);
        -- получение ответа
        select c_date into l_response from BARSTRANS.OUT_REQS t where t.main_id = l_main_sess;
        if l_response is not null then
            return XMLtype(l_response);
        else
            return f_get_transp_error(l_main_sess);
        end if;
    exception
        when no_data_found then
            return f_get_transp_error(l_main_sess);
        when others then
            if sqlcode = -6502 then
                raise_application_error(-20000, 'Сервіс не повернув даних (або дані некоректної структури)');
            else raise;
            end if;
    end f_send;

    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------

    --
    -- Получение данных по решению (от ЦА)
    --
    procedure request_resolution (p_res_code in resolutions.res_code%type,
                                  p_res_date in resolutions.res_date%type,
                                  p_err_text out varchar2)
    is
    l_request XMLtype;
    l_response XMLtype;
    begin
        -- генерация XML по решению
        l_request := XMLtype(generate_resolution_xml(p_res_code, p_res_date));
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- сохранение списка получателей / обработка ответа
        store_expected_receivers (l_response, p_err_text);
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end request_resolution;

    --
    -- Создать запрос по получателю / обновить по нему данные (в зависимости, есть ли по нему req_id)
    --
    procedure create_receiver_request (p_exp_id       in  receivers.exp_id%type,
                                       p_new_receiver in boolean,
                                       p_err_text     out varchar2)
        is
    l_method varchar2(128);
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    l_req_id number;
    begin
        -- проверка подписи
        signer.validate_signature(p_exp_id);
        if p_new_receiver then l_method := 'CreateResolutionRequest'; else l_method := 'UpdateBillRequest'; end if;
        -- генерация XML по решению
        l_request := generate_receiver_xml(p_exp_id, l_method);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- сохранение списка получателей / обработка ответа
        -- Разбираем ответ на статус и тело решения
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               to_number(r.x.extract('//data/text()', g_billsserv_nmsps)),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, l_req_id, p_err_text
        from response r;

        if l_response_status = 'OK' then
            update receivers
            set req_id = nvl(l_req_id, req_id),
                status = 'RQ'
            where exp_id = p_exp_id;
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_receiver_request;

    --
    -- Создать запрос на передачу приложенного файла
    --
    procedure create_attachfile_request (p_doc_id    in documents.doc_id%type,
                                         p_err_text out varchar2)
        is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    l_ext_id number;
    begin
        -- генерация XML по файлу
        l_request := generate_attach_file_xml(p_doc_id);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//data/Id/text()', g_billsserv_nmsps).getNumberVal()
        into l_response_status, p_err_text, l_ext_id
        from response r;

        update documents
        set status = case when l_response_status = 'OK' then 'OK' else 'IN' end,
            ext_id = l_ext_id
        where doc_id = p_doc_id;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_attachfile_request;

    --
    -- Создать запрос на удаление приложенного файла
    --
    procedure create_deletefile_request (p_doc_id       in documents.doc_id%type,
                                         p_err_text    out varchar2)
        is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    begin
        -- генерация XML по файлу
        l_request := generate_delete_file_xml(p_doc_id);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, p_err_text
        from response r;

        if l_response_status = 'OK' then
            delete from documents
            where doc_id = p_doc_id;
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_deletefile_request;

    --
    -- Создать запрос на печать
    --
    procedure create_printbill_request  (p_rec_id   in  documents.rec_id%type,
                                         p_name     in  varchar2,
                                         p_err_text out varchar2)
        is
    l_request XMLtype;
    l_response XMLtype;
    l_res_file clob;
    begin
        -- генерация XML по файлу
        l_request := generate_print_bill_xml(p_rec_id);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        l_res_file := l_response.extract('//clob/text()').getClobVal();
        update documents
        set doc_body = l_res_file,
            status = 'IN',
            last_dt = sysdate,
            last_user = f_username,
            filename = p_name
        where rec_id = p_rec_id
        and doc_type = 1;
        if sql%rowcount = 0 then
            insert into documents (doc_id,
                                   rec_id,
                                   doc_type,
                                   doc_body,
                                   status,
                                   last_dt,
                                   last_user,
                                   filename)
            values (s_documents.nextval, p_rec_id, 1, l_res_file, 'IN', sysdate, 1, p_name);
        end if;
    exception
        when others then
            rollback;
            if sqlcode = -30625 then
                /* Не удалось получить файл - пытаемся достать ошибку */
                p_err_text := l_response.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal();
            else 
                p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
            end if;
    end create_printbill_request;

    --
    -- Создать запрос на печать расчета сум реструктуризированной задолженности
    --
    procedure create_CalcRequest_request (p_request_id out calc_request.request_id%type,
                                          p_date_from  in date,
                                          p_err_text   out varchar2)
        is
    l_filename varchar2(256) := 'CalcRequest_'||to_char(sysdate, 'yyyymmdd')||'.pdf';
    l_request XMLtype;
    l_response XMLtype;
    l_res_file clob;
    begin
        -- генерация XML по файлу
        l_request := generate_CalcRequest_xml (p_date_from);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        l_res_file := l_response.extract('//clob/text()').getClobVal();
        update calc_request
        set request_name = l_filename,
            request_body = l_res_file,
            request_date = sysdate
        where trunc(date_from, 'MONTH') = trunc(p_date_from, 'MONTH')
        returning request_id into p_request_id;
        if sql%rowcount = 0 then
            select s_documents.nextval into p_request_id from dual;
            insert into calc_request (request_id,
                                      request_name,
                                      date_from,
                                      date_to,
                                      request_date,
                                      request_body)
            select p_request_id, l_filename, trunc(p_date_from, 'MONTH'), last_day(p_date_from), sysdate, l_res_file from dual;
        end if;
    exception
        when others then
            rollback;
            if sqlcode = -30625 then
                /* Не удалось получить файл - пытаемся достать ошибку */
                p_err_text := l_response.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal();
            else 
                p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
            end if;
    end create_CalcRequest_request;
    
    --
    -- Создать запрос на передачу скана расчета суммы комиссии (=реструктуризированной задолженности)
    --
    procedure create_sendCalcRequest_request (p_request_id  in  calc_request.request_id%type,
                                              p_err_text    out varchar2)
        is
    l_request  XMLtype;
    l_response XMLtype;
    l_status   calc_request.status%type;
    begin
        -- генерация XML по файлу
        l_request := generate_sendCalcRequest_xml(p_request_id);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal()
        into p_err_text, l_status
        from response r;

        update calc_request
        set status = l_status,
            send_date = sysdate
        where request_id = p_request_id;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_sendCalcRequest_request;

    --
    -- Создать запрос на подтверждение запроса на выплату
    --
    procedure create_confirmation_request (p_exp_id       in receivers.exp_id%type,
                                           p_err_text     out varchar2)
        is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    begin
        -- проверка подписи
        signer.validate_signature(p_exp_id);
        -- генерация XML по файлу
        l_request := generate_confirmation_xml(p_exp_id);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, p_err_text
        from response r;

        if l_response_status = 'OK' then
            update receivers
            set status = 'XX'
            where exp_id = p_exp_id;
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_confirmation_request;

    --
    -- Создать запрос на подтверждение запросов на выплату ("витяг")
    --
    procedure create_CRL_request (p_err_text    out varchar2)
    is
    v_progname bill_audit.action%type := 'ConfirmRequestList';
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    l_extract_number_id ca_receivers.extract_number_id%type;
    l_err_text varchar2(4000);
    begin
        bill_api.CheckRequestListSign(l_err_text);
        -- генерация XML по файлу
        l_request := generate_CRL_xml;
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ExtractNumberID/text()', g_billsserv_nmsps).getNumberVal()
        into l_response_status, p_err_text, l_extract_number_id
        from response r;
        p_err_text := l_err_text || p_err_text;

        if l_response_status = 'OK' then
            -- добавляем запись о выдержке
            insert into extracts (extract_number_id, extract_date) 
            values (l_extract_number_id, trunc(sysdate));
            -- обновляем получателей
            for rec in (select exp_id from ca_receivers where status = 'XX')
            loop
                -- меняем статус, т.к. данные переданы
                update ca_receivers
                set status = 'SN',
                    extract_number_id = l_extract_number_id
                where exp_id = rec.exp_id;
                -- сохраняем в список получателей на момент отправки выдержки
                insert into extracts_detail (extract_id, exp_id) values (l_extract_number_id, rec.exp_id);
                logger.log_action(p_action => v_progname,
                                  p_key    => rec.exp_id,
                                  p_params => 'extract_number_id: '||l_extract_number_id,
                                  p_result => 'Витяг відправлено');
            end loop;
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_CRL_request;

    --
    -- Создать запрос на добавление комментария
    --
    procedure create_comment_request (p_request_id   in receivers.req_id%type,
                                      p_comment      in varchar2,
                                      p_err_text    out varchar2)
    is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    l_comments_history clob;
    begin
        -- генерация XML по файлу
        l_request := generate_comment_xml(p_request_id, p_comment);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, p_err_text
        from response r;
        
        l_comments_history := l_response.extract('//history', g_billsserv_nmsps).getClobVal();
        
        if l_response_status = 'OK' then
            update receivers
            set comments = l_comments_history
            where req_id = p_request_id;
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_comment_request;

    --
    -- Создать запрос на обновление истории комментариев
    --
    procedure create_comment_history_request (p_request_id   in receivers.req_id%type,
                                              p_err_text    out varchar2)
    is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    l_comments_history clob;
    begin
        -- генерация XML по файлу
        l_request := generate_comment_history_xml(p_request_id);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, p_err_text
        from response r;
        
        l_comments_history := l_response.extract('//history', g_billsserv_nmsps).getClobVal();
        
        if l_response_status = 'OK' then
            update receivers
            set comments = l_comments_history
            where req_id = p_request_id;
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_comment_history_request;

    --
    -- Создать запрос на получение векселей по своему региону
    --
    procedure create_get_bills_request (p_err_text out varchar2)
    is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    begin
        -- генерация XML по файлу
        l_request := generate_get_bills_xml;
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, p_err_text
        from response r;
        if l_response_status = 'OK' then
            store_bills(l_response, 'SN');
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_get_bills_request;

    --
    -- Создать запрос на получение векселей по своему региону (внутри банка)
    --
    procedure create_get_bills_local_request (p_err_text out varchar2)
    is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    begin
        -- генерация XML по файлу
        l_request := generate_get_bills_local_xml;
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, p_err_text
        from response r;
        if l_response_status = 'OK' then
            store_bills(l_response, 'SR');
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_get_bills_local_request;

    --
    -- Создать запрос на получение статусов по своему региону
    --
    procedure create_getReqStatuses_request (p_force in number, p_err_text out varchar2)
    is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    begin
        -- генерация XML по файлу
        l_request := generate_getReqStatuses_xml(p_force);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, p_err_text
        from response r;
        if l_response_status = 'OK' then
            store_req_statuses(l_response, p_local => true);
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_getReqStatuses_request;

    --
    -- Создать запрос на отзыв запроса получателя
    --
    procedure create_RevokeRequest_request (p_exp_id    in ca_receivers.exp_id%type, 
                                            p_err_text out varchar2)
    is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    begin
        -- генерация XML по файлу
        l_request := generate_getRevokeRequest_xml (p_exp_id);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, p_err_text
        from response r;
        if l_response_status = 'OK' then
            update ca_receivers
            set status = 'RJ',
                ext_status = 202
            where exp_id = p_exp_id;
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_RevokeRequest_request;

    --
    -- Создать запрос на уведомление ДКСУ о выдаче векселей
    --
    procedure create_SetBillsHanded_request (p_exp_id    in receivers.exp_id%type, 
                                             p_err_text out varchar2)
    is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    begin
        -- генерация XML по файлу
        l_request := generate_SetBillsHanded_xml (p_exp_id);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, p_err_text
        from response r;
        if l_response_status = 'OK' then
            -- Обновляем статусы получателя
            update receivers
            set status = 'VH',
                ext_status = 209
            where exp_id = p_exp_id;
            -- Обновляем статусы векселей
            update rec_bills
            set status = 'OK',
                last_dt = sysdate,
                last_user = f_username,
                handout_date = bill_abs_integration.get_oper_dt
            where rec_id = p_exp_id;
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_SetBillsHanded_request;
    
    --
    -- Создать запрос на отказ от работы с получателем
    --
    procedure create_ClearRequest_request (p_exp_id       in receivers.exp_id%type,
                                           p_err_text     out varchar2)
        is
    l_request XMLtype;
    l_response XMLtype;
    l_response_status varchar2(50);
    begin
        -- генерация XML по файлу
        l_request := generate_ClearRequest_xml(p_exp_id);
        -- отправка на головной офис (синхронно)
        l_response := f_send(l_request);
        -- обработка ответа
        with response as
        (select l_response x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, p_err_text
        from response r;

        if l_response_status = 'OK' then
            delete from receivers where exp_id = p_exp_id;
        end if;
    exception
        when others then
            rollback;
            p_err_text := p_err_text || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
    end create_ClearRequest_request;
    
    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------

    --
    -- Передача запроса в Казначейство; получение ответа, возврат ответа
    --
    procedure bypass_request (p_request_id in varchar2)
        is
    l_request   XMLtype;
    l_response  XMLtype;
    l_method    varchar2(128);
    l_sender_kf varchar2(6);
    begin
        -- получаем данные запроса
        select XMLtype(d_clob) into l_request from barstrans.input_reqs where id = p_request_id;
        -- получаем метод
        select Q.R.extract('//bil:Method/text()', g_out_nmsps).getStringVal() MT,
               Q.R.extract('//bil:MFO/text()', g_out_nmsps).getStringVal() KF
        into l_method, l_sender_kf
        from (select l_request R from dual) Q;
        
        if l_method = 'GetBillsLocal' then
            -- обрабатываем у себя (локальная передача данных)
            l_response := generate_resp_bills_local_xml(l_sender_kf);
        elsif l_method = 'GetReqStatuses' and trunc(sysdate) = to_date(get_bill_param('LAST_STATUS_UPD_DATE'), 'yyyy-mm-dd') then
            -- отдадим статусы локально
            l_response := generate_respReqStatuses_xml(l_sender_kf);
        elsif l_method = 'GetReqStatusesForce' then
            select updatexml(l_request, '//bil:Method/text()', 'GetReqStatuses', g_out_nmsps) into l_request from dual;
            l_method := 'GetReqStatuses';
            -- передаем на вебсервис казначейства
            l_response := f_send(l_request, p_bypass_request => true);
            -- обработаем общие данные
            process_request(l_request, l_response, l_method);
            -- отдаем данные по конкретному региону + внутр. статусы
            l_response := generate_respReqStatuses_xml(l_sender_kf);
        else
            -- передаем на вебсервис казначейства
            l_response := f_send(l_request, p_bypass_request => true);
            process_request(l_request, l_response, l_method);
        end if;
        -- возвращаем ответ
        barstrans.transp_utl.add_resp(p_request_id, l_response.getClobVal);
    exception
        when others then
            -- возвращаем ответ с ошибкой
            barstrans.transp_utl.add_resp(p_request_id, generate_errorResp_xml('Помилка обробки даних на вузлі консолідації:'||
                                                                                chr(10)||
                                                                                dbms_utility.format_error_stack||
                                                                                dbms_utility.format_error_backtrace).getClobVal);
            raise;
    end bypass_request;

    --
    -- Обработать РУшный запрос на стороне ЦА
    --
    procedure process_request (p_request  in XMLtype, 
                               p_response in XMLtype, 
                               p_method   in varchar2 default null)
        is
    l_method            varchar2(128);
    l_response_status   varchar2(10);
    l_exp_id            ca_receivers.exp_id%type;
    l_req_id            ca_receivers.req_id%type;
    l_signer            ca_receivers.signer%type;
    l_signature         ca_receivers.signature%type;
    begin
        /*TODO: логирование*/
        if p_method is not null then
            l_method := p_method;
        else
            -- получаем метод из запроса
            select Q.R.extract('//bil:Method/text()', g_out_nmsps).getStringVal() MT
            into l_method
            from (select p_request R from dual) Q;
        end if;

        -- получаем статус и сообщение об ошибке из ответа
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status
        from (select p_response x from dual) r;
        if l_response_status = 'OK' then
            if    l_method = 'CreateResolutionRequest' then
                -- достаем REQ_ID из ответа
                select q.r.extract('//data/text()', g_billsserv_nmsps).getNumberVal() into l_req_id from (select p_response R from dual) Q;
                -- достаем EXP_ID из запроса
                select q.r.extract('//EXP_RECEIVER_ID/text()', g_out_nmsps).getNumberVal() into l_exp_id from (select p_request R from dual) Q;
                -- сохраняем данные получателя
                store_ca_receivers(p_request, l_exp_id, l_req_id);
            elsif l_method = 'UpdateBillRequest' then
                -- достаем REQ_ID из запроса
                select q.r.extract('//REQUESTID/text()', g_out_nmsps).getNumberVal() into l_req_id from (select p_request R from dual) Q;
                select exp_id into l_exp_id from ca_receivers where req_id = l_req_id;
                -- сохраняем данные получателя
                store_ca_receivers(p_request, l_exp_id, l_req_id);
            elsif l_method = 'ConfirmReceiver' then
                -- достаем EXP_ID из запроса
                select q.r.extract('//ExpId/text()', g_out_nmsps).getNumberVal(),
                       q.r.extract('//bil:KeyID/text()', g_out_nmsps).getStringVal(),
                       q.r.extract('//bil:Sign/text()', g_out_nmsps).getClobVal() 
                into l_exp_id, l_signer, l_signature 
                from (select p_request R from dual) Q;
                -- подтверждаем данные получателя
                update ca_receivers
                set status = 'XX',
                    signer = l_signer,
                    signature = l_signature,
                    sign_date = systimestamp
                where exp_id = l_exp_id;
            elsif l_method = 'GetReqStatuses' then
                -- сохраняем ca_receivers + обновляем дату
                store_req_statuses(p_xml => p_response, p_local => false);
                update bill_params
                set val = to_char(sysdate, 'yyyy-mm-dd')
                where par = 'LAST_STATUS_UPD_DATE';
            elsif l_method = 'SetBillsHanded' then
                select q.r.extract('//Exp_ID/text()', g_out_nmsps).getNumberVal() into l_exp_id from (select p_request R from dual) Q;
                -- подтверждаем данные получателя
                update ca_receivers
                set status = 'VH',
                    ext_status = 209
                where exp_id = l_exp_id;
            elsif l_method = 'ClearRequest' then
                select q.r.extract('//Exp_ID/text()', g_out_nmsps).getNumberVal() into l_exp_id from (select p_request R from dual) Q;
                -- Удаляем получателя из данных ЦА
                delete from ca_receivers where exp_id = l_exp_id;
            end if;
        end if;
    end process_request;

    --
    -- Обновление статусов ДКСУ для ca_receivers / receivers
    --
    procedure store_req_statuses (p_xml in XMLtype, p_local in boolean)
        is
    begin
        if p_local then
            /* запрос внутри банка, РУ -> ЦА */
            merge into receivers c
            using
            (
                select distinct
                       extractvalue(column_value, '//@ExpID', g_billsserv_nmsps) as ExpID, 
                       extractvalue(column_value, '//State', g_billsserv_nmsps) as State, 
                       extractvalue(column_value, '//LocalState', g_billsserv_nmsps) as LocalState
                from table (
                               select xmlsequence(Q.R.extract('//List/Receiver', g_billsserv_nmsps))
                               from (select p_xml R from dual) Q
                           )
            ) Z
            on (c.exp_id = Z.ExpID)
            when matched then
                update
                set c.ext_status = to_number(Z.State),
                    c.status = case when to_number(z.State) in (202, 206, 210) or z.LocalState = 'RJ' then 'RJ'
                                    when to_number(z.State) = 204 then 'XX'
                                    else c.status
                               end;
        else
            /* запрос ЦА -> ДКСУ */
            -- обновляем статусы основной таблицы
            merge into ca_receivers c
            using
            (
                select distinct
                       extractvalue(column_value, '//@ExpID', g_billsserv_nmsps) as ExpID, 
                       extractvalue(column_value, '//State', g_billsserv_nmsps) as State 
                from table (
                               select xmlsequence(Q.R.extract('//List/Receiver', g_billsserv_nmsps))
                               from (select p_xml R from dual) Q
                           )
            ) Z
            on (c.exp_id = Z.ExpID)
            when matched then
                update
                set c.ext_status = to_number(Z.State),
                    c.status = case when to_number(z.State) in (206, 210) then 'RJ'
                                    when to_number(z.State) = 202 and c.status != '' then 'RJ'
                                    else c.status
                               end;
            -- обновляем статусы "снимка"
            merge into extracts_detail ed
            using
            (
                select distinct
                       extractvalue(column_value, '//@ExpID', g_billsserv_nmsps) as ExpID, 
                       extractvalue(column_value, '//State', g_billsserv_nmsps) as State 
                from table (
                               select xmlsequence(Q.R.extract('//List/Receiver', g_billsserv_nmsps))
                               from (select p_xml R from dual) Q
                           )
            ) Z
            on (ed.exp_id = Z.ExpID)
            when matched then
                update
                set ed.ext_status = case when nvl(ed.ext_status, -1) not in (206, 210) then to_number(Z.State) else ed.ext_status end;

        end if;
    end store_req_statuses;

    --
    -- Сохранение (обновление / вставка) векселей из XML
    --
    procedure store_bills (p_xml in XMLtype, p_status in rec_bills.status%type)
        is
    l_bill_row rec_bills%rowtype;
    begin
        for rec in (
                        select column_value as c 
                        from table(select xmlsequence(V.x.extract('//BillsList/Receiver', g_billsserv_nmsps)) from (select p_xml x from dual) V)
                   )
        loop
            l_bill_row.rec_id := rec.c.extract('//Receiver/@ExpID', g_billsserv_nmsps).getStringVal();
            dbms_output.put_line('rec:'||l_bill_row.rec_id);
            for bill in (
                            select column_value as v 
                            from table(select xmlsequence(V.x.extract('//Receiver/Bill', g_billsserv_nmsps)) from (select rec.c x from dual) V)
                        )
            loop
                l_bill_row.bill_no := bill.v.extract('//Bill/Number/text()', g_billsserv_nmsps).getStringVal();
                l_bill_row.dt_issue := to_date(bill.v.extract('//Bill/IssueDate/text()', g_billsserv_nmsps).getStringVal(), 'yyyy-mm-dd');
                l_bill_row.dt_payment := to_date(bill.v.extract('//Bill/PayDate/text()', g_billsserv_nmsps).getStringVal(), 'yyyy-mm-dd');
                l_bill_row.amount := bill.v.extract('//Bill/Amount/text()', g_billsserv_nmsps).getNumberVal() / 100;
                l_bill_row.status := p_status;
                l_bill_row.last_dt := sysdate;
                l_bill_row.last_user := f_username;
                
                begin
                    insert into rec_bills values l_bill_row;
                exception
                    when dup_val_on_index then
                        update rec_bills
                        set row = l_bill_row
                        where rec_id = l_bill_row.rec_id
                          and bill_no = l_bill_row.bill_no
                          and status = 'SN'; -- обновляем только список отправленных из ДКСУ
                end;
            end loop;
        end loop;

    end store_bills;

    --
    -- Сохранить получателей с РУ в базу ЦА
    --
    procedure store_ca_receivers (p_xml     in XMLtype, 
                                  p_exp_id  in ca_receivers.exp_id%type, 
                                  p_req_id  in ca_receivers.req_id%type)
        is
    l_receiver ca_receivers%rowtype;
    begin
        select q.r.extract('//bil:MFO/text()', g_out_nmsps).getNumberVal(),
               p_exp_id,
               q.r.extract('//RECEIVER_NAME/text()', g_out_nmsps).getStringVal(),
               q.r.extract('//RECEIVER_EDRPOU/text()', g_out_nmsps).getStringVal(),
               q.r.extract('//RECEIVER_DOCUMENT_NUMBER/text()', g_out_nmsps).getStringVal(),
               to_date(q.r.extract('//PASSPORT_WHEN/text()', g_out_nmsps).getStringVal(), 'yyyy-mm-dd'),
               q.r.extract('//PASSPORT_WHOM/text()', g_out_nmsps).getStringVal(),
               q.r.extract('//REQ_ATTRIBUTE/text()', g_out_nmsps).getStringVal(),
               q.r.extract('//SUM_COPECK/text()', g_out_nmsps).getNumberVal(),
               q.r.extract('//CURRENCY_ID/text()', g_out_nmsps).getStringVal(),
               q.r.extract('//C_ACCOUNT/text()', g_out_nmsps).getStringVal(),
               q.r.extract('//USER_BRANCH/text()', g_out_nmsps).getStringVal(),
               q.r.extract('//C_TEL/text()', g_out_nmsps).getStringVal(),
               q.r.extract('//ADDRESS/text()', g_out_nmsps).getStringVal(),
               q.r.extract('//RES_CODE/text()', g_out_nmsps).getStringVal(),
               to_date(q.r.extract('//RES_DATE/text()', g_out_nmsps).getStringVal(), 'yyyy-mm-dd'),
               q.r.extract('//COURTNAME/text()', g_out_nmsps).getStringVal(),
               q.r.extract('//RES_ID/text()', g_out_nmsps).getNumberVal(),
               'RQ',
               p_req_id
        into l_receiver.kf,
             l_receiver.exp_id,
             l_receiver.name,
             l_receiver.inn,
             l_receiver.doc_no,
             l_receiver.doc_date,
             l_receiver.doc_who,
             l_receiver.cl_type,
             l_receiver.amount,
             l_receiver.currency,
             l_receiver.account,
             l_receiver.branch,
             l_receiver.phone,
             l_receiver.address,
             l_receiver.res_code,
             l_receiver.res_date,
             l_receiver.courtname,
             l_receiver.res_id,
             l_receiver.status,
             l_receiver.req_id
        from (select p_xml R from dual) Q;

        update ca_receivers
        set row = l_receiver
        where exp_id = l_receiver.exp_id;

        if sql%rowcount = 0 then
            insert into ca_receivers values l_receiver;
        end if;

    end store_ca_receivers;

    --
    -- Разбор ответа с получателями и сохранение в БД
    --
    procedure store_expected_receivers (p_xml XMLtype, p_errorText out varchar2)
        is
        exp_res_r expected_receivers%rowtype;
        l_response_status varchar2(32);
        l_resolution_xml XMLtype;
        l_response_error_text resolutions.response%type;
        l_resolution_data resolutions%rowtype;
    begin
        if p_xml is null then
            p_errorText := 'Сервіс не повернув даних';
            return;
        end if;
        -- Разбираем ответ на статус и тело решения
        with response as
        (select p_xml x from dual)
        select r.x.extract('//Status/text()', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//Resolution', g_billsserv_nmsps),
               to_number(r.x.extract('//Resolution/@ResolutionID', g_billsserv_nmsps).getStringVal()),
               r.x.extract('//Resolution/@ResolutionNo', g_billsserv_nmsps).getStringVal(),
               to_date(r.x.extract('//Resolution/@ResolutionDate', g_billsserv_nmsps).getStringVal(), 'yyyy-mm-dd'),
               r.x.extract('//Resolution/@CourtName', g_billsserv_nmsps).getStringVal(),
               r.x.extract('//ErrMessage/text()', g_billsserv_nmsps).getStringVal()
        into l_response_status, l_resolution_xml, l_resolution_data.res_id, l_resolution_data.res_code, l_resolution_data.res_date, l_resolution_data.courtname, l_response_error_text
        from response r;

        -- Обновляем данные по решению
        update resolutions
        set res_id = l_resolution_data.res_id,
            courtname = l_resolution_data.courtname,
            status = substr(l_response_status, 1, 2),
            response = l_response_error_text
        where res_code = l_resolution_data.res_code
        and res_date = l_resolution_data.res_date;

        bill_audit_mgr.log_action(p_action => 'SearchResolutionResult',
                                  p_key    => l_resolution_data.res_id,
                                  p_params => 'res_code = '||l_resolution_data.res_code||', res_date = '||to_char(l_resolution_data.res_date, 'yyyy-mm-dd'),
                                  p_result => 'WebService - Ok! '||p_errorText);

        -- Отдаем текст ошибки (если есть)
        p_errorText := l_response_error_text;
        /*
        TODO: owner="oleksandr.lypskykh" category="Refactoring" priority="3 - Low" created="05.07.2018"
        text="переписать exp_receivers на разбор XML в SQL"
        */
        if l_response_status = 'OK' then
            -- удаляем существующих получателей
            delete from expected_receivers where resolution_id = l_resolution_data.res_id;
            -- разбираем данные получателей из ответа
            for receiver in
            (
                with response as
                (
                    select extract(value(RSL), 'ROW', g_billsserv_nmsps) as v
                    from table(xmlsequence(l_resolution_xml.extract('Resolution/ROW', g_billsserv_nmsps))) Rsl
                )
                select v from response r
            )
            loop
                exp_res_r.exp_id            := case when receiver.v.extract('//ROW/RECEIVERID/node()', g_billsserv_nmsps) is not null
                                                    then receiver.v.extract('//ROW/RECEIVERID/node()', g_billsserv_nmsps).getStringVal() end;
                exp_res_r.resolution_id     := l_resolution_data.res_id;
                exp_res_r.receiver_name     := case when receiver.v.extract('//ROW/RECEIVER_NAME/node()', g_billsserv_nmsps) is not null
                                                    then receiver.v.extract('//ROW/RECEIVER_NAME/node()', g_billsserv_nmsps).getStringVal() end;
                exp_res_r.receiver_code     := case when receiver.v.extract('//ROW/FACT_INN/node()', g_billsserv_nmsps) is not null
                                                    then receiver.v.extract('//ROW/FACT_INN/node()', g_billsserv_nmsps).getStringVal() end;
                exp_res_r.receiver_doc_no   := case when receiver.v.extract('//ROW/FACT_DOCNO/node()', g_billsserv_nmsps) is not null
                                                    then receiver.v.extract('//ROW/FACT_DOCNO/node()', g_billsserv_nmsps).getStringVal() end;
                exp_res_r.currency_id       := case when receiver.v.extract('//ROW/CUR_CODE/node()', g_billsserv_nmsps) is not null
                                                    then receiver.v.extract('//ROW/CUR_CODE/node()', g_billsserv_nmsps).getStringVal() end;
                exp_res_r.amount            := case when receiver.v.extract('//ROW/AMOUNT/node()', g_billsserv_nmsps) is not null
                                                    then receiver.v.extract('//ROW/AMOUNT/node()', g_billsserv_nmsps).getStringVal() end;
                -- загружаем получателей из ответа
                insert into expected_receivers (exp_id, resolution_id, receiver_name, receiver_code, receiver_doc_no, currency_id, amount, state)
                values (exp_res_r.exp_id,
                        exp_res_r.resolution_id,
                        exp_res_r.receiver_name,
                        exp_res_r.receiver_code,
                        exp_res_r.receiver_doc_no,
                        exp_res_r.currency_id,
                        exp_res_r.amount,
                        'IN');
            end loop;
        end if;

    end store_expected_receivers;
    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------
    --
    -- Получение xml для отказа от работы с получателем - ClearRequest
    --
    function generate_ClearRequest_xml (p_exp_id in ca_receivers.exp_id%type)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('ClearRequest', p_signer => r.signer, p_sign => r.signature),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                               xmlelement("RequestId", r.req_id),
                                               xmlelement("ExpId", r.exp_id)
                                          )
                            )
        ) as B
        into l_req_result
        from ca_receivers r
        where exp_id = p_exp_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Не знайдено отримувача з кодом '||p_exp_id);
    end generate_ClearRequest_xml;

    --
    -- Получение xml для уведомления ДКСУ о выдаче векселей - SetBillsHanded
    --
    function generate_SetBillsHanded_xml (p_exp_id in receivers.exp_id%type)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('SetBillsHanded'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                            xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                            xmlelement("Exp_ID", c.exp_id),
                                            xmlelement("RequestId", c.req_id)
                                      ) 
                          )
        ) as B
        into l_req_result
        from receivers c
        where c.exp_id = p_exp_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Отримувача з кодом ['||p_exp_id||'] не знайдено');
    end generate_SetBillsHanded_xml;
    
    --
    -- Получение xml для отзыва запроса с ДКСУ - RevokeRequest
    --
    function generate_getRevokeRequest_xml (p_exp_id in ca_receivers.exp_id%type)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('RevokeRequest'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                            xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                            xmlelement("Exp_ID", c.exp_id)
                                      ) 
                          )
        ) as B
        into l_req_result
        from ca_receivers c
        where c.exp_id = p_exp_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Отримувача з кодом ['||p_exp_id||'] не знайдено');
    end generate_getRevokeRequest_xml;
    
    --
    -- Получение xml со списком статусов получателей по региону (локально)
    --
    function generate_respReqStatuses_xml (p_kf in varchar2)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select 
            xmlelement("Response", xmlattributes(g_billsservice_url as "xmlns"),
                xmlelement("Status", 'OK'),
                xmlelement("List",
                                xmlagg(
                                        xmlelement("Receiver", xmlattributes(exp_id as "ExpID"), 
                                                       xmlelement("State", c.ext_status),
                                                       xmlelement("LocalState", c.status)
                                                  )
                                      )
                          )
                      )
        into l_req_result
        from ca_receivers c
        where kf = p_kf
        and c.ext_status is not null;
        return l_req_result;
    end generate_respReqStatuses_xml;
    
    --
    -- Получение xml для запроса статусов с ЦА на ДКСУ - GetReqStatuses
    --
    function generate_getReqStatuses_xml (p_force in number)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml(case when p_force = 1 then 'GetReqStatusesForce' else 'GetReqStatuses' end),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"))
        ) as B
        into l_req_result
        from dual;
        return l_req_result;
    end generate_getReqStatuses_xml;
    
    --
    -- Получение xml со списком векселей по региону (локально)
    --
    function generate_resp_bills_local_xml (p_kf in varchar2)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select 
            xmlelement("BillsList", xmlattributes(g_billsservice_url as "xmlns"),
                            xmlagg(
                                    xmlelement("Receiver", xmlattributes(rec_id as "ExpID"), 
                                                    xmlagg(xmlelement("Bill",
                                                                        xmlelement("Number", b.bill_no),
                                                                        xmlelement("IssueDate", b.dt_issue),
                                                                        xmlelement("PayDate", b.dt_payment),
                                                                        xmlelement("Amount", b.amount*100)
                                                                      )
                                                          )
                                              )
                                  )
                      )
        into l_req_result
        from ca_receivers c
        join rec_bills b on c.exp_id = b.rec_id
        where b.status = 'SR'
        and kf = p_kf
        group by rec_id;
        return l_req_result;
    end generate_resp_bills_local_xml;
    
    --
    -- Получение xml для запроса векселей с ЦА на РУ - GetBillsLocal
    --
    function generate_get_bills_local_xml
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('GetBillsLocal'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"))
        ) as B
        into l_req_result
        from dual;
        return l_req_result;
    end generate_get_bills_local_xml;
    
    --
    -- Получение xml для запроса векселей - GetBills
    --
    function generate_get_bills_xml
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('GetBills'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"))
        ) as B
        into l_req_result
        from dual;
        return l_req_result;
    end generate_get_bills_xml;

    --
    -- Получение xml для подтверждения данных по запросам / формирование "витяга" - ConfirmRequestList
    --
    function generate_comment_history_xml (p_request_id in receivers.req_id%type)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('GetComment'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                               xmlelement("RequestID", r.req_id)
                                          )
                            )
        ) as B
        into l_req_result
        from receivers r
        where req_id = p_request_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Не знайдено отримувача за номером запиту '||p_request_id);
    end generate_comment_history_xml;

    --
    -- Получение xml для подтверждения данных по запросам / формирование "витяга" - ConfirmRequestList
    --
    function generate_comment_xml (p_request_id in receivers.req_id%type,
                                   p_comment    in varchar2)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('CommentRequest'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                               xmlelement("RequestID", r.req_id),
                                               xmlelement("Comment", 
                                                            xmlelement("date", to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss')),
                                                            xmlelement("author", f_username),
                                                            xmlelement("text", p_comment)
                                                          )
                                          )
                            )
        ) as B
        into l_req_result
        from receivers r
        where req_id = p_request_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Не знайдено отримувача за номером запиту '||p_request_id);
    end generate_comment_xml;

    --
    -- Получение xml для подтверждения данных по запросам / формирование "витяга" - ConfirmRequestList
    --
    function generate_CRL_xml 
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('ConfirmRequestList'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                            xmlagg(xmlelement("ROW",
                                                                xmlelement("RequestId", r.req_id)
                                                              )
                                                  )
                                          )
                          )
        ) as B
        into l_req_result
        from ca_receivers r
        where r.status = 'XX';
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Не знайдено отримувачів зі списку');
    end generate_CRL_xml;
    
    --
    -- Получение xml для подтверждения данных по запросу - SetReqReqRec
    --
    function generate_confirmation_xml (p_rec_id in receivers.exp_id%type)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('ConfirmReceiver', p_signer => r.signer, p_sign => r.signature),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                               xmlelement("RequestId", r.req_id),
                                               xmlelement("ExpId", r.exp_id)
                                          )
                            )
        ) as B
        into l_req_result
        from receivers r
        where exp_id = p_rec_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Не знайдено отримувача з кодом '||p_rec_id);
    end generate_confirmation_xml;

    --
    -- Получение xml для запроса на печать - PrintBillRequest
    --
    function generate_print_bill_xml (p_rec_id in receivers.exp_id%type)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml(p_method => 'ReturnResolution', p_action => 'PrintBillsServiceGetFile'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("PrintBillsServiceGetFile", xmlattributes(g_billsservice_url as "xmlns"),
                                               xmlelement("model",
                                                    xmlelement("name", 'NewBills'),
                                                    xmlelement("requestId", req_id),
                                                    xmlelement("fileFormat", 'PDF'),
                                                    xmlelement("date", to_char(sysdate, 'yyyy-mm-dd'))
                                               )
                                          )
                            )
        ) as B
        into l_req_result
        from receivers
        where exp_id = p_rec_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Для отримувача з кодом '||p_rec_id||' не знайдено номера запиту на виплату');
    end generate_print_bill_xml;

    --
    -- Получение xml для запроса на печать - AmountOfRestructuredDebt - CalcRequest
    --
    function generate_CalcRequest_xml (p_date_from in date)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml(p_method => 'ReturnResolution', p_action => 'AmountOfRestructuredDebtGetFile'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("AmountOfRestructuredDebtGetFile", xmlattributes(g_billsservice_url as "xmlns"),
                                               xmlelement("model",
                                                    xmlelement("date", to_char(p_date_from, 'yyyy-mm-dd'))
                                               )
                                          )
                            )
        ) as B
        into l_req_result
        from dual;
        return l_req_result;
    end generate_CalcRequest_xml;

    --
    -- Получение xml по скану расчета суммы реструктуризированной задолженности для отправки - AddCommissionCalculate
    --
    function generate_sendCalcRequest_xml (p_request_id in calc_request.request_id%type)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('AddCommissionCalculate'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                               xmlelement("Description", d.scan_name),
                                               xmlelement("FileBody", d.scan_body),
                                               xmlelement("DateFrom", to_char(d.date_from, 'yyyy-MON-dd')),
                                               xmlelement("DateTo", to_char(d.date_to, 'yyyy-MON-dd'))
                                          )
                            )
        ) as B
        into l_req_result
        from calc_request d
        where d.request_id = p_request_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Скан по розрахунку з кодом '||p_request_id||' не знайдено в базі');
    end generate_sendCalcRequest_xml;

    --
    -- Получение xml по приложенному файлу для отправки - AttachFile
    --
    function generate_attach_file_xml (p_doc_id in documents.doc_id%type)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('AttachFile'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                               xmlelement("requestId", r.req_id),
                                               xmlelement("file_name", d.filename),
                                               xmlelement("buffer", d.doc_body),
                                               xmlelement("requestbuffer", '') --stub?
                                          )
                            )
        ) as B
        into l_req_result
        from documents d
        join dict_doc_types t on d.doc_type = t.id
        join receivers r on d.rec_id = r.exp_id
        where d.doc_id = p_doc_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Документ з кодом '||p_doc_id||' не знайдено в базі регіону');
    end generate_attach_file_xml;

    --
    -- Получение xml по удалению приложенного файла - DeleteFile
    --
    function generate_delete_file_xml (p_doc_id   in documents.doc_id%type)
    return XMLtype
        is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml('DeleteFile'),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                               xmlelement("id", d.ext_id),
                                               xmlelement("buffer", '') -- stub?
                                          )
                            )
        ) as B
        into l_req_result
        from documents d
        where d.doc_id = p_doc_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Документ з кодом '||p_doc_id||' не знайдено в базі регіону');
    end generate_delete_file_xml;
------------------------------- DO NOT CHANGE THIS BLOCK --------------------------------------------------------------------
    --
    -- Получение xml по решению для отправки; метод - SearchResolution
    --
    function generate_resolution_xml (p_res_code in resolutions.res_code%type,
                                      p_res_date in resolutions.res_date%type)
    return clob
        is
    l_req_result XMLtype;
    l_result clob;
    begin
        begin
            select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                    generate_header_xml('SearchResolution'),
                    xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                    xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                                   xmlelement("Date", r.res_date),
                                                   xmlelement("Code", r.res_code)
                                              )
                                )
            ) as B
            into l_req_result
            from resolutions r
            where r.res_code = p_res_code
            and r.res_date = p_res_date;
        exception
            when no_data_found then
                raise_application_error(-20000, 'Рішення з кодом '||p_res_code||' та датою '||to_char(p_res_date, 'dd.mm.yyyy') || ' не знайдено в базі регіону');
        end;
        l_result := l_req_result.getClobVal;

        return l_result;
    end generate_resolution_xml;
-----------------------------------------------------------------------------------------------------------------
    --
    -- Получение xml по получателю векселя; метод - CreateResolutionRequest
    --
    function generate_receiver_xml (p_exp_id in number, p_method in varchar2)
    return XMLtype
    is
    l_req_result XMLtype;
    begin
        select  xmlelement("soapenv:Envelope", xmlattributes(g_soap_url as "xmlns:soapenv", g_bills_url as "xmlns:bil"),
                generate_header_xml(p_method),
                xmlelement("soapenv:Body", xmlattributes(g_soap_url as "xmlns:soapenv"),
                                xmlelement("bil:BillsServices", xmlattributes(g_billsservice_url as "xmlns:bil"),
                                               case when p_method = 'CreateResolutionRequest' then xmlelement("EXP_RECEIVER_ID", r.exp_id)
                                                    when p_method = 'UpdateBillRequest' then xmlelement("REQUESTID", r.req_id) end,
                                               xmlelement("RECEIVER_NAME", r.name),
                                               xmlelement("RECEIVER_EDRPOU", r.inn),
                                               xmlelement("RECEIVER_DOCUMENT_NUMBER", r.doc_no),
                                               xmlelement("PASSPORT_WHEN", r.doc_date),
                                               xmlelement("PASSPORT_WHOM", r.doc_who),
                                               xmlelement("REQ_ATTRIBUTE", r.cl_type),
                                               xmlelement("SUM_COPECK", r.amount*100),
                                               xmlelement("CURRENCY_ID", r.currency),
                                               xmlelement("C_ACCOUNT", r.account),
                                               xmlelement("USER_BRANCH", BSM.f_ourmfo),
                                               xmlelement("USER_ADRESS", ''),
                                               xmlelement("USER_PHONE", ''),
                                               xmlelement("USER_OKPO", ''),
                                               xmlelement("C_TEL", r.phone),
                                               xmlelement("ADDRESS", r.address),
                                               xmlelement("RES_CODE", res.res_code),
                                               xmlelement("RES_DATE", to_char(res.res_date, 'yyyy-mm-dd')),
                                               xmlelement("COURTNAME", res.courtname),
                                               xmlelement("RES_ID", res.res_id)
                                          )
                            )
        ) as B
        into l_req_result
        from receivers r
        join resolutions res on r.resolution_id = res.res_id
        where r.exp_id = p_exp_id;
        return l_req_result;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Отримувача з кодом '||p_exp_id|| ' не знайдено в базі регіону');
    end generate_receiver_xml;

    --
    -- Генерация xml ответа-ошибки
    --
    function generate_errorResp_xml (p_message in varchar2)
    return XMLtype
        is
    l_result XMLtype;
    begin
        select 
            xmlelement("Response", xmlattributes(g_billsservice_url as "xmlns"),
                xmlelement("Status", 'Error'),
                xmlelement("ErrMessage", p_message)
                      )
        into l_result
        from dual;
        return l_result;
    end generate_errorResp_xml;

    --
    -- Генерация xml header для вебсервиса Казначейства; header требует обертки в xmlns soapenv и bil
    --
    function generate_header_xml (p_method in varchar2, 
                                  p_action in varchar2 default 'BillsServices',
                                  p_signer in varchar2 default null,
                                  p_sign   in clob default null)
    return XMLtype
        is
    l_result XMLtype;
    begin
        select
        xmlelement("soapenv:Header",
                    xmlelement("bil:BillHeader",
                        xmlelement("bil:Method", p_method),
                        xmlelement("bil:User", g_treasury_user), 
                        xmlelement("bil:Token", '111'),
                        xmlelement("bil:MFO", f_ourmfo),
                        xmlelement("bil:KeyID", nvl(p_signer, 'BILLS')),
                        xmlelement("bil:Sign", p_sign),
                        xmlelement("bil:Url", g_bill_service_url),
                        xmlelement("bil:SOAPAction", p_action)
                    )
                )
        into l_result
        from dual;
        return l_result;
    end generate_header_xml;

    --
    -- Инициализация пакета
    --
    procedure init
        is
    begin
        g_bill_service_url := get_bill_param('BILL_SERVICE_URL');
        g_treasury_user := get_bill_param('TREASURY_USER');
        if g_bill_service_url is null or g_treasury_user is null then
            raise_application_error(-20000, 'Не заполнены основные параметры (bill_params)');
        end if;
        -- wallet params
        g_wallet_path := get_bill_param('WALLET_PATH');
        g_wallet_pwd := get_bill_param('WALLET_PWD');
        if g_wallet_pwd is null or g_wallet_path is null then
            raise_application_error(-20000, 'Не заполнены параметры WALLET (bill_params WALLET_PATH, WALLET_PWD)');
        end if;
    end;

begin
    init;
end;
/
 show err;
 
PROMPT *** Create  grants  BILL_SERVICE_MGR ***
grant EXECUTE                                                                on BILL_SERVICE_MGR to BARSTRANS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/package/bill_service_mgr.sql =========*** E
 PROMPT ===================================================================================== 
 