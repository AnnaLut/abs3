-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 17.05.2018
-- ======================================================================================
-- create table NBUR_DM_ADL_DOC_RPT_DTL_CNSL
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET ECHO         OFF
SET FEEDBACK     OFF
SET LINES        200
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_DM_ADL_DOC_RPT_DTL_CNSL
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_ADL_DOC_RPT_DTL_CNSL', 'WHOLE' , NULL, NULL, NULL, NULL );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_DM_ADL_DOC_RPT_DTL_CNSL purge';
  dbms_output.put_line('Table dropped.');
exception
  when e_tab_not_exists
  then null;
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_DM_ADL_DOC_RPT_DTL_CNSL
( REPORT_DATE     DATE       CONSTRAINT CC_DMADLDOCRPTDTLCNSL_RPTDT_NN NOT NULL
, KF              CHAR(6)    CONSTRAINT CC_DMADLDOCRPTDTLCNSL_KF_NN    NOT NULL
, REF             NUMBER(38) CONSTRAINT CC_DMADLDOCRPTDTLCNSL_REF_NN   NOT NULL
, D1#70           VARCHAR2(64)
, D2#70           VARCHAR2(64)
, D3#70           VARCHAR2(64)
, D4#70           VARCHAR2(64)
, D5#70           VARCHAR2(64)
, D6#70           VARCHAR2(64)
, D7#70           VARCHAR2(64)
, D8#70           VARCHAR2(64)
, D9#70           VARCHAR2(64)
, DA#70           VARCHAR2(64)
, DB#70           VARCHAR2(64)
, DD#70           VARCHAR2(64)
, D1#E2           VARCHAR2(64)
, D6#E2           VARCHAR2(64)
, D7#E2           VARCHAR2(64)
, D8#E2           VARCHAR2(64)
, D1#E9           VARCHAR2(64)
, D1#C9           VARCHAR2(64)
, D6#C9           VARCHAR2(64)
, DE#C9           VARCHAR2(64)
, D1#D3           VARCHAR2(64)
, D1#F1           VARCHAR2(64)
, D1#27           VARCHAR2(64)
, D1#39           VARCHAR2(64)
, D1#44           VARCHAR2(64)
, D1#73           VARCHAR2(64)
, D2#73           VARCHAR2(64)
, D020            VARCHAR2(64)
, BM__C           VARCHAR2(64)
, KURS            VARCHAR2(64)
, D1#2D           VARCHAR2(64)
, KOD_B           VARCHAR2(64)
, KOD_G           VARCHAR2(64)
, KOD_N           VARCHAR2(64)
, TRF_R           VARCHAR2(64)
, TRF_D           VARCHAR2(64)
, DOC_T           VARCHAR2(64)
, DOC_A           VARCHAR2(64)
, DOC_S           VARCHAR2(64)
, DOC_N           VARCHAR2(64)
, DOC_D           VARCHAR2(64)
, REZID           VARCHAR2(64)
, NATIO           VARCHAR2(64)
, OKPO            VARCHAR2(64)
, POKPO           VARCHAR2(64)
, OOKPO           VARCHAR2(64)
) TABLESPACE BRSMDLD
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
  
  dbms_output.put_line('table "NBUR_DM_ADL_DOC_RPT_DTL_CNSL" created.');
  
exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_DM_ADL_DOC_RPT_DTL_CNSL" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create unique index UK_DMADLDOCRPTDTLCNSL ON NBUR_DM_ADL_DOC_RPT_DTL_CNSL ( KF, REF )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "UK_DMADLDOCRPTDTLCNSL" created.' );
exception
  when OTHERS then
    case
    when (sqlcode = -00955)
    then dbms_output.put_line( 'Index "UK_DMADLDOCRPTDTLCNSL" already exists in the table.' );
    when (sqlcode = -01408)
    then dbms_output.put_line( 'Column(s) "KF", "REF" already indexed.' );
    else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies('NBUR_DM_ADL_DOC_RPT_DTL_CNSL');
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  NBUR_DM_ADL_DOC_RPT_DTL_CNSL             IS 'Додаткові звітні параметри документів';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.KF          IS 'Код філіалу (МФО)';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.REF         IS 'ідентифікатор документа';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D2#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D3#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D4#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D5#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D6#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D7#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D8#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D9#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.DA#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.DB#70       IS 'Дод. параметр (показник для файлу #70)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.DD#70       IS 'Дод. параметр (показник для файлу #70)';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#E2       IS 'Дод. параметр (показник для файлу #E2)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D6#E2       IS 'Дод. параметр (показник для файлу #E2)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D7#E2       IS 'Дод. параметр (показник для файлу #E2)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D8#E2       IS 'Дод. параметр (показник для файлу #E2)';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#E9       IS 'Код країни отримувача/відправника (KL_K040.K040)';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#C9       IS 'Дод. параметр (показник для файлу #C9)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D6#C9       IS 'Дод. параметр (показник для файлу #C9)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.DE#C9       IS 'Дод. параметр (показник для файлу #C9)';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#D3       IS 'Дод. параметр (показник для файлу #D3)';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#F1       IS 'Дод. параметр (показник для файлу #F1)';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#27       IS 'Дод. параметр D#27 (показник для файлу #27)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#39       IS 'Дод. параметр D#39 (показник для файлу #39)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#44       IS 'Дод. параметр D#44 (показник для файлу #44)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#73       IS 'Дод. параметр D#73 (показник для файлу #73)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D2#73       IS 'Дод. параметр 73%  (показник для файлу #73)';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.BM__C       IS 'Дод. параметр (по банківських металах)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D020        IS 'Параметр розподілу суми оборотів';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.KURS        IS 'Курс купівлі-продажу валюти';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.D1#2D       IS 'Код мети переказу для (#2D)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.KOD_B       IS 'Код БАНКУ (1-ПБ)                                 [BOPBANK.REGNUM]';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.KOD_G       IS 'Код країни Платника/Отримувача (TAG="KOD_G","n") [BOPCOUNT.KODC]';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.KOD_N       IS 'Код призначення платежу (1-ПБ) (TAG="KOD_N","N") [BOPCODE.TRANSCODE]';

COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.TRF_R       IS 'Референс документу відправки переказу';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.TRF_D       IS 'Дата документу відправки переказу';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.DOC_T       IS 'Тип документу';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.DOC_A       IS 'Орган, який видав документ (issuing authority)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.DOC_S       IS 'Серiя документу';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.DOC_N       IS 'Номер документу';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.DOC_D       IS 'Дата видачі документу';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.REZID       IS 'резидент/нерезидент (K030)';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.NATIO       IS 'Громадянство';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.OKPO        IS 'Ідентифікаційний код';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.POKPO       IS 'Код платника';
COMMENT ON COLUMN NBUR_DM_ADL_DOC_RPT_DTL_CNSL.OOKPO       IS 'Код отримувача';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON NBUR_DM_ADL_DOC_RPT_DTL_CNSL TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
