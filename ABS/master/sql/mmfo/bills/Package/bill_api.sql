
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/package/bill_api.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BILLS.BILL_API is

    -- Author  : VOLODYMYR.POHODA
    -- Created : 17-Apr-18 21:46:47
    -- Purpose : Робота з векселями ДКСУ

    g_header_version  constant varchar2(64)  := 'version 1.4.0 28/09/2018';

    --
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2;

    --
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2;

    --
    -- Поиск судебного решения
    --
    Procedure SearchResolution (p_code in resolutions.res_code%type,
                                p_date in date,
                                p_err_text out varchar2);

    --
    -- Взять "очікуваного стягувача" в работу
    --
    procedure Move2Work (p_exp_id   in number
                        ,p_err_text out varchar2);

    --
    -- Обновить данные по получателю (локально)
    --
    procedure UpdateReceiver (p_exp_id       in number
                             ,p_name         in varchar2
                             ,p_inn          in varchar2
                             ,p_docno        in varchar2
                             ,p_docdate      in date
                             ,p_docwho       in varchar2
                             ,p_cltype       in number
                             ,p_phone        in varchar2
                             ,p_address      in varchar2
                             ,p_account      in varchar2
                             ,p_rnk          in number
                             ,p_err_text      out varchar2);

    --
    -- Удалить получателя, данные о котором еще не отправлялись в ДКСУ
    --
    procedure DeleteReceiver (p_exp_id in receivers.exp_id%type, p_err_text out varchar2);

    --
    -- Отправить созданные / измененные данные по получателю в Казначейство
    --
    procedure CreateRequest (p_exp_id       in number
                            ,p_action       in varchar2
                            ,p_err_text      out varchar2);

    --
    -- Прикрепить документ к получателю (?)
    --
    procedure AddDocument (p_doc_id   in out documents.doc_id%type,
                           p_rec_id   in     documents.rec_id%type,
                           p_doc_type in     documents.doc_type%type,
                           p_doc_body in     documents.doc_body%type default null,
                           p_filename in     documents.filename%type,
                           p_descript in     documents.descript%type default null,
                           p_err_text  out    varchar2);

    --
    -- Сохранить заявление (от ДКСУ) для печати
    --
    procedure GetApplication (p_id      in number
                             ,p_err_text out varchar2);

    --
    -- Сохранить расчет сум реструктуризированной задолженности (от ДКСУ) для печати
    --
    procedure GetCalcRequest (p_request_id out number,
                              p_date_from  in calc_request.date_from%type,
                              p_err_text   out varchar2);

    --
    -- Прикрепить скан расчета сум реструктуризированной задолженности
    --
    procedure AddCalcRequestScan (p_request_id   in calc_request.request_id%type,
                                  p_scan_name    in calc_request.scan_name%type,
                                  p_scan_body    in calc_request.scan_body%type,
                                  p_err_text     out varchar2);

    --
    -- Отправить скан расчета сум реструктуризированной задолженности в ДКСУ
    --
    procedure SendCalcRequest (p_request_id   in calc_request.request_id%type,
                               p_err_text     out varchar2);

    --
    -- Получить сохраненный документ
    --
    function GetPrintDoc (p_doc_id   in documents.doc_id%type)
    return clob;

    --
    -- Отправить документ в ДКСУ
    --
    procedure SendDocument (p_rec_id   in documents.rec_id%type,
                            p_doc_id   in documents.doc_id%type default null,
                            p_err_text out varchar2);

    --
    -- Удалить документ (локально + в ДКСУ, если ранее отправлялся)
    --
    procedure DeleteDocument(p_doc_id    in documents.doc_id%type,
                             p_err_text out varchar2);

    --
    -- Подтверждение запроса на выплату
    --
    procedure ConfirmRequest (p_id       in number
                             ,p_err_text out varchar2);

    --
    -- Подтверждение списка на выплату / формирование "витягу"
    --
    procedure ConfirmRequestList (p_err_text    out varchar2);
    
    --
    -- Проверка подписи на данных взыскателей, готовых для отправки в выдержку
    --
    procedure CheckRequestListSign (p_err_text out varchar2);

    --
    -- Добавление комментария к запросу
    --
    procedure CommentRequest (p_request_id   in receivers.req_id%type,
                              p_comment      in varchar2,
                              p_err_text    out varchar2);

    --
    -- Добавление комментария к запросу
    --
    procedure getCommentsHistory (p_request_id   in receivers.req_id%type,
                                  p_err_text    out varchar2);

    --
    -- Получение векселей от ДКСУ
    --
    procedure getBills (p_err_text out varchar2);

    --
    -- Получение векселей от ЦА
    --
    procedure getBillsLocal (p_err_text out varchar2);

    --
    -- Отправка векселей от ЦА в регион (смена статуса)
    --
    procedure sendBillsbyMFO (p_mfo in varchar2, p_err_text out varchar2);

    --
    -- Подтверждение получения списка векселей
    --
    procedure ConfirmBillList (p_billlist in  xmltype
                              ,p_err_text out varchar2);

    --
    -- Обновление внешних статусов получателей
    --
    procedure updateReqStatuses (p_force in number, p_err_text out varchar2);

    --
    -- Отзыв запроса на выплату
    --
    procedure RevokeRequest (p_exp_id     in ca_receivers.exp_id%type,
                             p_err_text  out varchar2);

    --
    -- Сохранение файла в архив
    --
    procedure StoreFile (p_file_id    out file_archive.file_id%type,
                         p_file_name   in file_archive.file_name%type,
                         p_description in file_archive.description%type,
                         p_file_data   in file_archive.file_data%type,
                         p_err_text   out varchar2);

    --
    -- Редактирование свойств (имя, описание) архивного файла
    --
    procedure EditFileProperties (p_file_id     in file_archive.file_id%type,
                                  p_file_name   in file_archive.file_name%type,
                                  p_description in file_archive.description%type,
                                  p_err_text   out varchar2);
    
    --
    -- Удаление файла из архива
    --
    procedure DeleteFile (p_file_id   in file_archive.file_id%type, 
                          p_err_text out varchar2);

    --
    -- Выдача векселей на руки
    --
    procedure HandOutBills (p_exp_id     in receivers.exp_id%type,
                            p_err_text  out varchar2);

    --
    -- Формирование проводок
    --
    function  create_prov (p_amount    in number
                          ,p_branch    in varchar2
                          ,p_direction in varchar2
                          ,p_type      in integer
                          ,p_err_text  out varchar2
                          )
      return number;

