
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/notary_redemption_request.sql =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NOTARY_REDEMPTION_REQUEST (
    p_url in varchar2,
    p_authorization_val in varchar2,
    p_walett_path in varchar2,
    p_walett_pass in varchar2,
    p_accreditation_id in integer)
return boolean
is
    l_url varchar2(4000 byte) := p_url;
    l_response wsm_mgr.t_response;
begin

    if (substr(l_url, length(l_url)) <> '/') then
        l_url := l_url || '/';
    end if;

    wsm_mgr.prepare_request(p_url          => l_url,
                            p_action       => 'accr_cancel' || '/' || p_accreditation_id,
                            p_http_method  => wsm_mgr.G_HTTP_POST,
                            p_content_type => wsm_mgr.G_CT_JSON,
                            p_wallet_path  => p_walett_path,
                            p_wallet_pwd   => p_walett_pass);

    wsm_mgr.add_header     (p_name  => 'Authorization',
                            p_value => p_authorization_val);

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
                          'p_accreditation_id  : ' || p_accreditation_id || chr(10) ||
                          dbms_lob.substr(l_response.cdoc, 2000));
         return false;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/notary_redemption_request.sql =====
 PROMPT ===================================================================================== 
 