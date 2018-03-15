declare
    schema_already_exists exception;
    pragma exception_init(schema_already_exists, -1920);
begin
    execute immediate 'create user barstrans identified by &&barstrans_pass default tablespace brsmdld';
exception
    when schema_already_exists then
         null;
end;
/

grant create session to barstrans;
grant create table to barstrans;
grant create view to barstrans;
grant create type to barstrans;
grant create sequence to barstrans;
grant create procedure to barstrans;
grant debug any procedure to barstrans;
grant debug connect session to barstrans;
grant create materialized view to barstrans;
grant create job to barstrans;
grant manage scheduler to barstrans;
grant unlimited tablespace to barstrans;
grant scheduler_admin to barstrans with admin option;

grant bars_access_defrole to barstrans;

grant execute, debug on bars.tools to barstrans with grant option;
grant execute, debug on bars.bars_audit to barstrans;
grant execute, debug on bars.bars_login to barstrans;
grant execute, debug on bars.bars_context to barstrans;
grant execute, debug on bars.wsm_mgr to barstrans;
grant execute, debug on bars.number_list to barstrans;
grant execute, debug on bars.string_list to barstrans;

grant select on bars.web_barsconfig to barstrans;


GRANT EXECUTE, DEBUG ON BARS.OW_BATCH_OPENING TO BARSTRANS;
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO BARSTRANS;

