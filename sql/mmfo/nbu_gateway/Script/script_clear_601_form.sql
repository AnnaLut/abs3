truncate table core_address_fo;
truncate table core_credit;
truncate table core_credit_pledge;
truncate table core_credit_tranche;
truncate table core_document_fo;
truncate table core_family_fo;
truncate table core_finperformance_uo;
truncate table core_finperformancegr_uo;
truncate table core_finperformancepr_uo;
truncate table core_groupur_uo;
truncate table core_organization_fo;
truncate table core_ownerjur_uo;
truncate table core_ownerpp_uo;
truncate table core_partners_uo;
truncate table core_person_fo;
truncate table core_person_uo;
truncate table core_pledge_dep;
truncate table core_profit_fo;
/
begin
    delete nbu_session_tracking;
    delete nbu_session;
    delete nbu_reported_loan;
    delete nbu_reported_pledge;
    delete nbu_reported_customer;
    delete nbu_reported_object_tracking;
    delete nbu_reported_object;
    delete nbu_core_data_request_tracking;
    delete nbu_core_data_request;
    delete nbu_report_instance_tracking;
    delete nbu_report_instance;
    commit;	
end;
/
