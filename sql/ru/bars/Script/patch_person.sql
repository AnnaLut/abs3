-- ======================================================================================
-- Module : ALL
-- Author : BAA
-- Date   : 
-- ======================================================================================
-- modify table PERSON
-- ======================================================

prompt -- ======================================================
prompt --  modify table PERSON
prompt -- ======================================================

begin
  
  execute immediate 'alter table PERSON modify ORGAN varchar2(150)';
  
  dbms_output.put_line( 'Table PERSON altered.' );
  
end;
/

SET FEEDBACK ON
