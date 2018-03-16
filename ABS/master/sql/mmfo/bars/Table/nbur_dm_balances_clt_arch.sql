-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 06.08.2016
-- ======================================================================================
-- create table NBUR_DM_BALANCES_CLT_ARCH
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        100
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_DM_BALANCES_CLT_ARCH
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_CLT_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_CLT_ARCH', 'FILIAL',  'M',  'M',  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_CLT_ARCH', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

begin
  execute immediate q'[
create table BARS.NBUR_DM_BALANCES_CLT_ARCH
( REPORT_DATE     DATE         CONSTRAINT CC_DMBALSCLTARCH_RPTDT_NN NOT NULL
, KF              VARCHAR2(6)  CONSTRAINT CC_DMBALSCLTARCH_KF_NN    NOT NULL
, VERSION_ID      NUMBER(3)    CONSTRAINT CC_DMBALSCLTARCH_VRSN_NN  NOT NULL
, CLT_ACC_ID      NUMBER(38)   CONSTRAINT CC_DMBALSCLTARCH_CLTACCID_NN  NOT NULL
, CLT_BAL         NUMBER(24)
, CLT_BAL_UAH     NUMBER(24)
, CLT_CUST_ID     NUMBER(38)   CONSTRAINT CC_DMBALSCLTARCH_CLTCUSTID_NN NOT NULL
, AST_ACC_ID      NUMBER(38)   CONSTRAINT CC_DMBALSCLTARCH_ASTACCID_NN  NOT NULL
, AST_BAL         NUMBER(24)
, AST_BAL_UAH     NUMBER(24)
, AST_CUST_ID     NUMBER(38)   CONSTRAINT CC_DMBALSCLTARCH_ASTCUSTID_NN NOT NULL
, TOT_AST_BAL_UAH NUMBER(24)
, TOT_CLT_BAL_UAH NUMBER(24)
, CLT_AMNT        NUMBER(24)
, CLT_AMNT_UAH    NUMBER(24)
, AST_AMNT        NUMBER(24)
, AST_AMNT_UAH    NUMBER(24)
) TABLESPACE BRSMDLD
COMPRESS BASIC 
PARALLEL 8
STORAGE( INITIAL 32K NEXT 32K )
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
  
  dbms_output.put_line('table "NBUR_DM_BALANCES_CLT_ARCH" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "NBUR_DM_BALANCES_CLT_ARCH" already exists.' );
    else raise;
    end if;  
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[CREATE UNIQUE INDEX BARS.UK_DMBALSCLTARCH ON BARS.NBUR_DM_BALANCES_CLT_ARCH ( REPORT_DATE, KF, VERSION_ID, CLT_ACC_ID, AST_ACC_ID )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL 
  COMPRESS 3 ]';
  dbms_output.put_line('index "UK_DMBALSCLTARCH" created.');
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "UK_DMBALSCLTARCH" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "REPORT_DATE", "KF", "VERSION_ID", "CLT_ACC_ID", "AST_ACC_ID" already indexed.');
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_DM_BALANCES_CLT_ARCH' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.NBUR_DM_BALANCES_CLT_ARCH                 IS 'Суми забезпечення в розрізі рахунків активу';

COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT_ARCH.REPORT_DATE     IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT_ARCH.KF              IS 'Код філіалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT_ARCH.VERSION_ID      IS 'Iдентифiкатор версії';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT_ARCH.TOT_AST_BAL_UAH IS 'загальна сума залишків (еквівалент) на рах. активу       для рах. забезпечення';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT_ARCH.TOT_CLT_BAL_UAH IS 'загальна сума залишків (еквівалент) на рах. забезпечення для рах. активу';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT_ARCH.CLT_AMNT        IS 'сума забезпечення, що покриває рах. активу (пропорційно до усіх активів, що покриваються цим забезпеченням)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT_ARCH.CLT_AMNT_UAH    IS 'сума забезпечення, що покриває рах. активу (пропорційно до усіх активів, що покриваються цим забезпеченням)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT_ARCH.AST_AMNT        IS 'сума активу, що покривається рах. забезпечення (пропорційно до усього забезпечення, що покриває цей актив)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT_ARCH.AST_AMNT_UAH    IS 'сума активу, що покривається рах. забезпечення (пропорційно до усього забезпечення, що покриває цей актив)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_DM_BALANCES_CLT_ARCH TO BARSUPL;
GRANT SELECT ON BARS.NBUR_DM_BALANCES_CLT_ARCH TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
