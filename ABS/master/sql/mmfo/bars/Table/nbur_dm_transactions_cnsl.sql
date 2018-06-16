-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 07.04.2016
-- ======================================================================================
-- create table NBUR_DM_TRANSACTIONS_CNSL
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET ECHO         OFF
SET FEEDBACK     OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_DM_TRANSACTIONS_CNSL
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'NBUR_DM_TRANSACTIONS_CNSL', 'WHOLE', Null, Null, Null, Null );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  EXECUTE IMMEDIATE 'drop table NBUR_DM_TRANSACTIONS_CNSL purge';
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
  execute immediate q'[create table NBUR_DM_TRANSACTIONS_CNSL
( REPORT_DATE     DATE         CONSTRAINT CC_DMTRANSCTNCNSL_REPORTDT_NN NOT NULL
, KF              VARCHAR2(6)  CONSTRAINT CC_DMTRANSCTNCNSL_KF_NN       NOT NULL
, REF             NUMBER(38)   CONSTRAINT CC_DMTRANSCTNCNSL_REF_NN      NOT NULL
, TT              CHAR(3)      CONSTRAINT CC_DMTRANSCTNCNSL_TT_NN       NOT NULL
, CCY_ID          NUMBER(3)    CONSTRAINT CC_DMTRANSCTNCNSL_CCYID_NN    NOT NULL
, BAL             NUMBER(24)   CONSTRAINT CC_DMTRANSCTNCNSL_BAL_NN      NOT NULL
, BAL_UAH         NUMBER(24)   CONSTRAINT CC_DMTRANSCTNCNSL_BALUAH_NN   NOT NULL
, CUST_ID_DB      NUMBER(38)   CONSTRAINT CC_DMTRANSCTNCNSL_CUSTIDDB_NN NOT NULL
, ACC_ID_DB       NUMBER(38)   CONSTRAINT CC_DMTRANSCTNCNSL_ACCIDDB_NN  NOT NULL
, ACC_NUM_DB      VARCHAR2(15) CONSTRAINT CC_DMTRANSCTNCNSL_ACCNUMDB_NN NOT NULL
, ACC_TYPE_DB     CHAR(3)
, R020_DB         CHAR(4)
, OB22_DB         CHAR(2)
, NBUC_DB         VARCHAR2(20)
, CUST_ID_CR      NUMBER(38)   CONSTRAINT CC_DMTRANSCTNCNSL_CUSTIDCR_NN NOT NULL
, ACC_ID_CR       NUMBER(38)   CONSTRAINT CC_DMTRANSCTNCNSL_ACCIDCR_NN  NOT NULL
, ACC_NUM_CR      VARCHAR2(15) CONSTRAINT CC_DMTRANSCTNCNSL_ACCNUMCR_NN NOT NULL
, ACC_TYPE_CR     CHAR(3)
, R020_CR         CHAR(4)
, OB22_CR         CHAR(2)
, NBUC_CR         VARCHAR2(20)
, ADJ_IND         NUMBER(1)
, DOC_VAL_DT      DATE
) TABLESPACE BRSBIGD
NOLOGGING
STORAGE ( INITIAL 16M NEXT 16M )
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
  
  dbms_output.put_line('table "NBUR_DM_TRANSACTIONS_CNSL" created.');
  
exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_DM_TRANSACTIONS_CNSL" already exists.' );
end;
/

prompt -- ======================================================
prompt -- indexes
prompt -- ======================================================

begin
  execute immediate q'[CREATE INDEX BARS.IDX_DMTRANSCTNCNSL_KF_REF ON BARS.NBUR_DM_TRANSACTIONS_CNSL ( KF, REF )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL 
  COMPRESS 1 ]';
  dbms_output.put_line('index "IDX_DMTRANSCTNCNSL_KF_REF" created.');
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "IDX_DMTRANSCTNCNSL_KF_REF" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "KF", "REF" already indexed.');
      else raise;
    end case;
end;
/

