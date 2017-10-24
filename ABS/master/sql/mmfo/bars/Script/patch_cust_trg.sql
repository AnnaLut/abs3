-- ======================================================================================
-- Module : CAC
-- Author : BAA
-- Date   : 08.08.2017
-- ======================================================================================
-- drop triggers
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

declare
  l_trg_nm               varchar2(30);
  e_trg_not_exists       exception;
  pragma exception_init( e_trg_not_exists, -04080 );
begin
  l_trg_nm := 'TAI_CUSTOMER_BUSSL';
  execute immediate 'drop trigger '||l_trg_nm;
  dbms_output.put_line( 'Trigger "'||l_trg_nm||'"dropped.' );
exception
  when e_trg_not_exists then
    dbms_output.put_line( 'Trigger "'||l_trg_nm||'" does not exist.' );
end;
/

declare
  l_trg_nm               varchar2(30);
  e_trg_not_exists       exception;
  pragma exception_init( e_trg_not_exists, -04080 );
begin
  l_trg_nm := 'TIU_ZAPRET';
  execute immediate 'drop trigger '||l_trg_nm;
  dbms_output.put_line( 'Trigger "'||l_trg_nm||'"dropped.' );
exception
  when e_trg_not_exists then
    dbms_output.put_line( 'Trigger "'||l_trg_nm||'" does not exist.' );
end;
/

declare
  l_trg_nm               varchar2(30);
  e_trg_not_exists       exception;
  pragma exception_init( e_trg_not_exists, -04080 );
begin
  l_trg_nm := 'TIU_CUS_GR';
  execute immediate 'drop trigger '||l_trg_nm;
  dbms_output.put_line( 'Trigger "'||l_trg_nm||'"dropped.' );
exception
  when e_trg_not_exists then
    dbms_output.put_line( 'Trigger "'||l_trg_nm||'" does not exist.' );
end;
/

declare
  l_trg_nm               varchar2(30);
  e_trg_not_exists       exception;
  pragma exception_init( e_trg_not_exists, -04080 );
begin
  l_trg_nm := 'TAI_CUST_RIZIK';
  execute immediate 'drop trigger '||l_trg_nm;
  dbms_output.put_line( 'Trigger "'||l_trg_nm||'"dropped.' );
exception
  when e_trg_not_exists then
    dbms_output.put_line( 'Trigger "'||l_trg_nm||'" does not exist.' );
end;
/
