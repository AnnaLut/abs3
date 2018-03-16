-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 16.03.2018
-- ======================================================================================
-- create table NBUR_DM_BALANCES_YEARLY_ARCH
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_DM_BALANCES_YEARLY_ARCH
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_YEARLY_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_YEARLY_ARCH', 'FILIAL',  'M',  'M',  'E', 'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_YEARLY_ARCH', 'CENTER', NULL,  'E',  'E', 'E' );
end;
/

begin
  execute immediate q'[CREATE TABLE BARS.NBUR_DM_BALANCES_YEARLY_ARCH
( REPORT_DATE     DATE       CONSTRAINT CC_DMBALSYEARLYARCH_RPTDT_NN NOT NULL
, KF              CHAR(6)    CONSTRAINT CC_DMBALSYEARLYARCH_KF_NN       NOT NULL
, VERSION_ID      NUMBER(3)  CONSTRAINT CC_DMBALSYEARLYARCH_VERSION_NN  NOT NULL
, ACC_ID          NUMBER(38) CONSTRAINT CC_DMBALSYEARLYARCH_ACCID_NN    NOT NULL
, CUST_ID         NUMBER(38) CONSTRAINT CC_DMBALSYEARLYARCH_CUSTID      NOT NULL
, DOS             NUMBER(24)
, DOSQ            NUMBER(24)
, KOS             NUMBER(24)
, KOSQ            NUMBER(24)
, BAL             NUMBER(24) CONSTRAINT CC_DMBALSYEARLYARCH_BAL         NOT NULL
, BAL_UAH         NUMBER(24) CONSTRAINT CC_DMBALSYEARLYARCH_BALUAH      NOT NULL
, CRDOS           NUMBER(24)
, CRDOSQ          NUMBER(24)
, CRKOS           NUMBER(24)
, CRKOSQ          NUMBER(24)
, CUDOS           NUMBER(24)
, CUDOSQ          NUMBER(24)
, CUKOS           NUMBER(24)
, CUKOSQ          NUMBER(24)
, ADJ_BAL         NUMBER(24) CONSTRAINT CC_DMBALSYEARLYARCH_ADJBAL      NOT NULL
, ADJ_BAL_UAH     NUMBER(24) CONSTRAINT CC_DMBALSYEARLYARCH_ADJBALUAH   NOT NULL
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
  
  dbms_output.put_line('table "NBUR_DM_BALANCES_YEARLY_ARCH" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "NBUR_DM_BALANCES_YEARLY_ARCH" already exists.' );
    else raise;
    end if;  
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[CREATE UNIQUE INDEX BARS.UK_DMBALSYEARLYARCH ON BARS.NBUR_DM_BALANCES_YEARLY_ARCH ( REPORT_DATE, KF, VERSION_ID, ACC_ID )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL
  COMPRESS 3 ]';
  dbms_output.put_line( 'Index "BARS.UK_DMBALSYEARLYARCH" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "UK_DMBALSYEARLYARCH" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "REPORT_DATE", "KF", "VERSION_ID", "ACC_ID" already indexed.');
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_DM_BALANCES_YEARLY_ARCH' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.NBUR_DM_BALANCES_YEARLY_ARCH             IS 'Річні знімки балансу РУ на звітну дату';

COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.KF          IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.VERSION_ID  IS 'Iдентифiкатор версії';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.ACC_ID      IS 'Iдентифiкатор рахунку (ACC)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.CUST_ID     IS 'Iдентифiкатор контрагента (RNK)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.DOS         IS 'Оборот дебет, номiнал';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.KOS         IS 'Оборот кредит, номiнал';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.BAL         IS 'Вихiдний залишок (номiнал)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.BAL_UAH     IS 'Вихiдний залишок (гривневий еквiвалент)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.DOSQ        IS 'Оборот дебет, еквiвалент';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.KOSQ        IS 'Оборот кредит, еквiвалент';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.CRDOS       IS 'Коригуючі обороти дебет, номiнал';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.CRKOS       IS 'Коригуючі обороти кредит, номiнал';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.CRDOSQ      IS 'Коригуючі обороти дебет, еквiвалент';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.CRKOSQ      IS 'Коригуючі обороти кредит, еквiвалент';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.CUDOS       IS 'Коригуючі обороти попереднього перiоду дебет (номiнал)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.CUKOS       IS 'Коригуючі обороти попереднього перiоду кредит (номiнал)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.CUDOSQ      IS 'Коригуючі обороти попереднього перiоду дебет  (гривневий еквiвалент)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.CUKOSQ      IS 'Коригуючі обороти попереднього перiоду кредит (гривневий еквiвалент)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.ADJ_BAL     IS 'Вихiдний залишок з урахуванням кориг. оборотів (номінал)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_YEARLY_ARCH.ADJ_BAL_UAH IS 'Вихiдний залишок з урахуванням кориг. оборотів (гривневий еквiвалент)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_DM_BALANCES_YEARLY_ARCH TO BARSUPL;
GRANT SELECT ON BARS.NBUR_DM_BALANCES_YEARLY_ARCH TO BARS_ACCESS_DEFROLE;
