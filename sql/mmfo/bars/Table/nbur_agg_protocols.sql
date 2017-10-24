-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 30.05.2016
-- ======================================================================================
-- create table NBUR_AGG_PROTOCOLS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_AGG_PROTOCOLS
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_AGG_PROTOCOLS', 'WHOLE' , NULL, NULL, NULL, NULL );
end;
/

begin
  execute immediate 'drop table BARS.NBUR_AGG_PROTOCOLS purge';
  dbms_output.put_line( 'Table dropped.' );
exception
  when OTHERS then
    if ( sqlcode = -00942 )
    then dbms_output.put_line( 'Table "NBUR_AGG_PROTOCOLS" does not exist.' );
    else raise;
    end if;
end;
/

begin
  execute immediate q'[CREATE TABLE BARS.NBUR_AGG_PROTOCOLS
( REPORT_DATE     DATE                     CONSTRAINT CC_AGGPROTOCOLS_REPORTDT_NN   NOT NULL
, KF              VARCHAR2(6)              CONSTRAINT CC_AGGPROTOCOLS_KF_NN         NOT NULL
, REPORT_CODE     CHAR(3)                  CONSTRAINT CC_AGGPROTOCOLS_REPORTCD_NN   NOT NULL
, NBUC            VARCHAR2(20)             CONSTRAINT CC_AGGPROTOCOLS_NBUC_NN       NOT NULL
, FIELD_CODE      VARCHAR2(35)             CONSTRAINT CC_AGGPROTOCOLS_FIELDCD_NN    NOT NULL
, FIELD_VALUE     VARCHAR2(256)            CONSTRAINT CC_AGGPROTOCOLS_FIELDVALUE_NN NOT NULL
, ERROR_MSG       VARCHAR2(1000) 
, ADJ_IND         NUMBER(1)      DEFAULT 0 CONSTRAINT CC_AGGPROTOCOLS_ADJIND_NN     NOT NULL
, CONSTRAINT CC_AGGPROTOCOLS_ADJIND CHECK ( ADJ_IND in (0,1) )
) TABLESPACE BRSBIGD
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
, PARTITION P_356334 VALUES ('356334') )]';
  
  dbms_output.put_line('table "NBUR_AGG_PROTOCOLS" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "NBUR_AGG_PROTOCOLS" already exists.' );
    else raise;
    end if;  
end;
/

prompt -- ======================================================
prompt -- Create index
prompt -- ======================================================

begin
  execute immediate q'[CREATE UNIQUE INDEX BARS.UK_AGGPROTOCOLS ON BARS.NBUR_AGG_PROTOCOLS ( KF, REPORT_CODE, NBUC, FIELD_CODE )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL
  COMPRESS 3 ]';
  dbms_output.put_line( 'Index "BARS.UK_AGGPROTOCOLS" created.' );
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line( 'Index "BARS.UK_AGGPROTOCOLS" already exists.' );
    else raise;
    end if;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

COMMENT ON TABLE BARS.NBUR_AGG_PROTOCOLS              IS 'Сформованi показники файлiв звiтностi';

COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS.KF          IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS.REPORT_CODE IS 'Код звіту';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS.NBUC        IS 'Код розрізу даних у звітному файлі (Code section data)';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS.FIELD_CODE  IS 'Код показника';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS.FIELD_VALUE IS 'Значення показника';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS.ERROR_MSG   IS 'Текст помилки';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS.ADJ_IND     IS 'Ознака ручного корегування значення показника';

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
