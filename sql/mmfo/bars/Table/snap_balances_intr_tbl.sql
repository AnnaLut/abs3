-- ======================================================================================
-- Module : SNP
-- Author : BAA
-- Date   : 18.05.2016
-- ======================================================================================
-- create table SNAP_BALANCES_INTR_TBL (for MMFO scheme)
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table SNAP_BALANCES_INTR_TBL
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'SNAP_BALANCES_INTR_TBL', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'SNAP_BALANCES_INTR_TBL', 'FILIAL',  'M',  'M',  'M',  'M' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table SNAP_BALANCES_INTR_TBL
( FDAT       DATE        constraint CC_SNAPBALANCESINTRTBL_FDAT_NN NOT NULL
, KF         VARCHAR2(6) constraint CC_SNAPBALANCESINTRTBL_KF_NN   NOT NULL
, ACC        INTEGER     constraint CC_SNAPBALANCESINTRTBL_ACC_NN  NOT NULL
, RNK        INTEGER     constraint CC_SNAPBALANCESINTRTBL_RNK_NN  NOT NULL
, OST        NUMBER(24)  constraint CC_SNAPBALANCESINTRTBL_OST_NN  NOT NULL
, DOS        NUMBER(24)  constraint CC_SNAPBALANCESINTRTBL_DOS_NN  NOT NULL
, KOS        NUMBER(24)  constraint CC_SNAPBALANCESINTRTBL_KOS_NN  NOT NULL
, OSTQ       NUMBER(24)  constraint CC_SNAPBALANCESINTRTBL_OSTQ_NN NOT NULL
, DOSQ       NUMBER(24)  constraint CC_SNAPBALANCESINTRTBL_DOSQ_NN NOT NULL
, KOSQ       NUMBER(24)  constraint CC_SNAPBALANCESINTRTBL_KOSQ_NN NOT NULL
) TABLESPACE BRSACCM
COMPRESS BASIC
PARALLEL 26
STORAGE( INITIAL 128K NEXT 128K )
PCTUSED  0
PCTFREE  0
PARTITION BY LIST (KF)
( PARTITION P_300465 VALUES ('300465')
, PARTITION P_302076 VALUES ('302076')
, PARTITION P_303398 VALUES ('303398')
, PARTITION P_304665 VALUES ('304665')
, PARTITION P_305482 VALUES ('305482')
, PARTITION P_311647 VALUES ('311647')
, PARTITION P_312356 VALUES ('312356')
, PARTITION P_313957 VALUES ('313957')
, PARTITION P_315784 VALUES ('315784')
, PARTITION P_322669 VALUES ('322669')
, PARTITION P_323475 VALUES ('323475')
, PARTITION P_324805 VALUES ('324805')
, PARTITION P_325796 VALUES ('325796')
, PARTITION P_326461 VALUES ('326461')
, PARTITION P_328845 VALUES ('328845')
, PARTITION P_331467 VALUES ('331467')
, PARTITION P_333368 VALUES ('333368')
, PARTITION P_335106 VALUES ('335106')
, PARTITION P_336503 VALUES ('336503')
, PARTITION P_337568 VALUES ('337568')
, PARTITION P_338545 VALUES ('338545')
, PARTITION P_351823 VALUES ('351823')
, PARTITION P_352457 VALUES ('352457')
, PARTITION P_353553 VALUES ('353553')
, PARTITION P_354507 VALUES ('354507')
, PARTITION P_356334 VALUES ('356334')
) ]';
  dbms_output.put_line( 'Table "SNAP_BALANCES_INTR_TBL" created.' );
exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "SNAP_BALANCES_INTR_TBL" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate q'[create unique index UK_SNAP_BALANCES_INTR_TBL ON SNAP_BALANCES_INTR_TBL ( FDAT, KF, ACC )
  TABLESPACE BRSACCM
  PCTFREE 0 
  LOCAL
  COMPRESS 2 ]';
  dbms_output.put_line( 'Index "UK_SNAP_BALANCES_INTR_TBL" created.' );
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
  bars.bpa.alter_policies( 'SNAP_BALANCES_INTR_TBL' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  SNAP_BALANCES_INTR_TBL          IS 'Знімок балансу за день';

COMMENT ON COLUMN SNAP_BALANCES_INTR_TBL.FDAT     IS 'Дата балансу';
COMMENT ON COLUMN SNAP_BALANCES_INTR_TBL.KF       IS 'Код філіалу (МФО)';
COMMENT ON COLUMN SNAP_BALANCES_INTR_TBL.ACC      IS 'Ід. рахунка';
COMMENT ON COLUMN SNAP_BALANCES_INTR_TBL.RNK      IS 'Ід. клієнта';
COMMENT ON COLUMN SNAP_BALANCES_INTR_TBL.OST      IS 'Вихідний залишок по рахунку (номінал)';
COMMENT ON COLUMN SNAP_BALANCES_INTR_TBL.OSTQ     IS 'Вихідний залишок по рахунку (еквівалент)';
COMMENT ON COLUMN SNAP_BALANCES_INTR_TBL.DOS      IS 'Сума дебетових оборотів (номінал)';
COMMENT ON COLUMN SNAP_BALANCES_INTR_TBL.DOSQ     IS 'Сума дебетових оборотів (еквівалент)';
COMMENT ON COLUMN SNAP_BALANCES_INTR_TBL.KOS      IS 'Сума кредитових оборотів (номінал)';
COMMENT ON COLUMN SNAP_BALANCES_INTR_TBL.KOSQ     IS 'Сума кредитових оборотів (еквівалент)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT, ALTER ON SNAP_BALANCES_INTR_TBL TO DM;