end Bill_API;
/
CREATE OR REPLACE PACKAGE BODY BILLS.BILL_API is

    g_body_version constant varchar2(64) := 'Version 1.4.1 11/10/2018';
    G_TRACE        constant varchar2(20) := 'bill_api.';

    --
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2 is
    begin
        return 'Package header bill_api ' || g_header_version;
    end header_version;

    --
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2 is
    begin
        return 'Package body bill_api ' || g_body_version;
    end body_version;

    --
    -- Поиск судебного решения
    --
    Procedure SearchResolution (p_code in resolutions.res_code%type,
                                p_date in date,
                                p_err_text out varchar2)
    is
    v_num number;
    v_progname varchar2(30) := 'SearchResolution';
    v_params   bill_audit.param_str%type := 'res_code = '||p_code||', p_date = '||p_date;
    begin
        select count(1) into v_num
          from resolutions
          where res_code = p_code
            and res_date = p_date;
        if v_num = 0 then
            -- сохраняем информацию о поиске решения
            insert into resolutions (res_code,
                                     res_date,
                                     status,
                                     res_id,
                                     last_user,
                                     last_dt)
            values (p_code, p_date, 'IN', null, bsm.f_username, sysdate);
        else
            update resolutions
               set status = 'IN',
                   response = null
             where res_code = p_code
               and res_date = p_date;
        end if;
        -- отправляем запрос
        bill_service_mgr.request_resolution(p_res_code => p_code, p_res_date => p_date, p_err_text => p_err_text);
        logger.log_action(p_action    => v_progname,
                          p_key       => null,
                          p_params    => v_params,
                          p_result    => nvl(p_err_text, 'Пошук рішення виконано'),
                          p_log_level => case when p_err_text is not null then 'ERROR' else 'TRACE' end);
    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => null,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101, p_err_text);
    end SearchResolution;

    --
    -- Взять "очікуваного стягувача" в работу
    --
    procedure Move2Work (p_exp_id   in number
                        ,p_err_text out varchar2)
      is
      v_progname varchar2(30) := 'Move2Work';
      v_params   bill_audit.param_str%type := 'exp_id = '||p_exp_id;
      v_result   bill_audit.result%type;
    begin
      insert into receivers (exp_id,
                             resolution_id,
                             name,
                             inn,
                             doc_no,
                             currency,
                             amount,
                             cl_type,
                             status,
                             last_dt,
                             last_user,
                             branch)
      select p_exp_id,
             v.res_id,
             v.receiver_name,
             v.receiver_code,
             v.receiver_doc_no,
             v.currency_id,
             v.amount,
             1,
             'IN',
             sysdate,
             bsm.f_username,
             bsm.f_user_branch
        from v_exp_receivers v
        where v.exp_id = p_exp_id
          and not exists (select 1 from receivers where exp_id = p_exp_id);

      if sql%rowcount = 1 then
        select 'Отримувача "'||name||'" успішно додано в роботу (id ='||p_exp_id||')'
          into v_result
          from receivers t
          where exp_id = p_exp_id;
      else
        select 'Отримувач "'||name||'" вже знаходиться в роботі (id ='||p_exp_id||')'
          into v_result
          from receivers t
          where exp_id = p_exp_id;
        p_err_text := v_result;
      end if;

      logger.log_action(p_action => v_progname,
                        p_key    => p_exp_id,
                        p_params => v_params,
                        p_result => v_result);

    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => p_exp_id,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101,p_err_text);

    end Move2Work;

    --
    -- Обновить данные по получателю (локально)
    --
    procedure UpdateReceiver (p_exp_id  in number
                             ,p_name    in varchar2
                             ,p_inn     in varchar2
                             ,p_docno   in varchar2
                             ,p_docdate in date
                             ,p_docwho  in varchar2
                             ,p_cltype  in number
                             ,p_phone   in varchar2
                             ,p_address in varchar2
                             ,p_account in varchar2
                             ,p_rnk     in number
                             ,p_err_text out varchar2)
      is
      v_progname bill_audit.action%type := 'UpdateReceiver';
      v_params   bill_audit.param_str%type := 'exp_id = '||p_exp_id||
                                              ', name = '||p_name||
                                              ', inn = '||p_inn;
    begin
      update receivers
        set name = p_name,
            inn  = p_inn,
            doc_no = p_docno,
            doc_date = p_docdate,
            doc_who = p_docwho,
            cl_type = p_cltype,
            phone = p_phone,
            address = p_address,
            account = p_account,
            rnk = p_rnk,
            last_dt = sysdate,
            last_user = bsm.f_username,
            branch = bsm.f_user_branch
        where exp_id = p_exp_id;

      logger.log_action(p_action => v_progname,
                        p_key    => p_exp_id,
                        p_params => v_params,
                        p_result => 'Дані отримувача успішно оновлені');
    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => p_exp_id,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101,p_err_text);
    end UpdateReceiver;

    --
    -- Удалить получателя - либо локально, либо отказаться от работы с ним (отзыв заявки из ДКСУ)
    --
    procedure DeleteReceiver (p_exp_id  in receivers.exp_id%type
                             ,p_err_text out varchar2)
        is
    l_status varchar2(2);
    v_progname bill_audit.action%type := 'DeleteReceiver';
    v_params   bill_audit.param_str%type := 'exp_id = '||p_exp_id;
    begin
        select status into l_status from receivers where exp_id = p_exp_id;
        if l_status = 'IN' then
            -- удаляем локально
            delete from receivers where exp_id = p_exp_id;
            logger.log_action(p_action => v_progname,
                              p_key    => p_exp_id,
                              p_params => v_params,
                              p_result => 'Запис щодо отримувача успішно видалено');
        else
            -- отзываем в ДКСУ + удаляем локально
            bsm.create_ClearRequest_request(p_exp_id, p_err_text);
            logger.log_action(p_action => v_progname,
                              p_key    => p_exp_id,
                              p_params => v_params,
                              p_result => nvl(p_err_text, 'Отримувача успішно відкріплено від банку'),
                              p_log_level => case when p_err_text is null then 'INFO' else 'ERROR' end);
        end if;
    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => p_exp_id,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101,p_err_text);
    end DeleteReceiver;

    --
    -- Отправить созданные / измененные данные по получателю в Казначейство
    --
    procedure CreateRequest (p_exp_id      in number
                            ,p_action  in varchar2
                            ,p_err_text out varchar2)
      is
      v_progname bill_audit.action%type := 'CreateRequest';
      v_params   bill_audit.param_str%type := 'exp_id = '||p_exp_id||', action = '||p_action;
    begin
      if upper(p_action) = 'CREATERQ' then
        bill_service_mgr.create_receiver_request(p_exp_id => p_exp_id, p_new_receiver => true, p_err_text => p_err_text);
      elsif upper(p_action) = 'UPDATERQ' then
        bill_service_mgr.create_receiver_request(p_exp_id => p_exp_id, p_new_receiver => false, p_err_text => p_err_text);
      end if;
      if p_err_text is not null then
        logger.log_action(p_action    => v_progname,
                          p_key       => p_exp_id,
                          p_params    => v_params,
                          p_result    => nvl(p_err_text, 'Запит створено'),
                          p_log_level => case when p_err_text is null then 'INFO' else 'ERROR' end);
      end if;
    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => p_exp_id,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101,p_err_text);

    end CreateRequest;

    --
    -- Прикрепить документ к получателю
    --
    procedure AddDocument (p_doc_id   in out documents.doc_id%type,
                           p_rec_id   in     documents.rec_id%type,
                           p_doc_type in     documents.doc_type%type,
                           p_doc_body in     documents.doc_body%type default null,
                           p_filename in     documents.filename%type,
                           p_descript in     documents.descript%type default null,
                           p_err_text  out    varchar2)
      is
      v_progname bill_audit.action%type := 'AddDocument';
      v_params   bill_audit.param_str%type := 'doc_id = '||p_doc_id||
                                              ', exp_id = '||p_rec_id||
                                              ', doc_type = '||p_doc_type;
      v_result   bill_audit.result%type;
    begin
        if p_doc_id is null then
            insert into documents (doc_id,
                                   rec_id,
                                   doc_type,
                                   doc_body,
                                   status,
                                   last_dt,
                                   last_user,
                                   filename,
                                   descript)
            values(s_documents.nextval,
                   p_rec_id,
                   p_doc_type,
                   p_doc_body,
                   'IN',
                   sysdate,
                   bsm.f_username,
                   case when p_doc_type in (1, 2) then (select code from dict_doc_types where id = p_doc_type)|| to_char(sysdate, '_yyyymmdd_hh24mi_') || BSM.f_ourmfo || '.pdf'
                        else p_filename end,
                   p_descript);
          v_result := 'Успішно додано новий документ (тип = '||p_doc_type||') для поточного отримувача';
        else
            update documents d
            set doc_body = nvl(p_doc_body, d.doc_body),
                filename = case when p_doc_type in (1, 2) then (select code from dict_doc_types where id = p_doc_type)|| to_char(sysdate, '_yyyymmdd_hh24mi_') || BSM.f_ourmfo || '.pdf'
                                else p_filename end,
                status = 'IN',
                last_dt = sysdate,
                last_user = bsm.f_username,
                descript = p_descript
            where doc_id = p_doc_id;
          v_result := 'Успішно оновлено документ (тип = '||p_doc_type||') для поточного отримувача';
        end if;

        logger.log_action(p_action => v_progname,
                          p_key    => p_rec_id,
                          p_params => v_params,
                          p_result => v_result);
    exception
        when dup_val_on_index then
            p_err_text := 'Документ з таким типом ['||p_doc_type||']вже існує для поточного отримувача';
            logger.error(p_action => v_progname,
                         p_key    => p_rec_id,
                         p_params => v_params,
                         p_result => p_err_text);
        when others then
            p_err_text := sqlerrm||' : '||dbms_utility.format_error_backtrace;
            logger.error(p_action => v_progname,
                         p_key    => p_rec_id,
                         p_params => v_params,
                         p_result => p_err_text);
    end AddDocument;

    --
    -- Сохранить заявление (от ДКСУ) для печати
    --
    procedure GetApplication (p_id      in number
                             ,p_err_text out varchar2)
    is
      v_progname bill_audit.action%type := 'GetApplication';
      v_params   bill_audit.param_str%type := 'id = '||p_id;
    begin
        bill_service_mgr.create_printbill_request (p_rec_id   => p_id,
                                                   p_name     => 'Application_'||ltrim(to_char(p_id))||'.pdf',
                                                   p_err_text => p_err_text);
        if p_err_text is not null then
            logger.error(p_action => v_progname,
                         p_key    => p_id,
                         p_params => v_params,
                         p_result => p_err_text);
        end if;
    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => p_id,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101,p_err_text);
    end GetApplication;
    
    --
    -- Сохранить расчет сум реструктуризированной задолженности (от ДКСУ) для печати
    --
    procedure GetCalcRequest (p_request_id out number,
                              p_date_from  in calc_request.date_from%type,
                              p_err_text   out varchar2)
    is
      v_progname bill_audit.action%type := 'GetCalcRequest';
      v_params   bill_audit.param_str%type := 'request_id = '||p_request_id;
    begin
        bill_service_mgr.create_CalcRequest_request (p_request_id => p_request_id,
                                                     p_date_from => p_date_from,
                                                     p_err_text   => p_err_text);
        if p_err_text is not null then
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => v_params,
                         p_result => p_err_text);
        end if;
    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => null,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101,p_err_text);
    end GetCalcRequest;
    
    --
    -- Прикрепить скан расчета сум реструктуризированной задолженности
    --
    procedure AddCalcRequestScan (p_request_id   in calc_request.request_id%type,
                                  p_scan_name    in calc_request.scan_name%type,
                                  p_scan_body    in calc_request.scan_body%type,
                                  p_err_text     out varchar2)
    is
    v_progname bill_audit.action%type := 'AddCalcRequestScan';
    v_params   bill_audit.param_str%type := 'p_request_id = '||p_request_id;
    begin
        update calc_request
        set scan_name = p_scan_name,
            scan_body = p_scan_body,
            scan_date = sysdate
        where request_id = p_request_id;
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => v_params,
                         p_result => p_err_text);
            raise_application_error(-20101, p_err_text);
    end AddCalcRequestScan;

    --
    -- Отправить скан расчета сум реструктуризированной задолженности в ДКСУ
    --
    procedure SendCalcRequest (p_request_id   in calc_request.request_id%type,
                               p_err_text     out varchar2)
        is
    v_err_text varchar2(1000);
    v_progname bill_audit.action%type := 'SendCalcRequest';
    v_params   bill_audit.param_str%type := 'p_request_id = '||p_request_id;
    begin
        for r in (select request_id, d.scan_name from calc_request d
                   where d.request_id = p_request_id
                     and d.scan_body is not null /*есть файл*/ )
        loop
            bill_service_mgr.create_sendCalcRequest_request(p_request_id => r.request_id,
                                                            p_err_text   => v_err_text);
            if v_err_text is not null then
                p_err_text := p_err_text||chr(10)||'При відправці документа '||r.scan_name||' виникла помилка: '||v_err_text;
            end if;
            logger.log_action(p_action => v_progname,
                              p_key    => null,
                              p_params => v_params||', p_request_id = '||p_request_id||', filename = '||r.scan_name,
                              p_result => nvl(p_err_text,'Документ успішно відправлено'),
                              p_log_level => case when p_err_text is null then 'INFO' else 'ERROR' end);
        end loop;

    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => v_params,
                         p_result => p_err_text);
            raise_application_error(-20101, p_err_text);
    end SendCalcRequest;

    --
    -- Получить сохраненный документ
    --
    function GetPrintDoc (p_doc_id   in documents.doc_id%type)
      return clob
      is
      v_clob clob;
      v_progname bill_audit.action%type := 'GetPrintDoc';
      v_params   bill_audit.param_str%type := 'id = '||p_doc_id;
      v_result   bill_audit.result%type;
      v_rec_id   documents.rec_id%type;
    begin
      select d.doc_body, d.rec_id
        into v_clob, v_rec_id
        from documents d, dict_doc_types dt
        where dt.id = d.doc_type
          and d.doc_id = p_doc_id;
      return v_clob;
    exception
      when others then
        v_result := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => v_rec_id,
                     p_params => v_params,
                     p_result => v_result);
        raise_application_error(-20101,v_result);
    end GetPrintDoc;

    --
    -- Отправить документ в ДКСУ
    --
    procedure SendDocument (p_rec_id   in documents.rec_id%type,
                            p_doc_id   in documents.doc_id%type default null,
                            p_err_text out varchar2)
        is
    v_err_text varchar2(1000);
    v_progname bill_audit.action%type := 'SendDocument';
    v_params   bill_audit.param_str%type := 'rec_id = '||p_rec_id;
    begin
        for r in (select * from documents d
                   where d.rec_id = p_rec_id
                     and d.doc_id = nvl(p_doc_id, d.doc_id)
                     and d.status = 'IN')
        loop
            bill_service_mgr.create_attachfile_request(p_doc_id   => r.doc_id,
                                                       p_err_text => v_err_text);
            if v_err_text is not null then
                p_err_text := p_err_text||chr(10)||'При відправці документа '||r.filename||' виникла помилка: '||v_err_text;
            end if;
            logger.log_action(p_action => v_progname,
                              p_key    => p_rec_id,
                              p_params => v_params||', doc_id = '||r.doc_id||', filename = '||r.filename,
                              p_result => nvl(p_err_text,'Документ успішно відправлено'),
                              p_log_level => case when p_err_text is null then 'INFO' else 'ERROR' end);
        end loop;

    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => p_rec_id,
                         p_params => v_params,
                         p_result => p_err_text);
            raise_application_error(-20101, p_err_text);
    end SendDocument;

    --
    -- Удалить документ (локально + в ДКСУ, если ранее отправлялся)
    --
    procedure DeleteDocument(p_doc_id    in documents.doc_id%type,
                             p_err_text out varchar2)
        is
      l_doc_status documents.status%type;
      v_progname bill_audit.action%type := 'DeleteDocument';
      v_params   bill_audit.param_str%type := 'doc_id = '||p_doc_id;
      v_key      bill_audit.key_id%type;
    begin
        select status, rec_id into l_doc_status, v_key
          from documents
          where doc_id = p_doc_id;
        if l_doc_status != 'IN' then
            bill_service_mgr.create_deletefile_request(p_doc_id => p_doc_id, p_err_text => p_err_text);
        else
            delete from documents where doc_id = p_doc_id;
        end if;
        logger.log_action(p_action => v_progname,
                          p_key    => v_key,
                          p_params => v_params,
                          p_result => nvl(p_err_text, 'Документ видалено'),
                          p_log_level => case when p_err_text is null then 'INFO' else 'ERROR' end);
    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => v_key,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101,p_err_text);
    end DeleteDocument;

    --
    -- Подтверждение запроса на выплату
    --
    procedure ConfirmRequest (p_id        in number
                             ,p_err_text out varchar2)
        is
      v_progname bill_audit.action%type := 'ConfirmRequest';
      v_params   bill_audit.param_str%type := 'exp_id = '||p_id;
    begin
        bill_service_mgr.create_confirmation_request(p_exp_id => p_id, p_err_text => p_err_text);
        logger.log_action(p_action => v_progname,
                          p_key    => p_id,
                          p_params => v_params,
                          p_result => nvl(p_err_text, 'Запит підтверджено'),
                          p_log_level => case when p_err_text is null then 'INFO' else 'ERROR' end);
    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => p_id,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101,p_err_text);
    end ConfirmRequest;

    --
    -- Подтверждение списка на выплату / формирование "витягу"
    --
    procedure ConfirmRequestList (p_err_text    out varchar2)
    is
    v_progname bill_audit.action%type := 'ConfirmRequestList';
    v_params   bill_audit.param_str%type;
    begin
        -- логирование выполняется внутри BSM
        bill_service_mgr.create_CRL_request(p_err_text);
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => v_params,
                         p_result => p_err_text);
            raise_application_error(-20101,p_err_text);
    end ConfirmRequestList;
    
    --
    -- Проверка подписи на данных взыскателей, готовых для отправки в выдержку
    --
    procedure CheckRequestListSign (p_err_text out varchar2)
    is
    v_progname bill_audit.action%type := 'CheckRequestListSign';
    v_params   bill_audit.param_str%type;
    l_err_text varchar2(4000);
    begin
        for rec in (select * from ca_receivers where status = 'XX')
        loop
            -- при ошибке проверки ЭЦП
            if signer.validate_signature(p_exp_id => rec.exp_id, p_source => signer.g_source_ca_receivers) is not null then
                -- Отзываем запрос с Казначейства
                bill_service_mgr.create_RevokeRequest_request(p_exp_id => rec.exp_id, p_err_text => l_err_text);
                if l_err_text is null then
                    p_err_text := p_err_text || 'Помилка перевірки ЕЦП на стягувачі '||rec.name||' - повернено на доопрацювання;' || chr(10);
                else
                    logger.log_action(p_action => 'RevokeRequest',
                                      p_key    => rec.exp_id,
                                      p_params => null,
                                      p_result => 'Помилка відклику запиту:'||l_err_text);
                    p_err_text := p_err_text || 'Помилка відклику запиту по '||rec.name||' - зверніться до деп. інформатизації;' || chr(10);
                end if;
            end if;
        end loop;
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => v_params,
                         p_result => p_err_text);
            raise_application_error(-20101,p_err_text);
    end CheckRequestListSign;

    --
    -- Добавление комментария к запросу
    --
    procedure CommentRequest (p_request_id   in receivers.req_id%type,
                              p_comment      in varchar2,
                              p_err_text    out varchar2)
    is
      v_progname bill_audit.action%type := 'CommentRequest';
      v_params   bill_audit.param_str%type := 'req_id = '||p_request_id;
    begin
        bill_service_mgr.create_comment_request(p_request_id, p_comment, p_err_text);
        logger.log_action(p_action => v_progname,
                          p_key    => null,
                          p_params => v_params,
                          p_result => nvl(p_err_text, 'Коментар додано'),
                          p_log_level => case when p_err_text is null then 'TRACE' else 'ERROR' end);
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => v_params,
                         p_result => p_err_text);
            raise_application_error(-20101, p_err_text);
    end CommentRequest;

    --
    -- Обновление истории комментариев по запросу
    --
    procedure getCommentsHistory (p_request_id   in receivers.req_id%type,
                                  p_err_text    out varchar2)
    is
      v_progname bill_audit.action%type := 'getCommentsHistory';
      v_params   bill_audit.param_str%type := 'req_id = '||p_request_id;
    begin
        bill_service_mgr.create_comment_history_request(p_request_id, p_err_text);
        logger.log_action(p_action => v_progname,
                          p_key    => null,
                          p_params => v_params,
                          p_result => nvl(p_err_text, 'Отримано історію комментарів'),
                          p_log_level => case when p_err_text is null then 'TRACE' else 'ERROR' end);
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => v_params,
                         p_result => p_err_text);
            raise_application_error(-20101, p_err_text);
    end getCommentsHistory;

    --
    -- Получение векселей от ДКСУ
    --
    procedure getBills (p_err_text out varchar2)
    is
      v_progname bill_audit.action%type := 'getBills';
    begin
        bill_service_mgr.create_get_bills_request(p_err_text);
        logger.log_action(p_action => v_progname,
                          p_key    => null,
                          p_params => null,
                          p_result => nvl(p_err_text, 'Отримано векселі від ЦА'),
                          p_log_level => case when p_err_text is null then 'INFO' else 'ERROR' end);
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => null,
                         p_result => p_err_text);
            raise_application_error(-20101, p_err_text);
    end getBills;

    --
    -- Получение векселей от ЦА
    --
    procedure getBillsLocal (p_err_text out varchar2)
    is
      v_progname bill_audit.action%type := 'getBillsLocal';
    begin
        bill_service_mgr.create_get_bills_local_request(p_err_text);
        logger.log_action(p_action => v_progname,
                          p_key    => null,
                          p_params => null,
                          p_result => nvl(p_err_text, 'Отримано векселі від ЦА'),
                          p_log_level => case when p_err_text is null then 'INFO' else 'ERROR' end);
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => null,
                         p_result => p_err_text);
            raise_application_error(-20101, p_err_text);
    end getBillsLocal;

    --
    -- Отправка векселей от ЦА в регион (смена статуса)
    --
    procedure sendBillsbyMFO (p_mfo in varchar2, p_err_text out varchar2)
    is
      v_progname bill_audit.action%type := 'sendBillsbyMFO';
      v_count    number := 0;
      v_num      integer;
    begin
        update rec_bills b
          set b.status = 'SR'
          where b.status = 'RC'
            and (p_mfo = (select kf from ca_receivers c where c.exp_id = b.rec_id) or p_mfo is null)
          returning sum(b.amount) into v_count;
