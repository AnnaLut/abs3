-- ======================================================================================
-- Module : SNP
-- Author : BAA
-- Date   : 13.04.2018
-- ======================================================================================
-- create table AGG_MONBALS_INTR_TBL (for MMFO scheme)
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table AGG_MONBALS_INTR_TBL
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'AGG_MONBALS_INTR_TBL', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'AGG_MONBALS_INTR_TBL', 'FILIAL',  'M',  'M',  'M',  'M' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table AGG_MONBALS_INTR_TBL purge';
  dbms_output.put_line( 'Table "AGG_MONBALS_INTR_TBL" dropped.' );
exception
  when e_tab_not_exists then
    dbms_output.put_line( 'Table "AGG_MONBALS_INTR_TBL" does not exist.' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  
  execute immediate q'[create table AGG_MONBALS_INTR_TBL
( FDAT       DATE       NOT NULL
, KF         CHAR(6)    NOT NULL
, ACC        INTEGER    NOT NULL
, RNK        INTEGER    NOT NULL
, OST        NUMBER(24) NOT NULL
, OSTQ       NUMBER(24) NOT NULL
, DOS        NUMBER(24) NOT NULL
, DOSQ       NUMBER(24) NOT NULL
, KOS        NUMBER(24) NOT NULL
, KOSQ       NUMBER(24) NOT NULL
, CRDOS      NUMBER(24) default 0
, CRDOSQ     NUMBER(24) default 0
, CRKOS      NUMBER(24) default 0
, CRKOSQ     NUMBER(24) default 0
, CUDOS      NUMBER(24) default 0
, CUDOSQ     NUMBER(24) default 0
, CUKOS      NUMBER(24) default 0
, CUKOSQ     NUMBER(24) default 0
, YR_DOS     NUMBER(24) default 0
, YR_DOS_UAH NUMBER(24) default 0
, YR_KOS     NUMBER(24) default 0
, YR_KOS_UAH NUMBER(24) default 0
, CALDT_ID   NUMBER  Generated Always as (TO_NUMBER(TO_CHAR("FDAT",'j'))-2447892)
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
  dbms_output.put_line( 'Table "AGG_MONBALS_INTR_TBL" created.' );
exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "AGG_MONBALS_INTR_TBL" already exists.' );
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
  execute immediate q'[create unique index UK_AGG_MONBALS_INTR_TBL ON AGG_MONBALS_INTR_TBL ( FDAT, KF, ACC )
  TABLESPACE BRSACCM
  PCTFREE 0
  LOCAL
  COMPRESS 2 ]';
  dbms_output.put_line( 'Index "UK_AGG_MONBALS_INTR_TBL" created.' );
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
  BPA.ALTER_POLICIES( 'AGG_MONBALS_INTR_TBL' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  AGG_MONBALS_INTR_TBL            IS 'Ќакопительные балансы за мес€ц';

COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.FDAT       IS 'ƒата балансу';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.KF         IS ' од ф≥л≥алу (ћ‘ќ)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.ACC        IS '≤д. рахунка';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.RNK        IS '≤д. кл≥Їнта';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.OST        IS '¬их≥дний залишок по рахунку (ном≥нал)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.OSTQ       IS '¬их≥дний залишок по рахунку (екв≥валент)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.DOS        IS '—ума дебетових оборот≥в (ном≥нал)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.DOSQ       IS '—ума дебетових оборот≥в (екв≥валент)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.KOS        IS '—ума кредитових оборот≥в (ном≥нал)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.KOSQ       IS '—ума кредитових оборот≥в (екв≥валент)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.CRDOS      IS '—ума корегуючих дебетових  оборот≥в (ном≥нал)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.CRDOSQ     IS '—ума корегуючих дебетових  оборот≥в (екв≥валент)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.CRKOS      IS '—ума корегуючих кредитових оборот≥в (ном≥нал)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.CRKOSQ     IS '—ума корегуючих кредитових оборот≥в (екв≥валент)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.CUDOS      IS '—ума корегуючих дебетових  оборот≥в минулого м≥с€ц€ (ном≥нал)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.CUDOSQ     IS '—ума корегуючих дебетових  оборот≥в минулого м≥с€ц€ (екв≥валент)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.CUKOS      IS '—ума корегуючих кредитових оборот≥в минулого м≥с€ц€ (ном≥нал)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.CUKOSQ     IS '—ума корегуючих кредитових оборот≥в минулого м≥с€ц€ (екв≥валент)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.YR_DOS     IS '—ума р≥чних виправних ƒт. оборот≥в (номiнал)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.YR_DOS_UAH IS '—ума р≥чних виправних ƒт. оборот≥в (гривневий еквiвалент)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.YR_KOS     IS '—ума р≥чних виправних  т. оборот≥в (номiнал)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.YR_KOS_UAH IS '—ума р≥чних виправних  т. оборот≥в (гривневий еквiвалент)';
COMMENT ON COLUMN AGG_MONBALS_INTR_TBL.CALDT_ID   IS '≤д. дати балансу (дл€ сум≥сност≥ ≥з попередньою верс≥Їю)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT, ALTER ON AGG_MONBALS_INTR_TBL      TO DM;
