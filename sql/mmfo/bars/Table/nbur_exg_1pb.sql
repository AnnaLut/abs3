-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 07.04.2016
-- ======================================================================================
-- create table NBUR_EXG_1PB
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
prompt -- create table NBUR_EXG_1PB
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'NBUR_EXG_1PB', 'WHOLE', Null, Null, Null, Null );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  EXECUTE IMMEDIATE 'drop table NBUR_EXG_1PB purge';
  dbms_output.put_line( 'Table "NBUR_EXG_1PB" dropped.' );
exception
  when e_tab_not_exists then
    null;
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_EXG_1PB
( KF              VARCHAR2(6)   constraint CC_NBUREXG1PB_KF_NN       NOT NULL
, DOC_REF         NUMBER(38)    constraint CC_NBUREXG1PB_DOCREF_NN   NOT NULL
, DOC_DT          DATE
, CCY_ID          NUMBER(3)
, ACC_DB_NUM      VARCHAR2(14)
, ACC_DB_NM       VARCHAR2(38)
, ACC_CR_NUM      VARCHAR2(14)
, ACC_CR_NM       VARCHAR2(38)
, DOC_AMNT        NUMBER(24)
, DOC_DSC         VARCHAR2(160)
, TXN_CODE        VARCHAR2(4)
, TXN_NM          VARCHAR2(128)
, CUST_ST         VARCHAR2(1)
, CUST_CODE       VARCHAR2(10)
, CUST_NM         VARCHAR2(38)
, CLNT_ID         VARCHAR2(64) default SYS_CONTEXT('USERENV','CLIENT_IDENTIFIER')
                               constraint CC_NBUREXG1PB_CLNTID_NN   NOT NULL
) TABLESPACE BRSDYND
NOLOGGING
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
  
  dbms_output.put_line( 'Table "NBUR_EXG_1PB" created.');
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "NBUR_EXG_1PB" already exists.' );
end;
/

begin
  bars.bpa.alter_policies( 'NBUR_EXG_1PB' );
end;
/

commit;

prompt -- ======================================================
prompt -- indexes
prompt -- ======================================================

begin
  execute immediate q'[CREATE UNIQUE INDEX BARS.UK_NBUREXG1PB ON BARS.NBUR_EXG_1PB ( KF, DOC_REF )
  TABLESPACE BRSDYNI
  PCTFREE 0 
  LOCAL 
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "UK_NBUREXG1PB" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "UK_NBUREXG1PB" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "KF", "DOC_REF" already indexed.');
      else raise;
    end case;
end;
/

begin
  execute immediate q'[create index IDX_NBUREXG1PB_CLNTID on NBUR_EXG_1PB ( KF, CLNT_ID )
  TABLESPACE BRSDYNI
  PCTFREE 0 
  LOCAL 
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "IDX_NBUREXG1PB_CLNTID" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "UK_NBUREXG1PB" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "KF", "CLNT_ID" already indexed.');
      else raise;
    end case;
end;
/

prompt -- ======================================================
prompt -- table comments
prompt -- ======================================================

SET FEEDBACK ON

COMMENT ON TABLE  NBUR_EXG_1PB            is 'Імпорт/Експорт інформації по НОСТРО та ЛОРО операціях проведених уповноваженими банкам';

COMMENT ON COLUMN NBUR_EXG_1PB.KF         is 'Bank code';
COMMENT ON COLUMN NBUR_EXG_1PB.DOC_REF    is 'Document identifier';
COMMENT ON COLUMN NBUR_EXG_1PB.DOC_DT     is 'Document date';
COMMENT ON COLUMN NBUR_EXG_1PB.CCY_ID     is 'Currency identifier';
COMMENT ON COLUMN NBUR_EXG_1PB.DOC_AMNT   is 'Document amount';
COMMENT ON COLUMN NBUR_EXG_1PB.DOC_DSC    is 'Document description';
COMMENT ON COLUMN NBUR_EXG_1PB.ACC_DB_NUM is 'Account number Debit side transaction';
COMMENT ON COLUMN NBUR_EXG_1PB.ACC_DB_NM  is 'Account name Debit side transaction';
COMMENT ON COLUMN NBUR_EXG_1PB.ACC_CR_NUM is 'Account number Credit side transaction';
COMMENT ON COLUMN NBUR_EXG_1PB.ACC_CR_NM  is 'Account name code Credit side transaction';
COMMENT ON COLUMN NBUR_EXG_1PB.TXN_CODE   is 'Код операції за формою 1-ПБ';
COMMENT ON COLUMN NBUR_EXG_1PB.TXN_NM     is 'Назва операції за формою 1-ПБ';
COMMENT ON COLUMN NBUR_EXG_1PB.CUST_ST    is 'Статус клієнта';
COMMENT ON COLUMN NBUR_EXG_1PB.CUST_CODE  is 'Код клієнта';
COMMENT ON COLUMN NBUR_EXG_1PB.CUST_NM    is 'Назва клієнта';
COMMENT ON COLUMN NBUR_EXG_1PB.CLNT_ID    is 'CLIENT_IDENTIFIER';

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
