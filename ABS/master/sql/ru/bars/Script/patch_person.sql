-- ======================================================================================
-- Module : ALL
-- Author : BAA
-- Date   : 
-- ======================================================================================
-- modify table PERSON
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TRIMSPOOL    ON
prompt -- ======================================================
prompt --  modify table PERSON
prompt -- ======================================================

begin
  
  execute immediate 'alter table PERSON modify ORGAN varchar2(150)';
  
  dbms_output.put_line( 'Table PERSON altered.' );
  
end;
/

SET FEEDBACK ON
