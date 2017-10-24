
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/priocom_sign.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PRIOCOM_SIGN is
/**
	Пакет priocom_sign содержит процедуры для работы c очередями на снятие/наложение ЭЦП
	для задачи ПРИОКОМ
*/

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0 01/09/2006';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2;

/**
 * wait_inbound_message - возвращает сообщение из очереди Inbound
 * время ожидания - 1 сек
 * @param p_exist      0-сообщение отсутствует,1-сообщение вычитано
 * @param p_selector   селектор сообщения: SIGN_IMPORT - переподписать документы при импорте
 *                                         SIGN_EXPORT - переподписать документы при экспорте
 * @param p_message    тело сообщения
 * @param p_msgid      ID сообщения(для дальнейшей обработки)
 */
procedure wait_inbound_message(p_exist out integer, p_selector out varchar2, p_message out varchar2,
                               p_msgid out raw);

/**
 * remove_inbound_message - удаляет сообщение из очереди Inbound
 */
procedure remove_inbound_message(p_msgid in raw);

/**
 * insert_ready_message - вставляет сообщение в Outbound очередь о готовности к дальнейшему импорту
 */
procedure insert_ready_message(p_selector in varchar2, p_message in varchar2);

/**
 * base64_to_raw - преобразует строку формата base64 в raw
 */
function base64_to_raw(p_base64 in varchar2) return raw;

/**
 * raw_to_base64 - преобразует строку формата raw в base64
 */
function raw_to_base64(p_raw in raw) return varchar2;

end priocom_sign;
/
CREATE OR REPLACE PACKAGE BODY BARS.PRIOCOM_SIGN is
/**
	Пакет priocom_sign содержит процедуры для работы c очередями на снятие/наложение ЭЦП
	для задачи ПРИОКОМ
*/

G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0 01/09/2006';

G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';

-- определяем исключение на отсутствие сообщений в очереди
MQ_EMPTY_OR_TIMEOUT_EXCEPTION EXCEPTION;
PRAGMA EXCEPTION_INIT(MQ_EMPTY_OR_TIMEOUT_EXCEPTION, -25228);

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header PRIOCOM_SIGN '||G_HEADER_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_HEADER_DEFS;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body PRIOCOM_SIGN '||G_BODY_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_BODY_DEFS;
end body_version;

/**
 * wait_inbound_message - возвращает сообщение из очереди Inbound
 * время ожидания - 1 сек
 * @param p_exist      0-сообщение отсутствует,1-сообщение вычитано
 * @param p_selector   селектор сообщения: SIGN_IMPORT - переподписать документы при импорте
 *                                         SIGN_EXPORT - переподписать документы при экспорте
 * @param p_message    тело сообщения
 * @param p_msgid      ID сообщения(для дальнейшей обработки)
 */
procedure wait_inbound_message(p_exist out integer, p_selector out varchar2, p_message out varchar2,
                               p_msgid out raw) is
    dequeue_options         dbms_aq.dequeue_options_t;
    message_properties      dbms_aq.message_properties_t;
    message_handle          RAW(16);
    message                 bars.t_priocom_exchange;
begin
    dequeue_options.wait := 1;
    dequeue_options.dequeue_mode := dbms_aq.browse;
    begin
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_inbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        p_exist    := 1;
        p_selector := message.selector;
        p_message  := message.message;
        p_msgid    := message_handle;
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        p_exist    := 0;
        p_selector := null;
        p_message  := null;
        p_msgid    := null;
    end;
end wait_inbound_message;

/**
 * remove_inbound_message - удаляет сообщение из очереди Inbound
 */
procedure remove_inbound_message(p_msgid in raw) is
    dequeue_options         dbms_aq.dequeue_options_t;
    message_properties      dbms_aq.message_properties_t;
    message_handle          RAW(16);
    message                 bars.t_priocom_exchange;
begin
    dequeue_options.wait         := dbms_aq.no_wait;
    dequeue_options.dequeue_mode := dbms_aq.remove_nodata;
    dequeue_options.msgid        := p_msgid;
    dbms_aq.dequeue(
        queue_name          => 'bars.priocom_inbound_queue',
        dequeue_options     => dequeue_options,
        message_properties  => message_properties,
        payload             => message,
        msgid               => message_handle
    );
end remove_inbound_message;

/**
 * insert_ready_message - вставляет сообщение в Outbound очередь о готовности к дальнейшему импорту
 */
procedure insert_ready_message(p_selector in varchar2, p_message in varchar2) is
    enqueue_options         dbms_aq.enqueue_options_t;
    message_properties      dbms_aq.message_properties_t;
    message_handle          RAW(16);
    message                 bars.t_priocom_exchange;
begin
    message := bars.t_priocom_exchange(p_selector,p_message);
    dbms_aq.enqueue(
        queue_name          => 'bars.priocom_outbound_queue',
        enqueue_options     => enqueue_options,
        message_properties  => message_properties,
        payload             => message,
        msgid               => message_handle
    );
end insert_ready_message;

/**
 * base64_to_raw - преобразует строку формата base64 в raw
 */
function base64_to_raw(p_base64 in varchar2) return raw is
begin
    return
    case
        when p_base64 is null then null
        else utl_encode.base64_decode(utl_raw.cast_to_raw(p_base64))
    end;
end base64_to_raw;

/**
 * raw_to_base64 - преобразует строку формата raw в base64
 */
function raw_to_base64(p_raw in raw) return varchar2 is
begin
    return
    case
        when p_raw is null then null
        else utl_raw.cast_to_varchar2(utl_encode.base64_encode(p_raw))
    end;
end raw_to_base64;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/priocom_sign.sql =========*** End **
 PROMPT ===================================================================================== 
 