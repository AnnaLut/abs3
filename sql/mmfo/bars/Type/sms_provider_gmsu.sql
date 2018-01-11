
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/sms_provider_gmsu.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.SMS_PROVIDER_GMSU under sms_provider(
    ----
    -- SMS_PROVIDER_GMSU - SMS-провайдер GMSU
    --
    -- SERG, 30/08/2010
    --
            
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
    -- Умолчательный конструктор
    --
    constructor function sms_provider_gmsu 
    return self as result,
    
    ----
    -- SUBMIT_MSG - посылает сообщение с указанным msg_id.
    --
    -- Работает с таблицой msg_submit_data.
    -- При успешной посылке устанавливает:
    --     status='SUBMITTED', status_time=sysdate, submit_code='<код возврата>', last_error=null
    -- Если сообщение отклонено, устанавливает:
    --     status='REJECTED',  status_time=sysdate, submit_code='<код возврата>', last_error=null
    -- При наличии системных ошибок(н-р, транспортного уровня), устанавливает:
    --     status='ERROR',     status_time=sysdate, last_error='<описание ошибки>'
    -- Если провайдер поддерживает запрос статуса сообщения, заполняет таблицу sms_query_data.
    --
    overriding member procedure submit_msg(p_msgid in integer),
    
    ----
    -- IS_QUERY_STATUS_SUPPORTED - возвращает 0/1-признак поддержки запросов статуса SMS 
    --
    overriding member function is_query_status_supported 
    return boolean,
    
    ----
    -- QUERY_STATUS - запрашивает статус сообщения с указанным sms_id 
    --
    -- Работает с таблицой sms_query_data.
    -- Запоняет поля query_counter, query_time, query_code, sms_state, next_query_time, last_error.                                     
    -- Поле sms_state принимает значения 'UNKNOWN','TOSEND','ENROUTE','PAUSED','ERROR'. 
    --
    overriding member procedure query_status(p_smsid in varchar2)
 
) final 
  instantiable
/
CREATE OR REPLACE TYPE BODY BARS.SMS_PROVIDER_GMSU as
    ----
    -- SMS_PROVIDER_GMSU - SMS-провайдер GMSU
    --
    -- SERG, 30/08/2010
    --        
    
    ----
    -- HEADER_VERSION - возвращает версию заголовка объектного типа
    --
    static function header_version
    return varchar2
    is
    begin
        return 'Type SMS_PROVIDER_GMSU header: version 1.0 30/08/2010';
    end header_version;    
    
    ----
    -- BODY_VERSION - возвращает версию тела объектного типа
    --
    static function body_version
    return varchar2
    is
    begin
        return 'Type SMS_PROVIDER_GMSU body: version 1.0 30/08/2010';
    end body_version;       

    ----
    -- Умолчательный конструктор
    --
    constructor function sms_provider_gmsu 
    return self as result
    is
    begin
        self.l_provider_shortname   := 'SMS_PROVIDER_GMSU';
        self.l_provider_fullname    := '«Global Message Services Ukraine», www.gmsu.ua'; 
        return;
    end sms_provider_gmsu; 
    
    ----
    -- SUBMIT_MSG - посылает сообщение с указанным msg_id.
    --
    -- Работает с таблицой msg_submit_data.
    -- При успешной посылке устанавливает:
    --     status='SUBMITTED', status_time=sysdate, submit_code='<код возврата>', last_error=null
    -- Если сообщение отклонено, устанавливает:
    --     status='REJECTED',  status_time=sysdate, submit_code='<код возврата>', last_error=null
    -- При наличии системных ошибок(н-р, транспортного уровня), устанавливает:
    --     status='ERROR',     status_time=sysdate, last_error='<описание ошибки>'
    -- Если провайдер поддерживает запрос статуса сообщения, заполняет таблицу sms_query_data.
    --
    overriding member procedure submit_msg(p_msgid in integer)
    is
    begin
        bars_sms_gmsu.submit_msg(p_msgid);
    end submit_msg;
    
    ----
    -- IS_QUERY_STATUS_SUPPORTED - возвращает 0/1-признак поддержки запросов статуса SMS 
    --
    overriding member function is_query_status_supported 
    return boolean
    is
    begin
        return false;
    end is_query_status_supported;
    
    ----
    -- QUERY_STATUS - запрашивает статус сообщения с указанным sms_id 
    --
    -- Работает с таблицой sms_query_data.
    -- Запоняет поля query_counter, query_time, query_code, sms_state, next_query_time, last_error.                                     
    -- Поле sms_state принимает значения 'UNKNOWN','TOSEND','ENROUTE','PAUSED','ERROR'. 
    --
    overriding member procedure query_status(p_smsid in varchar2)
    is
    begin
        bars_sms_gmsu.query_status(p_smsid);
    end query_status;
 
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/sms_provider_gmsu.sql =========*** End 
 PROMPT ===================================================================================== 
 