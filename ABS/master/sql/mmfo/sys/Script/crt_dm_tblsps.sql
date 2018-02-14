-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 19.10.2017
-- ======================================================================================
-- create TABLESPACES
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create tablespace for DataMart's tables
prompt -- ======================================================

declare
  e_tblsp_exists         exception;
  pragma exception_init( e_tblsp_exists, -01543 );
begin
  for c in ( select KF from BARS.KF_RU )
  loop
    begin
      execute immediate 'create tablespace BRS_DM_D_' || c.KF || q'[
DATAFILE SIZE 32M 
AUTOEXTEND ON NEXT 32M 
MAXSIZE UNLIMITED 
LOGGING 
ONLINE 
EXTENT MANAGEMENT LOCAL AUTOALLOCATE 
SEGMENT SPACE MANAGEMENT AUTO 
FLASHBACK ON ]';
      dbms_output.put_line( 'Tablespace created.' );
    exception
      when e_tblsp_exists
      then null;
      when OTHERS 
      then dbms_output.put_line( sqlerrm );
    end;
  end loop;
end;
/

prompt -- ======================================================
prompt -- create tablespace for DataMart's indexes
prompt -- ======================================================

declare
  e_tblsp_exists         exception;
  pragma exception_init( e_tblsp_exists, -01543 );
begin
  for c in ( select KF from BARS.KF_RU )
  loop
    begin
      execute immediate 'create tablespace BRS_DM_I_' ||c.KF || q'[
DATAFILE SIZE 4M
AUTOEXTEND ON NEXT 4M
MAXSIZE UNLIMITED
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON]';
      dbms_output.put_line( 'Tablespace created.' );
    exception
      when e_tblsp_exists
      then null;
      when OTHERS 
      then dbms_output.put_line( sqlerrm );
    end;
  end loop;
end;
/

-- select * 
--   from DBA_TABLESPACES 
--  where TABLESPACE_NAME like 'BRS%'
