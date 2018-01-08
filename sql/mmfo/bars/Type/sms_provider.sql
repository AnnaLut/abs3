
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/sms_provider.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.SMS_PROVIDER as object (
    ----
    -- SMS_PROVIDER - интерфейс SMS-провайдера
    --                используетс€ пакетом BARS_SMS
    -- SERG, 30/08/2010
    --

    l_provider_shortname    varchar2(30),
    l_provider_fullname     varchar2(512),

    ----
    -- HEADER_VERSION - возвращает версию заголовка объектного типа
    --
    static function header_version
    return varchar2,

    ----
    -- BODY_VERSION - возвращает версию тела объектного типа
    --
    static function body_version
    return varchar2,

    ----
    -- ”молчательный конструктор - должен быть об€зательно реализован в производных типах
    --
    constructor function sms_provider
    return self as result,

    ----
    -- SUBMIT_MSG - посылает сообщение с указанным msg_id.
    --
    -- –аботает с таблицой msg_submit_data.
    -- ѕри успешной посылке устанавливает:
    --     status='SUBMITTED', status_time=sysdate, submit_code='<код возврата>', last_error=null
    -- ≈сли сообщение отклонено, устанавливает:
    --     status='REJECTED',  status_time=sysdate, submit_code='<код возврата>', last_error=null
    -- ѕри наличии системных ошибок(н-р, транспортного уровн€), устанавливает:
    --     status='ERROR',     status_time=sysdate, last_error='<описание ошибки>'
    -- ≈сли провайдер поддерживает запрос статуса сообщени€, заполн€ет таблицу sms_query_data.
    --
    member procedure submit_msg(p_msgid in integer),

    ----
    -- IS_QUERY_STATUS_SUPPORTED - возвращает 0/1-признак поддержки запросов статуса SMS
    --
    member function is_query_status_supported
    return boolean,

    ----
    -- QUERY_STATUS - запрашивает статус сообщени€ с указанным sms_id
    --
    -- –аботает с таблицой sms_query_data.
    -- «апон€ет пол€ query_counter, query_time, query_code, sms_state, next_query_time, last_error.
    -- ѕоле sms_state принимает значени€ 'UNKNOWN','TOSEND','ENROUTE','PAUSED','ERROR'.
    --
    member procedure query_status(p_smsid in varchar2)

) not final
  not instantiable
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/sms_provider.sql =========*** End *** =
 PROMPT ===================================================================================== 
 