-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 13.07.2016
-- ======================================================================================
-- create table NBUR_DM_AGREEMENTS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        100
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_DM_AGREEMENTS
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'NBUR_DM_AGREEMENTS', 'WHOLE' , NULL, NULL, NULL, NULL );
end;
/

begin
  execute immediate 'drop table BARS.NBUR_DM_AGREEMENTS PURGE';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if ( sqlcode = -00942 )
    then dbms_output.put_line( 'Table "NBUR_DM_AGREEMENTS" does not exist.' );
    else raise;
    end if;
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_DM_AGREEMENTS
( REPORT_DATE     DATE       CONSTRAINT CC_DMAGREEMENTS_REPORTDT_NN  NOT NULL
, KF              CHAR(6)    CONSTRAINT CC_DMAGREEMENTS_KF_NN        NOT NULL
, PRTFL_TP        CHAR(3)    CONSTRAINT CC_DMAGREEMENTS_PRTFLTP_NN   NOT NULL
, AGRM_ID         NUMBER(38) CONSTRAINT CC_DMAGREEMENTS_AGRMID_NN    NOT NULL
, AGRM_NUM        VARCHAR2(50)
, AGRM_TP         NUMBER(38) CONSTRAINT CC_DMAGREEMENTS_AGRMTP_NN    NOT NULL
, AGRM_STE        NUMBER(2)  CONSTRAINT CC_DMAGREEMENTS_AGRMSTE_NN   NOT NULL
, BEG_DT          DATE       CONSTRAINT CC_DMAGREEMENTS_BEGDT_NN     NOT NULL
, END_DT          DATE
, INL_AMNT        NUMBER(24) CONSTRAINT CC_DMAGREEMENTS_INLAMNT_NN   NOT NULL
, CRN_AMNT        NUMBER(24) CONSTRAINT CC_DMAGREEMENTS_CRNAMNT_NN   NOT NULL
, DBT_FRQ_TP      NUMBER(3)  CONSTRAINT CC_DMAGREEMENTS_DBTFRQTP_NN  NOT NULL
, DBT_INL_DT      DATE
, DBT_MAT_DAY     NUMBER(2)
, INT_FRQ_TP      NUMBER(3)  CONSTRAINT CC_DMAGREEMENTS_INTFRQTP_NN  NOT NULL
, INT_INL_DT      DATE
, INT_MAT_DAY     NUMBER(2)
, CCY_ID          NUMBER(3)  CONSTRAINT CC_DMAGREEMENTS_CCYID_NN     NOT NULL
, CUST_ID         NUMBER(38) CONSTRAINT CC_DMAGREEMENTS_CUSTID_NN    NOT NULL
) TABLESPACE BRSMDLD
COMPRESS BASIC 
PARALLEL 8
NOLOGGING
STORAGE( INITIAL 128K NEXT 128K )
PCTUSED   0
PCTFREE   0
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
, PARTITION P_356334 VALUES ('356334') ) ]';

  dbms_output.put_line('Table "NBUR_DM_AGREEMENTS" created.');

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_DM_AGREEMENTS" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create unique index UK_DMAGREEMENTS on NBUR_DM_AGREEMENTS ( KF, PRTFL_TP, AGRM_ID )
  TABLESPACE BRSMDLI
  PCTFREE 0 
  LOCAL 
  COMPRESS 1 ]';
  dbms_output.put_line('Index "UK_DMAGREEMENTS" created.');
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "UK_DMAGREEMENTS" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "KF", "PRTFL_TP", "AGRM_ID" already indexed.');
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_DM_AGREEMENTS' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.NBUR_DM_AGREEMENTS             IS 'Зв`язок рахунків та договорів';

COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.KF          IS 'Код філіалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.PRTFL_TP    IS 'Тип портфеля договорів';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.AGRM_ID     IS 'Ідентифікатор договору';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.AGRM_NUM    IS 'Номер договору';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.AGRM_TP     IS 'Вид договору (CC_VIDD.VIDD)';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.AGRM_STE    IS 'Стан договору (CC_SOS.SOS)';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.BEG_DT      IS 'Дата початку';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.END_DT      IS 'Дата закінчення';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.INL_AMNT    IS 'Початкова сума по договору';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.CRN_AMNT    IS 'Поточна сума по договору';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.DBT_FRQ_TP  IS 'Періодичність погашення основного боргу';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.DBT_INL_DT  IS 'Дата початку погашення основного боргу';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.DBT_MAT_DAY IS 'День погашення основного боргу';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.INT_FRQ_TP  IS 'Періодичність погашення відсотків';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.INT_INL_DT  IS 'Дата початку погашення відсотків ';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.INT_MAT_DAY IS 'День погашення відсотків';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.CCY_ID      IS 'Валюта рахунку';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS.CUST_ID     IS 'Iдентифiкатор контрагента';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_DM_AGREEMENTS TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
