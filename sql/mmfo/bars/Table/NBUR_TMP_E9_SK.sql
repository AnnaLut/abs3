-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 13.03.2018
-- ======================================================================================
-- create table NBUR_TMP_E9_SK
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_TMP_E9_SK
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_TMP_E9_SK', 'WHOLE' , NULL, NULL, NULL, 'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_TMP_E9_SK', 'FILIAL',  'M',  'M',  'M', 'M' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_TMP_E9_SK', 'CENTER', NULL,  'E',  'E', 'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_TMP_E9_SK
( REPORT_DATE     DATE         CONSTRAINT CC_NBURTMPE9SK_REPORTDT_NN   NOT NULL
, KF              CHAR(6)      CONSTRAINT CC_NBURTMPE9SK_KF_NN         NOT NULL
, CTEDRPOU        VARCHAR2(10)
, CTKOD_EKP       VARCHAR2(10)
, CTKOD_D060_1    VARCHAR2(2)
, CTKOD_K020      VARCHAR2(10)
, CTKOD_K021      VARCHAR2(1)
, CTKOD_F001      VARCHAR2(1)
, CTKOD_R030      VARCHAR2(3)
, CTKOD_K040_1    VARCHAR2(3)
, CTKOD_KU_1      VARCHAR2(2)
, CTKOD_K040_2    VARCHAR2(3)
, CTKOD_KU_2      VARCHAR2(2)
, CTKOD_T071      NUMBER(38)
, CTKOD_T080      NUMBER(38)
, CTKOD_D060_2    VARCHAR2(2)
, CTKOD_Q001      VARCHAR2(100)
) TABLESPACE BRSMDLD
PARTITION BY LIST ( KF )
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

  dbms_output.put_line('table "NBUR_TMP_E9_SK" created.');

exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "NBUR_TMP_E9_SK" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
  e_dup_keys_found       exception;
  pragma exception_init( e_dup_keys_found,  -01452 );
begin
  execute immediate q'[create index UK_NBURTMPE9SK_FILESTATUS on NBUR_TMP_E9_SK ( REPORT_DATE, KF) 
  TABLESPACE BRSMDLI ]';
  dbms_output.put_line( 'Index created.' );
exception
  when E_IDX_EXISTS
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when E_COL_ALREADY_IDX
  then dbms_output.put_line( 'Such column list already indexed.' );
  when E_DUP_KEYS_FOUND
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_TMP_E9_SK' );
end;
/

commit;

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

comment on  table BARS.NBUR_TMP_E9_SK              is '�������� � XML ����� ���� �� �� ��� �9 �����';

comment on column BARS.NBUR_TMP_E9_SK.REPORT_DATE  is '��i��� ����';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.KF           IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTEDRPOU     IS '��� ������ ������� �����������';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_EKP     IS '��� ��������� ';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_D060_1     IS '��� ������� �������� ����� ';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_K020     IS '��� ����������/���������� ��������';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_K021     IS '��� ������ ����������������� ����';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_F001     IS '��� �������� �������� �����';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_R030     IS '�������� ��� ������, � ��� ���������� ��������';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_K040_1     IS '���� ����� ��������-����������';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_KU_1     IS '��� ������ ����������� ��������';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_K040_2     IS '���� ����� ��������-����������';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_KU_2     IS '��� ������ ��������� ��������';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_T071     IS '���� � �����, � ����� ������� ������� ������ ��� ���������� ���� ��������';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_T080     IS 'ʳ������';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_D060_2     IS '��� ��������� ������� �������� �����, �������� ������������, �� ������ ��� �������� �������������� �������';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_Q001     IS '������������ ����� �������������-�����������, �� ������ ����� �������� �������������� �������';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_TMP_E9_SK TO BARSUPL;
GRANT SELECT ON BARS.NBUR_TMP_E9_SK TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================

--drop table NBUR_TMP_E9_SK cascade constraints