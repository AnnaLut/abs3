-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 25.07.2016
-- ======================================================================================
-- create table NBUR_DM_AGREEMENTS_ARCH
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
prompt -- create table NBUR_DM_AGREEMENTS_ARCH
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'NBUR_DM_AGREEMENTS_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  bars.bpa.alter_policy_info( 'NBUR_DM_AGREEMENTS_ARCH', 'FILIAL', 'M',  'M',  'E',  'E' );
  bars.bpa.alter_policy_info( 'NBUR_DM_AGREEMENTS_ARCH', 'CENTER', NULL, 'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_DM_AGREEMENTS_ARCH
( REPORT_DATE     DATE       constraint CC_DMAGRMSARCH_RPTDT_NN     NOT NULL
, KF              CHAR(6)    constraint CC_DMAGRMSARCH_KF_NN        NOT NULL
, VERSION_ID      NUMBER(3)  constraint CC_DMAGRMSARCH_VRSN_NN      NOT NULL
, PRTFL_TP        CHAR(3)    constraint CC_DMAGRMSARCH_PRTFLTP_NN   NOT NULL
, AGRM_ID         NUMBER(38) constraint CC_DMAGRMSARCH_AGRMID_NN    NOT NULL
, AGRM_NUM        VARCHAR2(50)
, AGRM_TP         NUMBER(38) constraint CC_DMAGRMSARCH_AGRMTP_NN    NOT NULL
, AGRM_STE        NUMBER(2)  constraint CC_DMAGRMSARCH_AGRMSTE_NN   NOT NULL
, BEG_DT          DATE       constraint CC_DMAGRMSARCH_BEGDT_NN     NOT NULL
, END_DT          DATE
, INL_AMNT        NUMBER(24) constraint CC_DMAGRMSARCH_INLAMNT_NN   NOT NULL
, CRN_AMNT        NUMBER(24) constraint CC_DMAGRMSARCH_CRNAMNT_NN   NOT NULL
, DBT_FRQ_TP      NUMBER(3)  constraint CC_DMAGRMSARCH_DBTFRQTP_NN  NOT NULL
, DBT_INL_DT      DATE
, DBT_MAT_DAY     NUMBER(2)
, INT_FRQ_TP      NUMBER(3)  constraint CC_DMAGRMSARCH_INTFRQTP_NN  NOT NULL
, INT_INL_DT      DATE
, INT_MAT_DAY     NUMBER(2)
, CCY_ID          NUMBER(3)  constraint CC_DMAGRMSARCH_CCYID_NN     NOT NULL
, CUST_ID         NUMBER(38) constraint CC_DMAGRMSARCH_CUSTID_NN    NOT NULL
) TABLESPACE BRSMDLD
COMPRESS BASIC 
PARALLEL
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
( PARTITION  P_MINVALUE VALUES LESS THAN ( TO_DATE('01/01/2016','DD/MM/YYYY') ) )]';

  dbms_output.put_line( 'Table "NBUR_DM_AGREEMENTS_ARCH" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_DM_AGREEMENTS_ARCH" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

begin
  NBUR_UTIL.SET_COL( 'NBUR_DM_AGREEMENTS_ARCH', 'CUST_ID', 'NUMBER(38)' );
--execute immediate q'[alter table NBUR_DM_AGREEMENTS_ARCH add constraint CC_DMAGRMSARCH_CUSTID_NN Not Null novalidate]';
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

declare
  E_IDX_NOT_EXISTS       exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index UK_DMAGRMSARCH';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXISTS
  then null;
end;
/

begin
  execute immediate q'[create unique index UK_DMAGRMSARCH ON BARS.NBUR_DM_AGREEMENTS_ARCH ( REPORT_DATE, KF, VERSION_ID, PRTFL_TP, AGRM_ID )
  TABLESPACE BRSMDLI
  PCTFREE 0 
  LOCAL 
  COMPRESS 4 ]';
  dbms_output.put_line( 'Index "UK_DMAGRMSARCH" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "UK_DMAGRMSARCH" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column(s) "REPORT_DATE", "KF", "VERSION_ID", "PRTFL_TP", "AGRM_ID" already indexed.' );
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_DM_AGREEMENTS_ARCH' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  NBUR_DM_AGREEMENTS_ARCH             IS 'Зв`язок рахунків та договорів';

COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.KF          IS 'Код філіалу (МФО)';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.VERSION_ID  IS 'Iдентифiкатор версії';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.PRTFL_TP    IS 'Тип портфеля договорів';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.AGRM_ID     IS 'Ідентифікатор договору';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.AGRM_NUM    IS 'Номер договору';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.AGRM_TP     IS 'Вид договору (CC_VIDD.VIDD)';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.AGRM_STE    IS 'Стан договору (CC_SOS.SOS)';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.BEG_DT      IS 'Дата початку';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.END_DT      IS 'Дата закінчення';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.INL_AMNT    IS 'Початкова сума по договору';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.CRN_AMNT    IS 'Поточна сума по договору';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.DBT_FRQ_TP  IS 'Періодичність погашення основного боргу';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.DBT_INL_DT  IS 'Дата початку погашення основного боргу';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.DBT_MAT_DAY IS 'День погашення основного боргу';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.INT_FRQ_TP  IS 'Періодичність погашення відсотків';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.INT_INL_DT  IS 'Дата початку погашення відсотків ';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.INT_MAT_DAY IS 'День погашення відсотків';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.CCY_ID      IS 'Валюта рахунку';
COMMENT ON COLUMN NBUR_DM_AGREEMENTS_ARCH.CUST_ID     IS 'Iдентифiкатор контрагента';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON NBUR_DM_AGREEMENTS_ARCH TO BARSUPL;
GRANT SELECT ON NBUR_DM_AGREEMENTS_ARCH TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
