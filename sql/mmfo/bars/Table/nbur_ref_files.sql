-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 30.03.2018
-- ======================================================================================
-- create table NBUR_REF_FILES
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
prompt -- create table NBUR_REF_FILES
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'NBUR_REF_FILES', 'WHOLE',  Null, Null, Null, Null );
  bars.bpa.alter_policy_info( 'NBUR_REF_FILES', 'FILIAL', NULL,  'E',  'E',  'E' );
  bars.bpa.alter_policy_info( 'NBUR_REF_FILES', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_REF_FILES
( ID                   NUMBER(5)     CONSTRAINT CC_REFFILES_ID_NN         NOT NULL
, FILE_CODE            VARCHAR2(3)   CONSTRAINT CC_REFFILES_FILECD_NN     NOT NULL
, SCHEME_CODE          VARCHAR2(1)   CONSTRAINT CC_REFFILES_SCHEMECD_NN   NOT NULL
, FILE_TYPE            VARCHAR2(1)   CONSTRAINT CC_REFFILES_FILETP_NN     NOT NULL
, FILE_NAME            VARCHAR2(255) CONSTRAINT CC_REFFILES_FILENM_NN     NOT NULL
, SCHEME_NUMBER        VARCHAR2(2)   CONSTRAINT CC_REFFILES_SCHEMENUM_NN  NOT NULL
, UNIT_CODE            VARCHAR2(2)   CONSTRAINT CC_REFFILES_UNITCD_NN     NOT NULL
, PERIOD_TYPE          VARCHAR2(1)   CONSTRAINT CC_REFFILES_PERIODTP_NN   NOT NULL
, LOCATION_CODE        VARCHAR2(1)   CONSTRAINT CC_REFFILES_LOCATIONCD_NN NOT NULL
, FILE_CODE_ALT        VARCHAR2(3)
, CONSOLIDATION_TYPE   NUMBER(2)
, VALUE_TYPE_IND       VARCHAR2(1)
, VIEW_NM              VARCHAR2(30)
, FLAG_TURNS           NUMBER(1)
, FILE_FMT             VARCHAR2(3)   DEFAULT 'TXT'
                                     CONSTRAINT CC_REFFILES_FILEFMT_NN    NOT NULL
, constraint PK_NBURREFFILES PRIMARY KEY ( ID ) USING INDEX TABLESPACE BRSMDLI
, constraint UK_NBURREFFILES UNIQUE (FILE_CODE) USING INDEX TABLESPACE BRSMDLI
, constraint FK_NBURREFFILES_PERIODTP FOREIGN KEY (PERIOD_TYPE) REFERENCES BARS.NBUR_REF_PERIODS (PERIOD_TYPE)
, constraint CC_REFFILES_FILEFMT check ( FILE_FMT in ('TXT','XML') )
) TABLESPACE BRSMDLD]';
  
  dbms_output.put_line('table "NBUR_REF_FILES" created.');
  
exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_REF_FILES" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

begin
  NBUR_UTIL.SET_COL( 'NBUR_REF_FILES','FILE_CODE_ALT', 'VARCHAR2(3)' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'NBUR_REF_FILES' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  NBUR_REF_FILES                    IS '������ ����i� �� �� ������������';

comment on column NBUR_REF_FILES.ID                 IS 'I������i����� �����';
comment on column NBUR_REF_FILES.FILE_CODE          IS '��� �����';
comment on column NBUR_REF_FILES.SCHEME_CODE        IS '��� ����� ������� (A017)';
comment on column NBUR_REF_FILES.FILE_TYPE          IS '��� ����� 1/2 [���/�����i��i�]';
comment on column NBUR_REF_FILES.FILE_NAME          IS '����� �����';
comment on column NBUR_REF_FILES.SCHEME_NUMBER      IS '����� ����� ������� (A011)';
comment on column NBUR_REF_FILES.UNIT_CODE          IS '��� ������i ���i�� �����';
comment on column NBUR_REF_FILES.PERIOD_TYPE        IS '��� ���i��������i (A013)';
comment on column NBUR_REF_FILES.LOCATION_CODE      IS '��� ����i�� �� �i���� ������������ (A012)';
comment on column NBUR_REF_FILES.FILE_CODE_ALT      IS '�������������� ��� �����';
comment on column NBUR_REF_FILES.CONSOLIDATION_TYPE IS '��� ������i���ii';
comment on column NBUR_REF_FILES.VALUE_TYPE_IND     IS '��� �������� ���������';
comment on column NBUR_REF_FILES.VIEW_NM            IS '����� �`��� (��� ���)';
comment on column NBUR_REF_FILES.FLAG_TURNS         IS '������ �������� ������� � ���� (0 - ����, 1 - �)';
comment on column NBUR_REF_FILES.FILE_FMT           IS '������ ����� (TXT/XML)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON NBUR_REF_FILES TO BARSUPL;
GRANT SELECT ON NBUR_REF_FILES TO BARS_ACCESS_DEFROLE;
