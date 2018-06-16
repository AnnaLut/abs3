-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 22.05.2018
-- ======================================================================================
-- create table NBUR_DM_ADL_DOC_SWT_DTL_CNSL
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
prompt -- create table NBUR_DM_ADL_DOC_SWT_DTL_CNSL
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_ADL_DOC_SWT_DTL_CNSL', 'WHOLE' , NULL, NULL, NULL, NULL );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_DM_ADL_DOC_SWT_DTL_CNSL purge';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists
  then null;
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_DM_ADL_DOC_SWT_DTL_CNSL
( REPORT_DATE     DATE       CONSTRAINT CC_DMADLDOCSWTDTLCNSL_RPTDT_NN NOT NULL
, KF              CHAR(6)    CONSTRAINT CC_DMADLDOCSWTDTLCNSL_KF_NN    NOT NULL
, REF             NUMBER(38) CONSTRAINT CC_DMADLDOCSWTDTLCNSL_REF_NN   NOT NULL
, SW11R           VARCHAR2(35)
, SW11S           VARCHAR2(35)
, SW13C           VARCHAR2(35)
, SW20            VARCHAR2(35)
, SW21            VARCHAR2(35)
, SW23B           VARCHAR2(35)
, SW23E           VARCHAR2(35)
, SW25            VARCHAR2(35)
, SW26T           VARCHAR2(35)
, SW30            VARCHAR2(35)
, SW32A           VARCHAR2(35)
, SW32B           VARCHAR2(35)
, SW32C           VARCHAR2(35)
, SW32D           VARCHAR2(35)
, SW33B           VARCHAR2(35)
, SW36            VARCHAR2(35)
, SW50            VARCHAR2(140)
, SW50A           VARCHAR2(35)
, SW50F           VARCHAR2(35)
, SW50K           VARCHAR2(35)
, SW51A           VARCHAR2(35)
, SW52A           VARCHAR2(35)
, SW52B           VARCHAR2(35)
, SW52D           VARCHAR2(35)
, SW53A           VARCHAR2(35)
, SW53B           VARCHAR2(35)
, SW53D           VARCHAR2(35)
, SW54            VARCHAR2(35)
, SW54A           VARCHAR2(35)
, SW54B           VARCHAR2(35)
, SW54D           VARCHAR2(35)
, SW55A           VARCHAR2(35)
, SW55B           VARCHAR2(35)
, SW55D           VARCHAR2(35)
, SW56            VARCHAR2(35)
, SW56A           VARCHAR2(35)
, SW56C           VARCHAR2(35)
, SW56D           VARCHAR2(35)
, SW57            VARCHAR2(35)
, SW57A           VARCHAR2(35)
, SW57B           VARCHAR2(35)
, SW57C           VARCHAR2(35)
, SW57D           VARCHAR2(35)
, SW58            VARCHAR2(35)
, SW58A           VARCHAR2(35)
, SW58D           VARCHAR2(35)
, SW59            VARCHAR2(35)
, SW59A           VARCHAR2(35)
, SW61            VARCHAR2(35)
, SW70            VARCHAR2(35)
, SW71A           VARCHAR2(35)
, SW71B           VARCHAR2(35)
, SW71F           VARCHAR2(35)
, SW71G           VARCHAR2(35)
, SW72            VARCHAR2(35)
, SW76            VARCHAR2(35)
, SW77A           VARCHAR2(35)
, SW77B           VARCHAR2(35)
, SW77T           VARCHAR2(35)
, SW79            VARCHAR2(35)
, SWRCV           VARCHAR2(35)
, NOS_A           VARCHAR2(35)
, NOS_B           VARCHAR2(35)
, NOS_R           VARCHAR2(35)
, ASP_K           VARCHAR2(14)
, ASP_N           VARCHAR2(38)
, ASP_S           VARCHAR2(1)
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
  
  dbms_output.put_line( 'Table "NBUR_DM_ADL_DOC_SWT_DTL_CNSL" created.' );
  
exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_DM_ADL_DOC_SWT_DTL_CNSL" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create unique index UK_DMADLDOCSWTDTLCNSL ON NBUR_DM_ADL_DOC_SWT_DTL_CNSL ( KF, REF )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "UK_DMADLDOCSWTDTLCNSL" created.' );
exception
  when OTHERS then 
    case
    when (sqlcode = -00955)
    then dbms_output.put_line( 'Index "UK_DMADLDOCSWTDTLCNSL" already exists.' );
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
  BARS.BPA.ALTER_POLICIES('NBUR_DM_ADL_DOC_SWT_DTL_CNSL');
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL             IS 'SWIFT реквізити документів';

COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.KF          IS 'Код філіалу (МФО)';

COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.REF         IS 'ідентифікатор документа';

COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW11R       IS 'SWT.11R MT and Date of Message';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW11S       IS 'SWT.11S MT and Date of Message';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW13C       IS 'SWT.13C Время выполнения операции';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW20        IS 'SWT.20  Референс повідомлення';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW21        IS 'SWT.21  Референс зв`яз повідомлення';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW23B       IS 'SWT.23B Код банківської операції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW23E       IS 'SWT.23E Коди інструкції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW25        IS 'SWT.25  Account Identification';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW26T       IS 'SWT.26T Код типу транзакції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW30        IS 'SWT.30  Date of Cash Letter';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW32A       IS 'SWT.32A Сума документа';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW32B       IS 'SWT.32A Сума транзакції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW32C       IS 'SWT.32C Сума транзакції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW32D       IS 'SWT.32D Сума транзакції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW33B       IS 'SWT.33B Currency/Instructed Amount';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW36        IS 'SWT.36  Курс обміну';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW50        IS 'SWT.50 Плательщик';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW50A       IS 'SWT.50A Відправник';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW50F       IS 'SWT.50F Відправник';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW50K       IS 'SWT.50K Відправник';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW51A       IS 'SWT.51A Банк відправника';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW52A       IS 'SWT.52A Ordering Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW52B       IS 'SWT.52B Ordering Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW52D       IS 'SWT.52D Ordering Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW53A       IS 'SWT.53A Sender`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW53B       IS 'SWT.53B Sender`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW53D       IS 'SWT.53D Sender`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW54        IS 'SWT.54 Корреспондент получателя';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW54A       IS 'SWT.54A Receiver`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW54B       IS 'SWT.54B Receiver`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW54D       IS 'SWT.54D Receiver`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW55A       IS 'SWT.55A Third Reimbursement Inst';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW55B       IS 'SWT.55B Third Reimbursement Inst';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW55D       IS 'SWT.55D Third Reimbursement Inst';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW56        IS 'SWT.56 Промежуточный банк';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW56A       IS 'SWT.56A Intermediary Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW56C       IS 'SWT.56C Intermediary Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW56D       IS 'SWT.56D Intermediary Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW57        IS 'SWT.57 Банк отримувача';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW57A       IS 'SWT.57A Account With Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW57B       IS 'SWT.57B Account With Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW57C       IS 'SWT.57C Account With Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW57D       IS 'SWT.57D Account With Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW58        IS 'SWT.58 Получатель (банк)';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW58A       IS 'SWT.58A Beneficiary Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW58D       IS 'SWT.58D Beneficiary Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW59        IS 'SWT.59  Beneficiary Customer';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW59A       IS 'SWT.59A Beneficiary Customer';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW61        IS 'SWT.61 Рядок виписки';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW70        IS 'SWT.70  Remittance Information';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW71A       IS 'SWT.71A Details of Charges';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW71B       IS 'SWT.71B Details of Charges';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW71F       IS 'SWT.71F Sender`s Charges';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW71G       IS 'SWT.71G Receiver`s Charges';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW72        IS 'SWT.72  Sender to Receiver Info';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW76        IS 'SWT.76  Answers';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW77A       IS 'SWT.77A Narrative';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW77B       IS 'SWT.77B Regulatory Reporting';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW77T       IS 'SWT.77T Envelope Contents';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SW79        IS 'SWT.79  Narrative';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.SWRCV       IS 'SWT. BIC-код банка получателя';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.NOS_A       IS 'Рахунок NOSTRO';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.NOS_B       IS 'Банк NOSTRO';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.NOS_R       IS 'Реф. первинного документа';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.ASP_K       IS 'ЗКПО клієнта ЛОРО-банку';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.ASP_N       IS 'Наймен.клієнта ЛОРО-банку';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL.ASP_S       IS 'Статус клієнта ЛОРО-банку';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_DM_ADL_DOC_SWT_DTL_CNSL TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
