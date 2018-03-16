-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 16.03.2018
-- ======================================================================================
-- create table NBUR_DETAIL_PROTOCOLS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_DETAIL_PROTOCOLS
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DETAIL_PROTOCOLS_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DETAIL_PROTOCOLS_ARCH', 'FILIAL',  'M',  'M',  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DETAIL_PROTOCOLS_ARCH', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

begin
  execute immediate q'[create table NBUR_DETAIL_PROTOCOLS_ARCH
( REPORT_DATE     DATE              CONSTRAINT CC_DTLPROTOCOLARCH_REPORTDT_NN  NOT NULL
, KF              CHAR(6)           CONSTRAINT CC_DTLPROTOCOLARCH_KF_NN        NOT NULL
, VERSION_ID      NUMBER(3)         CONSTRAINT CC_DTLPROTOCOLARCH_VERSION_NN   NOT NULL
, REPORT_CODE     CHAR(3)           CONSTRAINT CC_DTLPROTOCOLARCH_REPORTCD_NN  NOT NULL
, NBUC            VARCHAR2(20)      CONSTRAINT CC_DTLPROTOCOLARCH_NBUC_NN      NOT NULL
, FIELD_CODE      VARCHAR2(35)      CONSTRAINT CC_DTLPROTOCOLARCH_FIELDCOD_NN  NOT NULL
, FIELD_VALUE     VARCHAR2(256)     CONSTRAINT CC_DTLPROTOCOLARCH_FIELDVAL_NN  NOT NULL
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, MATURITY_DATE   DATE
, CUST_ID         NUMBER(38)
, REF             NUMBER(38)
, ND              NUMBER(38)
, BRANCH          VARCHAR2(30)
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
  
  dbms_output.put_line('table "NBUR_DETAIL_PROTOCOLS_ARCH" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "NBUR_DETAIL_PROTOCOLS_ARCH" already exists.' );
    else raise;
    end if;  
end;
/

prompt -- ======================================================
prompt -- Create index
prompt -- ======================================================

begin
  execute immediate q'[create index IDX_DTLPROTOCOLARCH on NBUR_DETAIL_PROTOCOLS_ARCH
  ( REPORT_DATE, KF, VERSION_ID, REPORT_CODE, NBUC, FIELD_CODE )
  TABLESPACE BRSBIGI
  PCTFREE 0
  LOCAL
  COMPRESS 6 ]';
  dbms_output.put_line( 'Index "IDX_DTLPROTOCOLARCH" created.' );
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line( 'Index "IDX_DTLPROTOCOLARCH" already exists.' );
    else raise;
    end if;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICIES( 'NBUR_DETAIL_PROTOCOLS_ARCH' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  NBUR_DETAIL_PROTOCOLS_ARCH               IS 'Детальний протокол сформованого файлу';

COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.REPORT_DATE   IS 'Звітна дата';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.KF            IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.VERSION_ID    IS 'Iдентифiкатор версії';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.REPORT_CODE   IS 'Код звіту';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.NBUC          IS 'Код розрізу даних у звітному файлі (Code section data)';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.FIELD_CODE    IS 'Код показника';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.FIELD_VALUE   IS 'Значення показника';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.DESCRIPTION   IS 'Опис (коментар)';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.ACC_ID        IS 'Ід. рахунка';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.ACC_NUM       IS 'Номер рахунка';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.KV            IS 'Ід. валюти';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.MATURITY_DATE IS 'Дата Погашення';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.CUST_ID       IS 'Ід. клієнта';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.REF           IS 'Ід. платіжного документа';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.ND            IS 'Ід. договору';
COMMENT ON COLUMN NBUR_DETAIL_PROTOCOLS_ARCH.BRANCH        IS 'Код підрозділу';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON NBUR_DETAIL_PROTOCOLS_ARCH TO BARSUPL;
GRANT SELECT ON NBUR_DETAIL_PROTOCOLS_ARCH TO BARS_ACCESS_DEFROLE;
