-- ======================================================================================
-- Module : N/A
-- Author : BAA
-- Date   : 16.01.2017
-- ======================================================================================
-- create user IBMESB
-- ======================================================================================


prompt -- ======================================================
prompt -- create user IBMESB
prompt -- ======================================================

declare 
  e_usr_exists           exception;
  pragma exception_init( e_usr_exists, -01920 );
begin
  execute immediate 'create user IBMESB identified by IBMESB';
  dbms_output.put_line('User created.');
exception
  when e_usr_exists
  then null;
end;
/



grant create session to IBMESB;

grant insert, update, delete, select on BARS.PRVN_FV_REZ to IBMESB;
