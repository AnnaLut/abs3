-- ======================================================================================
-- Module : DPT
-- Author : BAA
-- Date   : 05.05.2018
-- ======================================================================================
-- create table OPER_EXT
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table OPER_EXT
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'OPER_EXT', 'CENTER', null, 'E', 'E', 'E' );
  BPA.ALTER_POLICY_INFO( 'OPER_EXT', 'FILIAL',  'M', 'M', 'M', 'M' );
  BPA.ALTER_POLICY_INFO( 'OPER_EXT', 'WHOLE',  null, 'E', 'E', 'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table OPER_EXT
( KF            VARCHAR2(30) DEFAULT sys_context('bars_context','user_mfo')
                             constraint CC_OPEREXT_KF_NN          NOT NULL
, REF           NUMBER(38)   constraint CC_OPEREXT_REF_NN         NOT NULL
, PAY_BANKDATE  DATE         constraint CC_OPEREXT_PAYBANKDATE_NN NOT NULL
, PAY_CALDATE   DATE         constraint CC_OPEREXT_PAYCALDATE_NN  NOT NULL
, constraint PK_OPEREXT primary key (REF) using index tablespace BRSMDLI
) tablespace BRSMDLD
STORAGE( INITIAL 32K NEXT 32K )
PARTITION BY RANGE (PAY_BANKDATE) INTERVAL( NUMTOYMINTERVAL(1,'MONTH'))
SUBPARTITION BY LIST (KF)
SUBPARTITION TEMPLATE
( SUBPARTITION SP_300465 VALUES ('300465')
, SUBPARTITION SP_302076 VALUES ('302076')
, SUBPARTITION SP_303398 VALUES ('303398')
, SUBPARTITION SP_304665 VALUES ('304665')
, SUBPARTITION SP_305482 VALUES ('305482')
, SUBPARTITION SP_311647 VALUES ('311647')
, SUBPARTITION SP_312356 VALUES ('312356')
, SUBPARTITION SP_313957 VALUES ('313957')
, SUBPARTITION SP_315784 VALUES ('315784')
, SUBPARTITION SP_322669 VALUES ('322669')
, SUBPARTITION SP_323475 VALUES ('323475')
, SUBPARTITION SP_324805 VALUES ('324805')
, SUBPARTITION SP_325796 VALUES ('325796')
, SUBPARTITION SP_326461 VALUES ('326461')
, SUBPARTITION SP_328845 VALUES ('328845')
, SUBPARTITION SP_331467 VALUES ('331467')
, SUBPARTITION SP_333368 VALUES ('333368')
, SUBPARTITION SP_335106 VALUES ('335106')
, SUBPARTITION SP_336503 VALUES ('336503')
, SUBPARTITION SP_337568 VALUES ('337568')
, SUBPARTITION SP_338545 VALUES ('338545')
, SUBPARTITION SP_351823 VALUES ('351823')
, SUBPARTITION SP_352457 VALUES ('352457')
, SUBPARTITION SP_353553 VALUES ('353553')
, SUBPARTITION SP_354507 VALUES ('354507')
, SUBPARTITION SP_356334 VALUES ('356334')
)
( PARTITION OPEREXT_MINVALUE VALUES LESS THAN (TO_DATE(' 2015-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2015_Q1 VALUES LESS THAN (TO_DATE(' 2015-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2015_Q2 VALUES LESS THAN (TO_DATE(' 2015-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2015_Q3 VALUES LESS THAN (TO_DATE(' 2015-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2015_Q4 VALUES LESS THAN (TO_DATE(' 2016-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2016_Q1 VALUES LESS THAN (TO_DATE(' 2016-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2016_Q2 VALUES LESS THAN (TO_DATE(' 2016-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2016_Q3 VALUES LESS THAN (TO_DATE(' 2016-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2016_Q4 VALUES LESS THAN (TO_DATE(' 2017-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2017_Q1 VALUES LESS THAN (TO_DATE(' 2017-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2017_Q2 VALUES LESS THAN (TO_DATE(' 2017-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2017_Q3 VALUES LESS THAN (TO_DATE(' 2017-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2017_Q4 VALUES LESS THAN (TO_DATE(' 2018-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION OPEREXT_Y2018_Q1 VALUES LESS THAN (TO_DATE(' 2018-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
)]';

  dbms_output.put_line( 'Table created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "OPER_EXT" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

-- create index IDX_OPEREXT_BANKDATE on OPER_EXT (PAY_BANKDATE) tablespace BRSMDLI;

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_OPEREXT_CALDATE on OPER_EXT ( trunc(PAY_CALDATE) ) tablespace BRSMDLI';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'OPER_EXT' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  OPER_EXT              IS 'Документи оплечені у вихідні дні';

COMMENT ON COLUMN OPER_EXT.KF           IS 'Код філіалу (МФО)';
COMMENT ON COLUMN OPER_EXT.REF          IS 'Реф. документу';
COMMENT ON COLUMN OPER_EXT.PAY_BANKDATE IS 'Банківська дата оплати документу';
COMMENT ON COLUMN OPER_EXT.PAY_CALDATE  IS 'Календарна дата оплати документу';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON OPER_EXT TO BARSREADER_ROLE;
GRANT SELECT ON OPER_EXT TO UPLD;
GRANT SELECT ON OPER_EXT TO BARS_ACCESS_DEFROLE;
