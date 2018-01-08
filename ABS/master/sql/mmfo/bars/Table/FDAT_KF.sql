-- ======================================================================================
-- Module : 
-- Author : BAA
-- Date   : 15.08.2017
-- ======================================================================================
-- create table FDAT_KF
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
prompt -- create table FDAT_KF
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'FDAT_KF', 'WHOLE', null, null, null, null );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table FDAT_KF
( KF         varchar2(6)  constraint CC_FDATKF_KF_NN not null
, constraint PK_FDATKF      primary key ( KF )
, constraint FK_FDATKF_MVKF foreign key ( KF ) references MV_KF ( KF )
) ORGANIZATION INDEX 
tablespace BRSSMLD
nologging ]';
  
  dbms_output.put_line( 'Table "FDAT_KF" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "FDAT_KF" already exists.' );
end;
/


SET FEEDBACK ON

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  FDAT_KF IS 'МФО користувачам якого заборонено вхід в попередню банківську дату';

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================