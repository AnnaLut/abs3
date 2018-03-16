-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 16.03.2018
-- ======================================================================================
-- create table NBUR_DM_BALANCES_DAILY_ARCH
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_DM_BALANCES_DAILY_ARCH
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_DAILY_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_DAILY_ARCH', 'FILIAL',  'M',  'M',  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_DAILY_ARCH', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

begin
  execute immediate q'[CREATE TABLE BARS.NBUR_DM_BALANCES_DAILY_ARCH
( REPORT_DATE     DATE       CONSTRAINT CC_DMBALSDAILYARCH_REPORTDT_NN NOT NULL
, KF              CHAR(6)    CONSTRAINT CC_DMBALSDAILYARCH_KF_NN       NOT NULL
, VERSION_ID      NUMBER(3)  CONSTRAINT CC_DMBALSDAILYARCH_VERSION_NN  NOT NULL
, ACC_ID          NUMBER(38) CONSTRAINT CC_DMBALSDAILYARCH_ACCID_NN    NOT NULL
, CUST_ID         NUMBER(38) CONSTRAINT CC_DMBALSDAILYARCH_CUSTID      NOT NULL
, VOST            NUMBER(24)
, DOS             NUMBER(24)
, KOS             NUMBER(24)
, OST             NUMBER(24)
, VOSTQ           NUMBER(24)
, DOSQ            NUMBER(24)
, KOSQ            NUMBER(24)
, OSTQ            NUMBER(24)
) TABLESPACE BRSBIGD
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
( PARTITION P_MINVALUE VALUES LESS THAN ( TO_DATE('01/01/2016','DD/MM/YYYY') ) )]';
  
  dbms_output.put_line('table "NBUR_DM_BALANCES_DAILY_ARCH" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "NBUR_DM_BALANCES_DAILY_ARCH" already exists.' );
    else raise;
    end if;  
end;
/

prompt -- ======================================================
prompt -- Create index
prompt -- ======================================================

begin
  execute immediate q'[CREATE UNIQUE INDEX BARS.UK_DMBALSDAILYARCH ON BARS.NBUR_DM_BALANCES_DAILY_ARCH ( REPORT_DATE, KF, VERSION_ID, ACC_ID )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL
  COMPRESS 3 ]';
  dbms_output.put_line( 'Index "BARS.UK_DMBALSDAILYARCH" created.' );
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line( 'Index "BARS.UK_DMBALSDAILYARCH" already exists.' );
    else raise;
    end if;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_DM_BALANCES_DAILY_ARCH' );
end;
/

commit;

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

COMMENT ON TABLE  NBUR_DM_BALANCES_DAILY_ARCH             IS 'Щоденні знімки балансу РУ на звітну дату  (архів версій)';

COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.KF          IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.VERSION_ID  IS 'Iдентифiкатор версії';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.ACC_ID      IS 'Iдентифiкатор рахунку (ACC)';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.CUST_ID     IS 'Iдентифiкатор контрагента (RNK)';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.VOST        IS 'V - типу Vхідний, OST - типу "остаток"';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.DOS         IS 'Сума Дт. оборотів';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.KOS         IS 'Сума Кт. оборотів';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.OST         IS 'Залишок (вихідний)';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.VOSTQ       IS 'див. VOST, але в еQвіваленті';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.DOSQ        IS 'див.  DOS, але в еQвіваленті';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.KOSQ        IS 'див.  KOS, але в еQвіваленті';
COMMENT ON COLUMN NBUR_DM_BALANCES_DAILY_ARCH.OSTQ        IS 'див.  OST, але в еQвіваленті';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT on NBUR_DM_BALANCES_DAILY_ARCH to BARSUPL;
GRANT SELECT on NBUR_DM_BALANCES_DAILY_ARCH to BARS_ACCESS_DEFROLE;
