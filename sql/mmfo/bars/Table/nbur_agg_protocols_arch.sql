-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 16.03.2018
-- ======================================================================================
-- create table NBUR_AGG_PROTOCOLS_ARCH
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_AGG_PROTOCOLS_ARCH
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_AGG_PROTOCOLS_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_AGG_PROTOCOLS_ARCH', 'FILIAL',  'M',  'M',  'M',  'M' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_AGG_PROTOCOLS_ARCH', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

begin
  execute immediate q'[CREATE TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH
( REPORT_DATE     DATE              CONSTRAINT CC_AGGPROTOCOLARCH_REPORTDT_NN NOT NULL
, KF              VARCHAR2(6)       CONSTRAINT CC_AGGPROTOCOLARCH_KF_NN       NOT NULL
, VERSION_ID      NUMBER(3)         CONSTRAINT CC_AGGPROTOCOLARCH_VERSION_NN  NOT NULL
, REPORT_CODE     CHAR(3)           CONSTRAINT CC_AGGPROTOCOLARCH_REPORTCD_NN NOT NULL
, NBUC            VARCHAR2(20)      CONSTRAINT CC_AGGPROTOCOLARCH_NBUC_NN     NOT NULL
, FIELD_CODE      VARCHAR2(35)      CONSTRAINT CC_AGGPROTOCOLARCH_FIELDCD_NN  NOT NULL
, FIELD_VALUE     VARCHAR2(256)     CONSTRAINT CC_AGGPROTOCOLARCH_FIELDVAL_NN NOT NULL
, ERROR_MSG       VARCHAR2(1000) 
, ADJ_IND         NUMBER(1)         DEFAULT 0 
                                    CONSTRAINT CC_AGGPROTOCOLARCH_ADJIND_NN     NOT NULL
, CONSTRAINT CC_AGGPROTOCOLARCH_ADJIND CHECK ( ADJ_IND in (0,1) )
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
  
  dbms_output.put_line('table "NBUR_AGG_PROTOCOLS_ARCH" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "NBUR_AGG_PROTOCOLS_ARCH" already exists.' );
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- Create index
prompt -- ======================================================

begin
  execute immediate q'[CREATE UNIQUE INDEX BARS.UK_AGGPROTOCOLARCH ON BARS.NBUR_AGG_PROTOCOLS_ARCH ( REPORT_DATE, KF, VERSION_ID, REPORT_CODE, NBUC, FIELD_CODE )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL
  COMPRESS 5 ]';
  dbms_output.put_line( 'Index "BARS.UK_AGGPROTOCOLARCH" created.' );
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line( 'Index "BARS.UK_AGGPROTOCOLARCH" already exists.' );
    else raise;
    end if;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_AGG_PROTOCOLS_ARCH' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH              IS 'Сформованi показники файлiв звiтностi';

COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.KF          IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.VERSION_ID  IS 'Iдентифiкатор версії';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.REPORT_CODE IS 'Код звіту';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.NBUC        IS 'Код розрізу даних у звітному файлі (Code section data)';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.FIELD_CODE  IS 'Код показника';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.FIELD_VALUE IS 'Значення показника';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.ERROR_MSG   IS 'Текст помилки';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.ADJ_IND     IS 'Ознака ручного корегування значення показника';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_AGG_PROTOCOLS_ARCH TO BARSUPL;
GRANT SELECT ON BARS.NBUR_AGG_PROTOCOLS_ARCH TO BARS_ACCESS_DEFROLE;
