-- ======================================================================================
-- Module : ALL
-- Author : BAA
-- Date   : 
-- ======================================================================================
-- modify table PERSON_UPDATE
-- ======================================================
prompt -- ======================================================
prompt --  modify table PERSON_UPDATE
prompt -- ======================================================

begin
  
  execute immediate 'alter table PERSON_UPDATE modify ORGAN varchar2(150)';
  
  dbms_output.put_line( 'Table PERSON_UPDATE altered.' );
  
end;
/