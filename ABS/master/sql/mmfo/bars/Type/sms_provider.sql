
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/sms_provider.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.SMS_PROVIDER as object (
    ----
    -- SMS_PROVIDER - ��������� SMS-����������
    --                ������������ ������� BARS_SMS
    -- SERG, 30/08/2010
    --

    l_provider_shortname    varchar2(30),
    l_provider_fullname     varchar2(512),

    ----
    -- HEADER_VERSION - ���������� ������ ��������� ���������� ����
    --
    static function header_version
    return varchar2,

    ----
    -- BODY_VERSION - ���������� ������ ���� ���������� ����
    --
    static function body_version
    return varchar2,

    ----
    -- ������������� ����������� - ������ ���� ����������� ���������� � ����������� �����
    --
    constructor function sms_provider
    return self as result,

    ----
    -- SUBMIT_MSG - �������� ��������� � ��������� msg_id.
    --
    -- �������� � �������� msg_submit_data.
    -- ��� �������� ������� �������������:
    --     status='SUBMITTED', status_time=sysdate, submit_code='<��� ��������>', last_error=null
    -- ���� ��������� ���������, �������������:
    --     status='REJECTED',  status_time=sysdate, submit_code='<��� ��������>', last_error=null
    -- ��� ������� ��������� ������(�-�, ������������� ������), �������������:
    --     status='ERROR',     status_time=sysdate, last_error='<�������� ������>'
    -- ���� ��������� ������������ ������ ������� ���������, ��������� ������� sms_query_data.
    --
    member procedure submit_msg(p_msgid in integer),

    ----
    -- IS_QUERY_STATUS_SUPPORTED - ���������� 0/1-������� ��������� �������� ������� SMS
    --
    member function is_query_status_supported
    return boolean,

    ----
    -- QUERY_STATUS - ����������� ������ ��������� � ��������� sms_id
    --
    -- �������� � �������� sms_query_data.
    -- �������� ���� query_counter, query_time, query_code, sms_state, next_query_time, last_error.
    -- ���� sms_state ��������� �������� 'UNKNOWN','TOSEND','ENROUTE','PAUSED','ERROR'.
    --
    member procedure query_status(p_smsid in varchar2)

) not final
  not instantiable
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/sms_provider.sql =========*** End *** =
 PROMPT ===================================================================================== 
 