-- ======================================================================================
-- Module : COBUVEKSEL
-- Author : lypskykh
-- Date   : 24.04.2018
-- ======================================================================================
-- create user BILLS
-- ======================================================================================


prompt -- ======================================================
prompt -- create user BILLS
prompt -- ======================================================

declare 
  e_usr_exists           exception;
  pragma exception_init( e_usr_exists, -01920 );
begin
  execute immediate 'create user BILLS identified by bills';
  dbms_output.put_line('User created.');
exception
  when e_usr_exists
  then null;
end;
/
prompt grants
grant alter any index to BILLS;
grant alter any sequence to BILLS;
grant alter any table to BILLS;
grant alter any trigger to BILLS;
grant alter any type to BILLS;
grant create any index to BILLS;
grant create any job to BILLS;
grant create any procedure to BILLS;
grant create any sequence to BILLS;
grant create any table to BILLS;
grant create any view to BILLS;
grant create session to BILLS;
grant create synonym to BILLS;
grant debug connect session to BILLS;
grant unlimited tablespace to BILLS;
grant create type to bills;
grant create any trigger to BILLS;

grant select on BARS.ACCOUNTS to BILLS with grant option;
grant execute on BARS.BARS_AUDIT to BILLS;
grant execute on BARS.BARS_CONTEXT to BILLS;
grant execute on BARS.BARS_LOGIN to BILLS;
grant select on BARS.CUSTOMER to BILLS with grant option;
grant select on BARS.CUSTOMERW to BILLS with grant option;
grant select on BARS.CUSTTYPE to BILLS with grant option;
grant execute on BARS.F_OURMFO to BILLS;
grant execute on BARS.F_OURMFO_G to BILLS;
grant execute on BARS.GL to BILLS;
grant execute on BARS.PAYTT to BILLS;
grant select on BARS.PERSON to BILLS with grant option;
grant select on BARS.TABVAL to BILLS with grant option;
grant execute on BARS.USER_NAME to BILLS;
grant select on BARSTRANS.INPUT_REQS to BILLS;
grant select on BARSTRANS.OUTPUT_LOG to BILLS;
grant select on BARSTRANS.OUT_REQS to BILLS;
grant execute on BARSTRANS.TRANSP_UTL to BILLS;
grant select on bars.oper to bills with grant option;