--        v_count := sql%rowcount;
        if v_count >0 then  -- сумма принятых векселей больше нуля - оприходуем их
          v_num := create_prov (p_amount    => v_count,
                                p_branch    => null,
                                p_direction => 'O',
                                p_type      => 5,
                                p_err_text  => p_err_text);
          if v_num != 0 then
            raise_application_error(-20101,'При генерації проведеннь по оприбуткуванню векселів виникла помилка: '||p_err_text);
          end if;
        end if;
        
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            raise_application_error(-20101, p_err_text);
    end sendBillsbyMFO;

    --
    -- Подтверждение получения списка векселей
    --
    procedure ConfirmBillList (p_billlist in  xmltype
                              ,p_err_text out varchar2)
      is
      v_progname bill_audit.action%type := 'ConfirmBillList';
      v_status   dict_status.code%type;
      v_count    number := 0;
      v_num      number;
    begin
      for r in (select *
                  from xmltable('ROOT/ConfirmBill' passing p_billlist
                columns
                exp_id number path 'EXP_ID',
                bill_no varchar2(100) path 'BILL_NO')
               )
      loop
        select amount into v_num
          from rec_bills b
          where b.rec_id = r.exp_id
            and bill_no = r.bill_no;

        update rec_bills b
          set b.status = case b.status
                           when 'SN' then 'RC'
                           when 'SR' then 'RR'
                         end,
              b.last_dt = sysdate,
              b.last_user = bill_service_mgr.f_username
          where b.rec_id = r.exp_id
            and b.bill_no = r.bill_no
            and b.status in ('SN','SR');
        if sql%rowcount = 0 then
          begin
            select status into v_status
              from rec_bills
              where rec_id = r.exp_id
                and bill_no = r.bill_no;
            raise_application_error(-20101,'Помилка при підтвердженні векселя. Статус '||v_status||' не дозволяє обрану операцію!');
          exception
            when no_data_found then
              raise_application_error(-20101,'Помилка при підтвердженні векселя. Вексель [No = '||r.bill_no||', ID отримувача = '||r.exp_id||'] не знайдений!');
          end;
        else
          v_count := v_count + v_num;
        end if;
      end loop;
      logger.log_action(p_action    => v_progname,
                        p_key       => null,
                        p_params    => null,
                        p_result    => 'Векселя підтверджено');
      if v_count >0 then  -- количество принятых векселей больше нуля - оприходуем их
        v_num := create_prov (p_amount    => v_count,
                              p_branch    => null,
                              p_direction => 'I',
                              p_type      => 5,
                              p_err_text  => p_err_text);
        if v_num != 0 then
          raise_application_error(-20101,'При генерації проведеннь по оприбуткуванню векселів виникла помилка: '||p_err_text);
        end if;
      end if;
    exception
        when others then
            p_err_text := sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => null,
                         p_result => p_err_text);
    end ConfirmBillList;

    --
    -- Обновление внешних статусов получателей
    --
    procedure updateReqStatuses (p_force in number, p_err_text out varchar2)
        is
    begin
        bsm.create_getReqStatuses_request(p_force, p_err_text);
    end updateReqStatuses;

    --
    -- Отзыв запроса на выплату
    --
    procedure RevokeRequest (p_exp_id     in ca_receivers.exp_id%type,
                             p_err_text out varchar2)
        is
      v_progname bill_audit.action%type := 'RevokeRequest';
      v_params   bill_audit.param_str%type := 'exp_id = '||p_exp_id;
    begin
        bill_service_mgr.create_RevokeRequest_request(p_exp_id, p_err_text);
        logger.log_action(p_action => v_progname,
                          p_key    => p_exp_id,
                          p_params => v_params,
                          p_result => nvl(p_err_text, 'Запит відкликано'),
                          p_log_level => case when p_err_text is null then 'INFO' else 'ERROR' end);
    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => p_exp_id,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101,p_err_text);
    end RevokeRequest;
    
    --
    -- Выдача векселей на руки
    --
    procedure HandOutBills (p_exp_id     in receivers.exp_id%type,
                            p_err_text  out varchar2)
        is
      v_progname bill_audit.action%type := 'HandOutBills';
      v_params   bill_audit.param_str%type := 'exp_id = '||p_exp_id;
      v_count    number := 0;
      v_num      integer;
    begin
        bill_service_mgr.create_SetBillsHanded_request(p_exp_id, p_err_text);
        if p_err_text is not null then
          raise_application_error(-20101, p_err_text);
        end if;
        logger.log_action(p_action => v_progname,
                          p_key    => p_exp_id,
                          p_params => v_params,
                          p_result => 'Векселя видані стягувачу');
       for r in (select * from rec_bills where rec_id = p_exp_id)
       loop
         if r.status != 'OK' then
           p_err_text := 'Вексель '||r.bill_no||' знаходиться в статусі '||r.status||', який не відповідає можливості виплати';
           raise_application_error(-20101,p_err_text);
         end if;
         v_count := nvl(v_count,0) + r.amount;
       end loop;

        if v_count >0 then  -- количество принятых векселей больше нуля - оприходуем их
          v_num := create_prov (p_amount    => v_count,
                                p_branch    => null,
                                p_direction => 'O',
                                p_type      =>  1,
                                p_err_text  => p_err_text);
          if v_num != 0 then
            raise_application_error(-20101,'При генерації проведеннь при видачі векселів виникла помилка: '||p_err_text);
          end if;
        end if;
        
    exception
      when others then
        p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
        logger.error(p_action => v_progname,
                     p_key    => p_exp_id,
                     p_params => v_params,
                     p_result => p_err_text);
        raise_application_error(-20101,p_err_text);
    end HandOutBills;

    --
    -- Сохранение файла в архив
    --
    procedure StoreFile (p_file_id    out file_archive.file_id%type,
                         p_file_name   in file_archive.file_name%type,
                         p_description in file_archive.description%type,
                         p_file_data   in file_archive.file_data%type,
                         p_err_text   out varchar2)
    is
    v_progname bill_audit.action%type := 'StoreFile';
    v_params   bill_audit.param_str%type := 'file_id = :file_id, name='||p_file_name;
    begin
        insert into file_archive (kf,
                                  file_id,
                                  file_name,
                                  description,
                                  file_data,
                                  load_date,
                                  file_status)
        values (bill_abs_integration.f_ourmfo,
                s_file_archive.nextval,
                p_file_name,
                p_description,
                p_file_data,
                sysdate,
                'IN')
        returning file_id into p_file_id;
        logger.log_action(p_action => v_progname,
                          p_key    => null,
                          p_params => replace(v_params, ':file_id', p_file_id),
                          p_result => 'Файл збережено');
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => replace(v_params, ':file_id', p_file_id),
                         p_result => p_err_text);
            raise_application_error(-20101, p_err_text);
    end StoreFile;

    --
    -- Редактирование свойств (имя, описание) архивного файла
    --
    procedure EditFileProperties (p_file_id     in file_archive.file_id%type,
                                  p_file_name   in file_archive.file_name%type,
                                  p_description in file_archive.description%type,
                                  p_err_text   out varchar2)
    is
    v_progname bill_audit.action%type := 'EditFileProperties';
    v_params   bill_audit.param_str%type := 'file_id = '||p_file_id||', name='||p_file_name;
    begin
        update file_archive
        set file_name = p_file_name,
            description = p_description
        where file_id = p_file_id;
        logger.log_action(p_action => v_progname,
                          p_key    => null,
                          p_params => v_params,
                          p_result => 'Опис файлу оновлено');
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => v_params,
                         p_result => p_err_text);
            raise_application_error(-20101, p_err_text);
    end EditFileProperties;
    
    --
    -- Удаление файла из архива
    --
    procedure DeleteFile (p_file_id   in file_archive.file_id%type, 
                          p_err_text out varchar2)
    is
    v_progname bill_audit.action%type := 'DeleteFile';
    v_params   bill_audit.param_str%type := 'file_id = '||p_file_id;
    begin
        delete from file_archive where file_id = p_file_id;
        logger.log_action(p_action => v_progname,
                          p_key    => null,
                          p_params => v_params,
                          p_result => 'Файл видалено');
    exception
        when others then
            p_err_text := G_TRACE||v_progname||'. Помилка при роботі процедури: '||sqlerrm;
            logger.error(p_action => v_progname,
                         p_key    => null,
                         p_params => v_params,
                         p_result => p_err_text);
            raise_application_error(-20101, p_err_text);
    end DeleteFile;

    --
    -- Создание проводок при передаче векселей
    --
    function  create_prov (p_amount    in number
                          ,p_branch    in varchar2
                          ,p_direction in varchar2
                          ,p_type      in integer
                          ,p_err_text  out varchar2
                          )
      return number
      is
      v_rec opers%rowtype;
      v_num number;
      v_txt varchar2(1000);
      v_params bill_audit.param_str%type := 'p_direction = '||p_direction||', p_amount = '||p_amount||', p_mfo = '||p_branch;

    begin
      v_rec.id := s_opers_id_seq.nextval;
      v_rec.oper_dt := bill_abs_integration.get_oper_dt;
      v_rec.cur_code := '980';
      v_rec.mfo := bill_abs_integration.f_ourmfo;
      if p_direction = 'I' then
        v_rec.dbt := bill_abs_integration.get_account(p_product => get_bill_param('ACN_9819'),
                                                      p_client  => null,
                                                      p_cur     => 980,
                                                      p_mfo     => v_rec.mfo);
        v_rec.crd := bill_abs_integration.get_account(p_product => '991001',
                                                      p_client  => null,
                                                      p_cur     => 980,
                                                      p_mfo     => v_rec.mfo);
        v_rec.purpose := 'Оприбуткування векселів. Сума = '||p_amount;
      elsif p_direction = 'O' then
        v_rec.dbt := bill_abs_integration.get_account(p_product => '991001',
                                                      p_client  => null,
                                                      p_cur     => 980,
                                                      p_mfo     => v_rec.mfo);
        v_rec.crd := bill_abs_integration.get_account(p_product => get_bill_param('ACN_9819'),
                                                      p_client  => null,
                                                      p_cur     => 980,
                                                      p_mfo     => v_rec.mfo);
        v_rec.purpose := 'Списання векселів. Сума = '||p_amount;
      else
        raise_application_error(-20000,'Невірно вказаний тип операції ['||p_direction||']. Очікується "I" або "O"');
      end if;
      if v_rec.dbt is null then
        v_txt := 'Не вдалось знайти рахунок по дебету!';
      end if;
      if v_rec.crd is null then
        v_txt := v_txt||' '||'Не вдалось знайти рахунок по кредиту!';
      end if;
      if v_txt is null then
      
        v_rec.amount := p_amount;
        v_rec.state  := 'IN';

        insert into opers (id,
                           oper_dt,
                           dbt,
                           crd,
                           amount,
                           state,
                           doc_ref,
                           cur_code,
                           purpose,
                           mfo)
          values (v_rec.id,
                  v_rec.oper_dt,
                  v_rec.dbt,
                  v_rec.crd,
                  v_rec.amount,
                  v_rec.state,
                  v_rec.doc_ref,
                  v_rec.cur_code,
                  v_rec.purpose,
                  v_rec.mfo);


        v_num := bill_abs_integration.make_prov(p_id => v_rec.id, p_type=> p_type, p_err_text => v_txt);
        if v_num = 0 then
          v_txt := 'Проводка успішно оплачена';
        end if;
      end if;

      p_err_text := v_txt;
      logger.log_action(p_action    => 'CREATE_PROV',
                        p_key       => null,
                        p_params    => v_params,
                        p_result    => v_txt,
                        p_log_level => case when v_num = 0 then 'TRACE' else 'ERROR' end);
      
      return v_num;
    exception
      when others then
        p_err_text := sqlerrm;
        v_num := -1;
        logger.log_action(p_action    => 'CREATE_PROV',
                          p_key       => null,
                          p_params    => v_params,
                          p_result    => p_err_text,
                          p_log_level => case when v_num = 0 then 'TRACE' else 'ERROR' end);
        return v_num;
    end create_prov;
end Bill_API;
/
 show err;
 
PROMPT *** Create  grants  BILL_API ***
grant EXECUTE                                                                on BILL_API        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/package/bill_api.sql =========*** End *** =
 PROMPT ===================================================================================== 
 