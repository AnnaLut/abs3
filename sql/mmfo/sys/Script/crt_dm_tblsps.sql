-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 19.10.2017
-- ======================================================================================
-- create TableSpaces for DM
-- ======================================================================================

prompt -- ======================================================
prompt -- create tablespace for DataMart's tables and indexes
prompt -- ======================================================

declare
  e_tblsp_exists         exception;
  pragma exception_init( e_tblsp_exists, -01543 );
  l_tblsp_nm             varchar2(30);
begin
  for c in ( select KF from BARS.KF_RU )
  loop
    l_tblsp_nm := 'BRS_DM_'||c.KF;
    begin
      execute immediate 'create tablespace '|| l_tblsp_nm || q'[
DATAFILE SIZE 32M 
AUTOEXTEND ON NEXT 32M 
MAXSIZE UNLIMITED 
LOGGING 
ONLINE 
EXTENT MANAGEMENT LOCAL AUTOALLOCATE 
SEGMENT SPACE MANAGEMENT AUTO 
FLASHBACK ON ]';
      dbms_output.put_line( 'Tablespace "'||l_tblsp_nm||'" created.' );
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
