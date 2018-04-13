-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 01.06.2016
-- ======================================================================================
-- create table NBUR_DM_BALANCES_MONTHLY_ARCH
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_DM_BALANCES_MONTHLY_ARCH
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_MONTHLY_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_MONTHLY_ARCH', 'FILIAL',  'M',  'M',  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_MONTHLY_ARCH', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_DM_BALANCES_MONTHLY_ARCH
( REPORT_DATE     DATE       CONSTRAINT CC_DMBALSMONTHARCH_REPORTDT_NN NOT NULL
, KF              CHAR(6)    CONSTRAINT CC_DMBALSMONTHARCH_KF_NN       NOT NULL
, VERSION_ID      NUMBER(38) CONSTRAINT CC_DMBALSMONTHARCH_VERSION_NN  NOT NULL
, ACC_ID          NUMBER(38) CONSTRAINT CC_DMBALSMONTHARCH_ACCID_NN    NOT NULL
, CUST_ID         NUMBER(38) CONSTRAINT CC_DMBALSMONTHARCH_CUSTID      NOT NULL
, DOS             NUMBER(24)
, KOS             NUMBER(24)
, OST             NUMBER(24)
, DOSQ            NUMBER(24)
, KOSQ            NUMBER(24)
, OSTQ            NUMBER(24)
, CRDOS           NUMBER(24)
, CRKOS           NUMBER(24)
, CRDOSQ          NUMBER(24)
, CRKOSQ          NUMBER(24)
, CUDOS           NUMBER(24)
, CUKOS           NUMBER(24)
, CUDOSQ          NUMBER(24)
, CUKOSQ          NUMBER(24)
, YR_DOS          NUMBER(24) default 0
, YR_DOS_UAH      NUMBER(24) default 0
, YR_KOS          NUMBER(24) default 0
, YR_KOS_UAH      NUMBER(24) default 0
, ADJ_BAL         NUMBER(24) CONSTRAINT CC_DMBALSMONTHARCH_ADJBAL      NOT NULL
, ADJ_BAL_UAH     NUMBER(24) CONSTRAINT CC_DMBALSMONTHARCH_ADJBALUAH   NOT NULL
) TABLESPACE BRSBIGD
COMPRESS BASIC 
PARALLEL 8
STORAGE( INITIAL 128K NEXT 128K )
PCTUSED   0
PCTFREE   0
PARTITION BY RANGE (REPORT_DATE) INTERVAL( NUMTODSINTERVAL(1,'DAY') )
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
, SUBPARTITION SP_356334 VALUES ('356334') )
( PARTITION P_MINVALUE VALUES LESS THAN ( TO_DATE('01/01/2016','DD/MM/YYYY') ) )]';

  dbms_output.put_line('table "NBUR_DM_BALANCES_MONTHLY_ARCH" created.');

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_DM_BALANCES_MONTHLY_ARCH" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table NBUR_DM_BALANCES_MONTHLY_ARCH add YR_DOS number(24)]';
  -- When adding a column on compressed tables, do not specify a default value.
  execute immediate q'[alter table NBUR_DM_BALANCES_MONTHLY_ARCH modify YR_DOS default 0 ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table NBUR_DM_BALANCES_MONTHLY_ARCH add YR_DOS_UAH number(24)]';
  execute immediate q'[alter table NBUR_DM_BALANCES_MONTHLY_ARCH modify YR_DOS_UAH default 0 ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table NBUR_DM_BALANCES_MONTHLY_ARCH add YR_KOS number(24)]';
  execute immediate q'[alter table NBUR_DM_BALANCES_MONTHLY_ARCH modify YR_KOS default 0 ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table NBUR_DM_BALANCES_MONTHLY_ARCH add YR_KOS_UAH number(24)]';
  execute immediate q'[alter table NBUR_DM_BALANCES_MONTHLY_ARCH modify YR_KOS_UAH default 0 ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[CREATE UNIQUE INDEX BARS.UK_DMBALSMONTHARCH ON BARS.NBUR_DM_BALANCES_MONTHLY_ARCH ( REPORT_DATE, KF, VERSION_ID, ACC_ID )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL
  COMPRESS 3 ]';
  dbms_output.put_line( 'Index "BARS.UK_DMBALSMONTHARCH" created.' );
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line( 'Index "BARS.UK_DMBALSMONTHARCH" already exists.' );
    else raise;
    end if;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_DM_BALANCES_MONTHLY_ARCH' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  NBUR_DM_BALANCES_MONTHLY_ARCH             IS 'Щомісячні знімки балансу РУ на звітну дату  (архів версій)';

COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.KF          IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.VERSION_ID  IS 'Iдентифiкатор версії';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.ACC_ID      IS 'Iдентифiкатор рахунку (ACC)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.CUST_ID     IS 'Iдентифiкатор контрагента (RNK)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.DOS         IS 'Оборот дебет, номiнал';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.KOS         IS 'Оборот кредит, номiнал';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.OST         IS 'Вихiдний залишок, номiнал';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.DOSQ        IS 'Оборот дебет, еквiвалент';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.KOSQ        IS 'Оборот кредит, еквiвалент';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.OSTQ        IS 'Вихiдний залишок, еквiвалент';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.CRDOS       IS 'Коригуючі обороти дебет, номiнал';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.CRKOS       IS 'Коригуючі обороти кредит, номiнал';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.CRDOSQ      IS 'Коригуючі обороти дебет, еквiвалент';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.CRKOSQ      IS 'Коригуючі обороти кредит, еквiвалент';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.CUDOS       IS 'Коригуючі обороти попереднього перiоду дебет (номiнал)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.CUKOS       IS 'Коригуючі обороти попереднього перiоду кредит (номiнал)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.CUDOSQ      IS 'Коригуючі обороти попереднього перiоду дебет  (гривневий еквiвалент)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.CUKOSQ      IS 'Коригуючі обороти попереднього перiоду кредит (гривневий еквiвалент)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.YR_DOS      IS 'YR_ADJ_AMNT_DB     - Сума Дт. річних коригуючих оборотів (номiнал)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.YR_DOS_UAH  IS 'YR_ADJ_AMNT_DB_UAH - Сума Дт. річних коригуючих оборотів (гривневий еквiвалент)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.YR_KOS      IS 'YR_ADJ_AMNT_CR     - Сума Кт. річних коригуючих оборотів (номiнал)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.YR_KOS_UAH  IS 'YR_ADJ_AMNT_CR_UAH - Сума Кт. річних коригуючих оборотів (гривневий еквiвалент)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.ADJ_BAL     IS 'Вихiдний залишок з урахуванням кориг. оборотів (номінал)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY_ARCH.ADJ_BAL_UAH IS 'Вихiдний залишок з урахуванням кориг. оборотів (гривневий еквiвалент)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_DM_BALANCES_MONTHLY_ARCH to BARSUPL;
grant SELECT on NBUR_DM_BALANCES_MONTHLY_ARCH to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_DM_BALANCES_MONTHLY_ARCH to BARSREADER_ROLE;