begin
  execute immediate q'[CREATE INDEX BARS.IDX_DMTRANSCTNCNSL_DEBIT_SIDE ON BARS.NBUR_DM_TRANSACTIONS_CNSL ( KF, ACC_NUM_DB, CCY_ID )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL 
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "IDX_DMTRANSCTNCNSL_DEBIT_SIDE" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "IDX_DMTRANSCTNCNSL_DEBIT_SIDE" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "KF", "ACC_NUM_DB", "CCY_ID" already indexed.');
      else raise;
    end case;
end;
/

begin
  execute immediate q'[CREATE INDEX BARS.IDX_DMTRANSCTNCNSL_CREDIT_SIDE ON BARS.NBUR_DM_TRANSACTIONS_CNSL ( KF, ACC_NUM_CR, CCY_ID )
  TABLESPACE BRSMDLI
  PCTFREE 0 
  LOCAL 
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "IDX_DMTRANSCTNCNSL_CREDIT_SIDE" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "IDX_DMTRANSCTNCNSL_CREDIT_SIDE" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "KF", "ACC_NUM_CR", "CCY_ID" already indexed.');
      else raise;
    end case;
end;
/

begin
  execute immediate q'[CREATE INDEX BARS.IDX_DMTRANSCTNCNSL_DB_SIDE ON BARS.NBUR_DM_TRANSACTIONS_CNSL ( KF, CCY_ID, R020_DB, OB22_DB )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL 
  COMPRESS 3 ]';
  dbms_output.put_line( 'Index "IDX_DMTRANSCTNCNSL_DB_SIDE" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "IDX_DMTRANSCTNCNSL_DB_SIDE" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "KF", "CCY_ID", "R020_DB", "OB22_DB" already indexed.');
      else raise;
    end case;
end;
/

begin
  execute immediate q'[CREATE INDEX BARS.IDX_DMTRANSCTNCNSL_CR_SIDE ON BARS.NBUR_DM_TRANSACTIONS_CNSL ( KF, CCY_ID, R020_CR, OB22_CR )
  TABLESPACE BRSBIGI
  PCTFREE 0 
  LOCAL 
  COMPRESS 3 ]';
  dbms_output.put_line( 'Index "IDX_DMTRANSCTNCNSL_CR_SIDE" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "IDX_DMTRANSCTNCNSL_CR_SIDE" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "KF", "CCY_ID", "R020_CR", "OB22_CR" already indexed.');
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies('NBUR_DM_TRANSACTIONS_CNSL');
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  NBUR_DM_TRANSACTIONS_CNSL                   IS 'Financial transactions (consolidated data for the period)';

COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.REPORT_DATE       IS 'Calculation date';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.KF                IS 'Bank code';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.REF               IS 'Document identifier';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.TT                IS 'Transaction type code';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.CCY_ID            IS 'Currency identifier';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.BAL               IS 'Transaction amount';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.BAL_UAH           IS 'Transaction amount in UAH';

COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.CUST_ID_DB        IS 'Customer identifier Debit side transaction (sender)';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.ACC_ID_DB         IS 'Account identifier Debit side transaction';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.ACC_TYPE_DB       IS 'Account type code  Debit side transaction';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.ACC_NUM_DB        IS 'Account number Debit side transaction';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.R020_DB           IS 'Account code Debit side transaction';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.OB22_DB           IS 'Account code Debit side transaction';

COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.CUST_ID_CR        IS 'Customer identifier Credit side transaction (receiver)';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.ACC_ID_CR         IS 'Account identifier Credit side transaction';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.ACC_NUM_CR        IS 'Account number Credit side transaction';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.ACC_TYPE_CR       IS 'Account type code Credit side transaction';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.R020_CR           IS 'Account parameter Credit side transaction';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.OB22_CR           IS 'Account parameter Credit side transaction';

COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.ADJ_IND           IS 'Adjustment Indicator';
COMMENT ON COLUMN NBUR_DM_TRANSACTIONS_CNSL.DOC_VAL_DT        IS 'Value date';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON NBUR_DM_TRANSACTIONS_CNSL TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
