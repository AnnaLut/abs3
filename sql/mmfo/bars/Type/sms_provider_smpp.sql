
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/sms_provider_smpp.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.SMS_PROVIDER_SMPP under sms_provider(
    ----
    -- SMS_PROVIDER_SMPP - TYPE ��� ������ �� SMPP ���������
    --
    -- MOS, 31/07/2013
    --

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
    -- ������������� �����������
    --
    constructor function sms_provider_smpp
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
    overriding member procedure submit_msg(p_msgid in integer),

    ----
    -- IS_QUERY_STATUS_SUPPORTED - ���������� 0/1-������� ��������� �������� ������� SMS
    --
    overriding member function is_query_status_supported
    return boolean,

    ----
    -- QUERY_STATUS - ����������� ������ ��������� � ��������� sms_id
    --
    -- �������� � �������� sms_query_data.
    -- �������� ���� query_counter, query_time, query_code, sms_state, next_query_time, last_error.
    -- ���� sms_state ��������� �������� 'UNKNOWN','TOSEND','ENROUTE','PAUSED','ERROR'.
    --
    overriding member procedure query_status(p_smsid in varchar2)

) final
  instantiable
/
CREATE OR REPLACE TYPE BODY BARS.SMS_PROVIDER_SMPP as
    ----
    -- SMS_PROVIDER_SMPP - TYPE ��� ������ �� SMPP ���������
    --
    -- MOS, 31/07/2013
    --
    ----
    -- HEADER_VERSION - ���������� ������ ��������� ���������� ����
    --
    static function header_version
    return varchar2
    is
    begin
        return 'Type SMS_PROVIDER_SMPP header: version 1.0 31/07/2013';
    end header_version;

    ----
    -- BODY_VERSION - ���������� ������ ���� ���������� ����
    --
    static function body_version
    return varchar2
    is
    begin
        return 'Type SMS_PROVIDER_SMPP body: version 1.0 31/07/2013';
    end body_version;

    ----
    -- ������������� �����������
    --
    constructor function sms_provider_smpp
    return self as result
    is
    begin
        self.l_provider_shortname   := 'SMS_PROVIDER_SMPP';
        self.l_provider_fullname    := 'SMPP protocol';
        return;
    end sms_provider_smpp;

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
    overriding member procedure submit_msg(p_msgid in integer)
    is
    begin
        bars_sms_smpp.submit_msg(p_msgid);
    end submit_msg;

    ----
    -- IS_QUERY_STATUS_SUPPORTED - ���������� 0/1-������� ��������� �������� ������� SMS
    --
    overriding member function is_query_status_supported
    return boolean
    is
    begin
        return false;
    end is_query_status_supported;

    ----
    -- QUERY_STATUS - ����������� ������ ��������� � ��������� sms_id
    --
    -- �������� � �������� sms_query_data.
    -- �������� ���� query_counter, query_time, query_code, sms_state, next_query_time, last_error.
    -- ���� sms_state ��������� �������� 'UNKNOWN','TOSEND','ENROUTE','PAUSED','ERROR'.
    --
    overriding member procedure query_status(p_smsid in varchar2)
    is
    begin
        bars_sms_smpp.query_status(p_smsid);
    end query_status;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/sms_provider_smpp.sql =========*** End 
 PROMPT ===================================================================================== 
 