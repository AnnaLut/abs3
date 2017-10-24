
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/notary_alter_request.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NOTARY_ALTER_REQUEST (
    p_url in varchar2,
    p_authorization_val in varchar2,
    p_walett_path in varchar2,
    p_walett_pass in varchar2,
    p_customer_id in integer)
return boolean
is
    l_url varchar2(4000 byte) := p_url;
    l_notary_type varchar2(4000 byte);
    l_certificate_number varchar2(4000 byte);
    l_response wsm_mgr.t_response;
    l_result clob;
begin

    l_notary_type := customer_utl.get_element(p_customer_id, 'NOTAT');
    l_certificate_number := customer_utl.get_element(p_customer_id, 'NOTAN');

    if (l_notary_type is null) then
        bars_audit.error('notary_accreditation_request' || chr(10) ||
                         'Тип реєстрації нотаріуса не заповнений' || chr(10) ||
                         'p_customer_id : ' || p_customer_id);
         return true;
    end if;

    if (l_certificate_number is null) then
        bars_audit.error('notary_accreditation_request' || chr(10) ||
                         'Номер свідоцтва про реєстрацію нотаріуса не заповнений' || chr(10) ||
                         'p_customer_id : ' || p_customer_id);
         return true;
    end if;

    if (substr(l_url, length(l_url)) <> '/') then
        l_url := l_url || '/';
    end if;

    wsm_mgr.prepare_request(p_url          => l_url,
                            p_action       => 'alter_query_accreditation',
                            p_http_method  => wsm_mgr.G_HTTP_POST,
                            p_content_type => wsm_mgr.G_CT_JSON,
                            p_wallet_path  => p_walett_path,
                            p_wallet_pwd   => p_walett_pass);

    wsm_mgr.add_header     (p_name  => 'Authorization',
                            p_value => p_authorization_val);

    wsm_mgr.add_parameter(p_name  => 'SenderMfo'        , p_value => getglobaloption('MFO'));
    wsm_mgr.add_parameter(p_name  => 'NotaryType'       , p_value => l_notary_type);
    wsm_mgr.add_parameter(p_name  => 'CertNumber'       , p_value => l_certificate_number);
    wsm_mgr.add_parameter(p_name  => 'AccountNumber'    , p_value => customer_utl.get_element(p_customer_id, 'NOTAS'));

    wsm_mgr.execute_request(l_response);

    return true;
exception
    when others then
         bars_audit.error('notary_alter_request' || chr(10) ||
                          sqlerrm || chr(10) || dbms_utility.format_error_backtrace() || chr(10) ||
                          'p_url               : ' || p_url || chr(10) ||
                          'p_authorization_val : ' || case when p_authorization_val is null then 'null' else 'passed' end || chr(10) ||
                          'p_walett_path       : ' || case when p_walett_path is null then 'null' else 'passed' end || chr(10) ||
                          'p_walett_pass       : ' || case when p_walett_pass is null then 'null' else 'passed' end || chr(10) ||
                          'p_customer_id       : ' || p_customer_id || chr(10) ||
                          dbms_lob.substr(l_result, 2000));
         return false;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/notary_alter_request.sql =========*
 PROMPT ===================================================================================== 
 