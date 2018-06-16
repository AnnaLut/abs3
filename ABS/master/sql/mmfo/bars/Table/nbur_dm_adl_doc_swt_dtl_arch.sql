-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 22.05.2018
-- ======================================================================================
-- create table NBUR_DM_ADL_DOC_SWT_DTL_ARCH
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET DEFINE       OFF
SET FEEDBACK     OFF
SET LINES        200
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_DM_ADL_DOC_SWT_DTL_ARCH
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_ADL_DOC_SWT_DTL_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  bars.bpa.alter_policy_info( 'NBUR_DM_ADL_DOC_SWT_DTL_ARCH', 'FILIAL', 'M',  'M',  'E',  'E' );
  bars.bpa.alter_policy_info( 'NBUR_DM_ADL_DOC_SWT_DTL_ARCH', 'CENTER', NULL, 'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH
( REPORT_DATE     DATE       CONSTRAINT CC_DMADLDOCSWTDTLARCH_RPTDT_NN NOT NULL
, KF              CHAR(6)    CONSTRAINT CC_DMADLDOCSWTDTLARCH_KF_NN    NOT NULL
, VERSION_ID      NUMBER(3)  CONSTRAINT CC_DMADLDOCSWTDTLARCH_VRSN_NN  NOT NULL
, REF             NUMBER(38) CONSTRAINT CC_DMADLDOCSWTDTLARCH_REF_NN   NOT NULL
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
COMPRESS BASIC 
PARALLEL
STORAGE( INITIAL 64K NEXT 64K )
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
( PARTITION   P_MINVALUE VALUES LESS THAN ( TO_DATE('01/01/2016','DD/MM/YYYY') ) )]';
  
  dbms_output.put_line('table "NBUR_DM_ADL_DOC_SWT_DTL_ARCH" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "NBUR_DM_ADL_DOC_SWT_DTL_ARCH" already exists.' );
    else raise;
    end if;  
end;
/


prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

begin
  NBUR_UTIL.SET_COL( 'NBUR_DM_ADL_DOC_SWT_DTL_ARCH', 'ASP_K', 'VARCHAR2(14)' );
  NBUR_UTIL.SET_COL( 'NBUR_DM_ADL_DOC_SWT_DTL_ARCH', 'ASP_N', 'VARCHAR2(38)' );
  NBUR_UTIL.SET_COL( 'NBUR_DM_ADL_DOC_SWT_DTL_ARCH', 'ASP_S', 'VARCHAR2(1)'  );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[CREATE UNIQUE INDEX BARS.UK_DMADLDOCSWTDTLARCH ON BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH (REPORT_DATE, KF, VERSION_ID, REF )
  TABLESPACE BRSMDLI
  PCTFREE 0 
  LOCAL
  COMPRESS 3 ]';
  dbms_output.put_line( 'Index "BARS.UK_DMADLDOCSWTDTLARCH" created.' );
exception
  when OTHERS then 
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "UK_DMADLDOCSWTDTLARCH" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "REPORT_DATE", "KF", "VERSION_ID", "REF" already indexed.');
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies('NBUR_DM_ADL_DOC_SWT_DTL_ARCH');
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH             IS 'SWIFT реквізити документів';

COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.KF          IS 'Код філіалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.VERSION_ID  IS 'Iдентифiкатор версії';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.REF         IS 'ідентифікатор документа';

COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW11R       IS 'SWT.11R MT and Date of Message';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW11S       IS 'SWT.11S MT and Date of Message';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW13C       IS 'SWT.13C Время выполнения операции';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW20        IS 'SWT.20  Референс повідомлення';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW21        IS 'SWT.21  Референс зв`яз повідомлення';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW23B       IS 'SWT.23B Код банківської операції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW23E       IS 'SWT.23E Коди інструкції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW25        IS 'SWT.25  Account Identification';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW26T       IS 'SWT.26T Код типу транзакції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW30        IS 'SWT.30  Date of Cash Letter';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW32A       IS 'SWT.32A Сума документа';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW32B       IS 'SWT.32A Сума транзакції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW32C       IS 'SWT.32C Сума транзакції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW32D       IS 'SWT.32D Сума транзакції';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW33B       IS 'SWT.33B Currency/Instructed Amount';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW36        IS 'SWT.36  Курс обміну';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW50        IS 'SWT.50 Плательщик';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW50A       IS 'SWT.50A Відправник';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW50F       IS 'SWT.50F Відправник';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW50K       IS 'SWT.50K Відправник';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW51A       IS 'SWT.51A Банк відправника';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW52A       IS 'SWT.52A Ordering Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW52B       IS 'SWT.52B Ordering Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW52D       IS 'SWT.52D Ordering Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW53A       IS 'SWT.53A Sender`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW53B       IS 'SWT.53B Sender`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW53D       IS 'SWT.53D Sender`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW54        IS 'SWT.54 Корреспондент получателя';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW54A       IS 'SWT.54A Receiver`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW54B       IS 'SWT.54B Receiver`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW54D       IS 'SWT.54D Receiver`s Correspondent';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW55A       IS 'SWT.55A Third Reimbursement Inst';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW55B       IS 'SWT.55B Third Reimbursement Inst';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW55D       IS 'SWT.55D Third Reimbursement Inst';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW56        IS 'SWT.56 Промежуточный банк';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW56A       IS 'SWT.56A Intermediary Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW56C       IS 'SWT.56C Intermediary Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW56D       IS 'SWT.56D Intermediary Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW57        IS 'SWT.57 Банк отримувача';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW57A       IS 'SWT.57A Account With Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW57B       IS 'SWT.57B Account With Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW57C       IS 'SWT.57C Account With Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW57D       IS 'SWT.57D Account With Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW58        IS 'SWT.58 Получатель (банк)';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW58A       IS 'SWT.58A Beneficiary Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW58D       IS 'SWT.58D Beneficiary Institution';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW59        IS 'SWT.59  Beneficiary Customer';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW59A       IS 'SWT.59A Beneficiary Customer';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW61        IS 'SWT.61 Рядок виписки';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW70        IS 'SWT.70  Remittance Information';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW71A       IS 'SWT.71A Details of Charges';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW71B       IS 'SWT.71B Details of Charges';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW71F       IS 'SWT.71F Sender`s Charges';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW71G       IS 'SWT.71G Receiver`s Charges';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW72        IS 'SWT.72  Sender to Receiver Info';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW76        IS 'SWT.76  Answers';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW77A       IS 'SWT.77A Narrative';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW77B       IS 'SWT.77B Regulatory Reporting';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW77T       IS 'SWT.77T Envelope Contents';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SW79        IS 'SWT.79  Narrative';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.SWRCV       IS 'SWT. BIC-код банка получателя';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.NOS_A       IS 'Рахунок NOSTRO';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.NOS_B       IS 'Банк NOSTRO';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.NOS_R       IS 'Реф. первинного документа';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.ASP_K       IS 'ЗКПО клієнта ЛОРО-банку';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.ASP_N       IS 'Наймен.клієнта ЛОРО-банку';
COMMENT ON COLUMN BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH.ASP_S       IS 'Статус клієнта ЛОРО-банку';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH TO BARSUPL;
GRANT SELECT ON BARS.NBUR_DM_ADL_DOC_SWT_DTL_ARCH TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
