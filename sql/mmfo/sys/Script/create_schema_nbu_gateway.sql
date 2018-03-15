declare
    schema_already_exists exception;
    pragma exception_init(schema_already_exists, -1920);
begin
    execute immediate 'create user nbu_gateway identified by nbu_gateway default tablespace brsmdld';
exception
    when schema_already_exists then
         null;
end;
/

grant create session to nbu_gateway;
grant create table to nbu_gateway;
grant create view to nbu_gateway;
grant create type to nbu_gateway;
grant create sequence to nbu_gateway;
grant create procedure to nbu_gateway;
grant debug any procedure to nbu_gateway;
grant debug connect session to nbu_gateway;
grant create materialized view to nbu_gateway;
grant create job to nbu_gateway;
grant manage scheduler to nbu_gateway;
grant unlimited tablespace to nbu_gateway;
grant scheduler_admin to nbu_gateway with admin option;

grant bars_access_defrole to nbu_gateway;

grant execute, debug on bars.lob_utl to nbu_gateway with grant option;
grant execute, debug on bars.tools to nbu_gateway with grant option;
grant execute, debug on bars.list_utl to nbu_gateway with grant option;
grant execute, debug on bars.branch_attribute_utl to nbu_gateway with grant option;
grant execute, debug on bars.bars_audit to nbu_gateway;
grant execute, debug on bars.bars_login to nbu_gateway;
grant execute, debug on bars.bars_context to nbu_gateway;
grant execute, debug on bars.wsm_mgr to nbu_gateway;
grant execute, debug on bars.number_list to nbu_gateway;
grant execute, debug on bars.string_list to nbu_gateway;

grant select on bars.cur_rates$base to nbu_gateway;
grant select on bars.tabval$global to nbu_gateway;

rem grant execute, debug on barstrans.transport_utl to nbu_gateway;

rem grant select on bars.nbu_address_fo to nbu_gateway;
rem grant select on bars.nbu_contr to nbu_gateway;
rem grant select on bars.nbu_credit to nbu_gateway;
rem grant select on bars.nbu_credit_pledge to nbu_gateway;
rem grant select on bars.nbu_credit_tranche to nbu_gateway;
rem grant select on bars.nbu_document_fo to nbu_gateway;
rem grant select on bars.nbu_finperformancegr_uo to nbu_gateway;
rem grant select on bars.nbu_finperformancepr_uo to nbu_gateway;
rem grant select on bars.nbu_finperformance_uo to nbu_gateway;
rem grant select on bars.nbu_organization_fo to nbu_gateway;
rem grant select on bars.nbu_groupur_uo to nbu_gateway;
rem grant select on bars.nbu_ownerjur_uo to nbu_gateway;
rem grant select on bars.nbu_ownerpp_uo to nbu_gateway;
rem grant select on bars.nbu_partners_uo to nbu_gateway;
rem grant select on bars.nbu_person_fo to nbu_gateway;
rem grant select on bars.nbu_person_uo to nbu_gateway;
rem grant select on bars.nbu_pledge_dep to nbu_gateway;
rem grant select on bars.nbu_profit_fo to nbu_gateway;
rem grant select on bars.nbu_family_fo to nbu_gateway;

grant execute on barstrans.transp_utl to nbu_gateway;
grant select on barstrans.TRANSP_RECEIVE_DATA to nbu_gateway;


