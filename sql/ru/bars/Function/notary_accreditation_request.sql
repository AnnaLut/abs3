
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/notary_accreditation_request.sql ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NOTARY_ACCREDITATION_REQUEST (
    p_url in varchar2,
    p_authorization_val in varchar2,
    p_walett_path in varchar2,
    p_walett_pass in varchar2,
    p_customer_id in integer)
return boolean
is
    l_url varchar2(4000 byte) := p_url;
    l_customer_row customer%rowtype;
    l_person_row person%rowtype;
    l_notary_type varchar2(4000 byte);
    l_certificate_number varchar2(4000 byte);
    l_first_name varchar2(4000 byte);
    l_middle_name varchar2(4000 byte);
    l_last_name varchar2(4000 byte);
    l_response wsm_mgr.t_response;
begin
    l_customer_row := customer_utl.read_customer(p_customer_id);
    l_person_row := customer_utl.read_person(p_customer_id);

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
                            p_action       => 'new_query_accreditation',
                            p_http_method  => wsm_mgr.G_HTTP_POST,
                            p_content_type => wsm_mgr.G_CT_JSON,
                            p_wallet_path  => p_walett_path,
                            p_wallet_pwd   => p_walett_pass);

    wsm_mgr.add_header     (p_name  => 'Authorization',
                            p_value => p_authorization_val);

    l_first_name := trim(customer_utl.get_element(p_customer_id, 'SN_FN'));
    l_middle_name := trim(customer_utl.get_element(p_customer_id, 'SN_MN'));
    l_last_name := trim(customer_utl.get_element(p_customer_id, 'SN_LN'));

    if (l_first_name is null) then
        l_first_name := substr(l_customer_row.nmk, instr(l_customer_row.nmk, ' ', 1, 1) + 1, instr(l_customer_row.nmk, ' ', 1, 2) - instr(l_customer_row.nmk, ' ', 1, 1) - 1);
    end if;

    if (l_middle_name is null) then
        l_middle_name := substr(l_customer_row.nmk, instr(l_customer_row.nmk, ' ', nth => 2) + 1);
    end if;

    if (l_last_name is null) then
        l_last_name := substr(l_customer_row.nmk, 1, instr(l_customer_row.nmk, ' ', nth => 1) - 1);
    end if;

    wsm_mgr.add_parameter(p_name  => 'SenderMfo'        , p_value => getglobaloption('MFO'));
    wsm_mgr.add_parameter(p_name  => 'NotaryType'       , p_value => l_notary_type);
    wsm_mgr.add_parameter(p_name  => 'CertNumber'       , p_value => l_certificate_number);
    wsm_mgr.add_parameter(p_name  => 'FirstName'        , p_value => l_first_name);
    wsm_mgr.add_parameter(p_name  => 'MiddleName'       , p_value => l_middle_name);
    wsm_mgr.add_parameter(p_name  => 'LastName'         , p_value => l_last_name);
    wsm_mgr.add_parameter(p_name  => 'DateOfBirth'      , p_value => to_char(l_person_row.bday, 'dd.mm.yyyy'));
    wsm_mgr.add_parameter(p_name  => 'AccreditationType', p_value => customer_utl.get_element(p_customer_id, 'NOTTA'));
    wsm_mgr.add_parameter(p_name  => 'Tin'              , p_value => l_customer_row.okpo);
    wsm_mgr.add_parameter(p_name  => 'PassportSeries'   , p_value => l_person_row.ser);
    wsm_mgr.add_parameter(p_name  => 'PassportNumber'   , p_value => l_person_row.numdoc);
    wsm_mgr.add_parameter(p_name  => 'PassportIssuer'   , p_value => l_person_row.organ);
    wsm_mgr.add_parameter(p_name  => 'PassportIssued'   , p_value => to_char(l_person_row.pdate, 'dd.mm.yyyy'));
    wsm_mgr.add_parameter(p_name  => 'Address'          , p_value => customer_utl.get_customer_address_line(p_customer_id));
    wsm_mgr.add_parameter(p_name  => 'PhoneNumber'      , p_value => coalesce(l_person_row.telw, l_person_row.teld));
    wsm_mgr.add_parameter(p_name  => 'MobilePhoneNumber', p_value => customer_utl.get_customer_mobile_phone(p_customer_id));
    wsm_mgr.add_parameter(p_name  => 'Email'            , p_value => customer_utl.get_element(p_customer_id, 'EMAIL'));
    wsm_mgr.add_parameter(p_name  => 'Rnk'              , p_value => to_char(p_customer_id));
    wsm_mgr.add_parameter(p_name  => 'AccountNumber'    , p_value => customer_utl.get_element(p_customer_id, 'NOTAS'));

    wsm_mgr.execute_request(l_response);

    return true;
exception
    when others then
         bars_audit.error('notary_accreditation_request' || chr(10) ||
                          sqlerrm || chr(10) || dbms_utility.format_error_backtrace() || chr(10) ||
                          'p_url               : ' || p_url || chr(10) ||
                          'p_authorization_val : ' || case when p_authorization_val is null then 'null' else 'passed' end || chr(10) ||
                          'p_walett_path       : ' || case when p_walett_path is null then 'null' else 'passed' end || chr(10) ||
                          'p_walett_pass       : ' || case when p_walett_pass is null then 'null' else 'passed' end || chr(10) ||
                          'p_customer_id       : ' || p_customer_id || chr(10) ||
                          dbms_lob.substr(l_response.cdoc, 2000));
         return false;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/notary_accreditation_request.sql ==
 PROMPT ===================================================================================== 
 