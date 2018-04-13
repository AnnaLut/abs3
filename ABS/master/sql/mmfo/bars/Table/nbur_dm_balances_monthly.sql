-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 01.06.2016
-- ======================================================================================
-- create table NBUR_DM_BALANCES_MONTHLY
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_DM_BALANCES_MONTHLY
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_MONTHLY', 'WHOLE' , NULL, NULL, NULL, NULL );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  EXECUTE IMMEDIATE 'drop table NBUR_DM_BALANCES_MONTHLY PURGE';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists 
  then null;
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_DM_BALANCES_MONTHLY
( REPORT_DATE     DATE       CONSTRAINT CC_DMBALANCESMONTH_REPORTDT_NN NOT NULL
, KF              CHAR(6)    CONSTRAINT CC_DMBALANCESMONTH_KF_NN       NOT NULL
, ACC_ID          NUMBER(38) CONSTRAINT CC_DMBALANCESMONTH_ACCID_NN    NOT NULL
, CUST_ID         NUMBER(38) CONSTRAINT CC_DMBALANCESMONTH_CUSTID      NOT NULL
, DOS             NUMBER(24) CONSTRAINT CC_DMBALANCESMONTH_DOS         NOT NULL
, KOS             NUMBER(24) CONSTRAINT CC_DMBALANCESMONTH_KOS         NOT NULL
, OST             NUMBER(24) CONSTRAINT CC_DMBALANCESMONTH_OST         NOT NULL
, DOSQ            NUMBER(24) CONSTRAINT CC_DMBALANCESMONTH_DOSQ        NOT NULL
, KOSQ            NUMBER(24) CONSTRAINT CC_DMBALANCESMONTH_KOSQ        NOT NULL
, OSTQ            NUMBER(24) CONSTRAINT CC_DMBALANCESMONTH_OSTQ        NOT NULL
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
, ADJ_BAL         NUMBER(24) constraint CC_DMBALANCESMONTH_ADJBAL      NOT NULL
, ADJ_BAL_UAH     NUMBER(24) constraint CC_DMBALANCESMONTH_ADJBALUAH   NOT NULL
) TABLESPACE BRSBIGD
PARALLEL 8
NOLOGGING
STORAGE( INITIAL 128K NEXT 128K )
PCTUSED   0
PCTFREE   0
PARTITION BY LIST ( KF )
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
, PARTITION P_356334 VALUES ('356334') )]';

  dbms_output.put_line('table "NBUR_DM_BALANCES_MONTHLY" created.');

exception
  when e_tab_exists
  then
    dbms_output.put_line( 'Table "NBUR_DM_BALANCES_MONTHLY" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexex
prompt -- ======================================================

begin
  execute immediate q'[CREATE UNIQUE INDEX BARS.UK_DMBALANCESMONTH ON BARS.NBUR_DM_BALANCES_MONTHLY ( KF, ACC_ID )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "BARS.UK_DMBALANCESMONTH" created.' );
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line( 'Index "BARS.UK_DMBALANCESMONTH" already exists.' );
    else raise;
    end if;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  NBUR_DM_BALANCES_MONTHLY             IS 'Щомісячні знімки балансу РУ на звітну дату';

COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.KF          IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.ACC_ID      IS 'Iдентифiкатор рахунку';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.CUST_ID     IS 'Iдентифiкатор контрагента';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.DOS         IS 'Оборот дебет, номiнал';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.KOS         IS 'Оборот кредит, номiнал';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.OST         IS 'Вихiдний залишок, номiнал';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.DOSQ        IS 'Оборот дебет, еквiвалент';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.KOSQ        IS 'Оборот кредит, еквiвалент';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.OSTQ        IS 'Вихiдний залишок, еквiвалент';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.CRDOS       IS 'Коригуючі обороти дебет, номiнал';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.CRKOS       IS 'Коригуючі обороти кредит, номiнал';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.CRDOSQ      IS 'Коригуючі обороти дебет, еквiвалент';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.CRKOSQ      IS 'Коригуючі обороти кредит, еквiвалент';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.CUDOS       IS 'Коригуючі обороти попереднього перiоду дебет  (номiнал)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.CUKOS       IS 'Коригуючі обороти попереднього перiоду кредит (номiнал)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.CUDOSQ      IS 'Коригуючі обороти попереднього перiоду дебет  (гривневий еквiвалент)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.CUKOSQ      IS 'Коригуючі обороти попереднього перiоду кредит (гривневий еквiвалент)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.YR_DOS      IS 'YR_ADJ_AMNT_DB     - Сума Дт. річних коригуючих оборотів (номiнал)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.YR_DOS_UAH  IS 'YR_ADJ_AMNT_DB_UAH - Сума Дт. річних коригуючих оборотів (гривневий еквiвалент)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.YR_KOS      IS 'YR_ADJ_AMNT_CR     - Сума Кт. річних коригуючих оборотів (номiнал)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.YR_KOS_UAH  IS 'YR_ADJ_AMNT_CR_UAH - Сума Кт. річних коригуючих оборотів (гривневий еквiвалент)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.ADJ_BAL     IS 'Вихiдний залишок з урахуванням кориг. оборотів (номінал)';
COMMENT ON COLUMN NBUR_DM_BALANCES_MONTHLY.ADJ_BAL_UAH IS 'Вихiдний залишок з урахуванням кориг. оборотів (гривневий еквiвалент)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_DM_BALANCES_MONTHLY to BARSREADER_ROLE;
