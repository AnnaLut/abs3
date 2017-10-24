-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 28.05.2017
-- ======================================================================================
-- create table ACCM_SNAP_SCN
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- recreate table ACCM_SNAP_SCN
prompt -- ======================================================

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  begin
    execute immediate 'drop table TEST_ACCM_SNAP_SCN';
    dbms_output.put_line( 'Table "TEST_ACCM_SNAP_SCN" dropped.' );
  exception
    when e_tab_not_exists then
    dbms_output.put_line( 'Table "TEST_ACCM_SNAP_SCN" does not exist.' );
  end;
  execute immediate 'create table TEST_ACCM_SNAP_SCN as select * from ACCM_SNAP_SCN';
  dbms_output.put_line( 'Table "TEST_ACCM_SNAP_SCN" created.' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  begin
    execute immediate 'drop table ACCM_SNAP_SCN_OLD';
    dbms_output.put_line( 'Table "ACCM_SNAP_SCN_OLD" dropped.' );
  exception
    when e_tab_not_exists then
      dbms_output.put_line( 'Table "ACCM_SNAP_SCN_OLD" does not exist.' );
  end;
  execute immediate 'rename TEST_ACCM_SNAP_SCN to ACCM_SNAP_SCN_OLD';
  dbms_output.put_line( 'Rename complete.' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  EXECUTE IMMEDIATE 'drop table ACCM_SNAP_SCN';
  dbms_output.put_line('Table dropped.');
exception
  when e_tab_not_exists then
    dbms_output.put_line( 'Table "ACCM_SNAP_SCN" does not exist.' );
end;
/

prompt -- ======================================================
prompt -- Policies
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'ACCM_SNAP_SCN', 'WHOLE' , NULL, NULL, NULL, NULL );
  bars.bpa.alter_policy_info( 'ACCM_SNAP_SCN', 'FILIAL',  'M',  'M',  'M',  'M' );
  bars.bpa.alter_policy_info( 'ACCM_SNAP_SCN', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table ACCM_SNAP_SCN
( KF          VARCHAR2(6)  default sys_context('bars_context','user_mfo')
                           constraint CC_ACCMSNAPSCN_KF_NN      NOT NULL
, FDAT        DATE         constraint CC_ACCMSNAPSCN_FDAT_NN    NOT NULL
, TABLE_NAME  VARCHAR2(30) constraint CC_ACCMSNAPSCN_TABNAME_NN NOT NULL
, SNAP_SCN    NUMBER       constraint CC_ACCMSNAPSCN_SNAPSCN_NN NOT NULL
, SNAP_DATE   DATE         
, constraint PK_ACCMSNAPSCN PRIMARY KEY ( KF, FDAT, TABLE_NAME )
) ORGANIZATION INDEX
INCLUDING SNAP_DATE
PCTTHRESHOLD 50
TABLESPACE BRSSMLD
OVERFLOW TABLESPACE BRSMDLD ]';
  
  dbms_output.put_line('table "ACCM_SNAP_SCN" created.');
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "ACCM_SNAP_SCN" already exists.' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'ACCM_SNAP_SCN' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  ACCM_SNAP_SCN            IS 'SCN-ы последних генераций снимков баланса по партициям таблиц SALDOA, SALDOA_DEL_ROWS';

COMMENT ON COLUMN ACCM_SNAP_SCN.KF         IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN ACCM_SNAP_SCN.FDAT       IS 'Дата партиции';
COMMENT ON COLUMN ACCM_SNAP_SCN.TABLE_NAME IS 'Имя таблицы';
COMMENT ON COLUMN ACCM_SNAP_SCN.SNAP_SCN   IS 'SCN последней генерации снимка баланса по данной партиции';
COMMENT ON COLUMN ACCM_SNAP_SCN.SNAP_DATE  IS 'Дата+время последней генерации снимка баланса по данной партиции';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON ACCM_SNAP_SCN TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON ACCM_SNAP_SCN TO BARS_DM;
GRANT SELECT ON ACCM_SNAP_SCN TO START1;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================

alter package BARS_UTL_SNAPSHOT compile;
alter package BARS_ACCM_SNAP   compile;
