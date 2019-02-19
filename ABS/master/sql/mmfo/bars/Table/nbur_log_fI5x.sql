-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 19/02/2019 (25/10/2018)
-- ======================================================================================
-- create table NBUR_LOG_FI5X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_FI5X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FI5X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FI5X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_LOG_FI5X';
exception
  when e_tab_not_exists then null;  
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_FI5X
( REPORT_DATE     date       constraint CC_NBURLOGFI5X_REPORTDT_NN NOT NULL
, KF              char(6)    constraint CC_NBURLOGFI5X_KF_NN       NOT NULL
, VERSION_ID      NUMBER
, NBUC            VARCHAR2(20 CHAR)     
, EKP             char(6)
, KU              number(3)
, T020            VARCHAR2(1 CHAR) 
, R020            VARCHAR2(4 CHAR) 
, R011            VARCHAR2(1 CHAR)
, R030            VARCHAR2(3 CHAR) 
, K040            VARCHAR2(3 CHAR) 
, K072            VARCHAR2(2 CHAR) 
, K111            VARCHAR2(2 CHAR)
, K140            VARCHAR2(1 CHAR) 
, F074            VARCHAR2(3 CHAR) 
, S032            VARCHAR2(1 CHAR) 
, S183            VARCHAR2(1 CHAR) 
, S241            VARCHAR2(1 CHAR) 
, S260            VARCHAR2(2 CHAR) 
, F048            VARCHAR2(1 CHAR) 
, T070            NUMBER(38)
, T090            NUMBER(12, 4)
, ACC_ID          number(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, MATURITY_DATE   DATE
, CUST_ID         number(38)
, ND              number(38)
, BRANCH          VARCHAR2(30)     
) tablespace BRSBIGD
COMPRESS BASIC
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
( PARTITION P_MINVALUE VALUES LESS THAN ( TO_DATE('01/01/2018','DD/MM/YYYY') ) )]';

  dbms_output.put_line( 'Table "NBUR_LOG_FI5X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_FI5X" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table NBUR_LOG_FI5X add ACC_ID number(38)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_FI5X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  NBUR_LOG_FI5X             is '��� ��� �������� ������ �� ������������ ������ �������';

comment on column NBUR_LOG_FI5X.REPORT_DATE is '����� ����';
comment on column NBUR_LOG_FI5X.KF          is '��� �i�i��� (���)';
comment on column NBUR_LOG_FI5X.VERSION_ID  is '������������� ����';
comment on column NBUR_LOG_FI5X.EKP         is '��� ���������';
comment on column NBUR_LOG_FI5X.KU          is '��� ������i ����i�� �������� �����';
comment on column NBUR_LOG_FI5X.T020 is '������� �������';
comment on column NBUR_LOG_FI5X.R020 is '����� �������';
comment on column NBUR_LOG_FI5X.R011 is '��� �� ���������� �������� ����������� ������� R011';
comment on column NBUR_LOG_FI5X.R030 is '��� ������';
comment on column NBUR_LOG_FI5X.K040 is '��� �����';
comment on column NBUR_LOG_FI5X.K072 is '��� ������� ��������';
comment on column NBUR_LOG_FI5X.K111 is '��� ����i�� ���� ������i��� �i�������i';
comment on column NBUR_LOG_FI5X.K140 is '��� ������ ��ᒺ��� ��������������';
comment on column NBUR_LOG_FI5X.F074 is '��� ���� ��������� �����������/�������� � ������ ����� �� ����� ��������� ��� �� ������� ��������� ��� �� ����� ��';
comment on column NBUR_LOG_FI5X.S032 is '������������ ��� ���� ������������ �������';
comment on column NBUR_LOG_FI5X.S183 is '������������ ��� ���������� ������ ���������';
comment on column NBUR_LOG_FI5X.S241 is '������������ ��� ������ �� ���������';
comment on column NBUR_LOG_FI5X.S260 is '��� �������������� ���������� �� ������';
comment on column NBUR_LOG_FI5X.F048 is '��� ���� ��������� ������';
comment on column NBUR_LOG_FI5X.T070 is '����';
comment on column NBUR_LOG_FI5X.T090 is '��������� ������';
comment on column NBUR_LOG_FI5X.ACC_ID is '��. �������';
comment on column NBUR_LOG_FI5X.ACC_NUM is '����� �������';
comment on column NBUR_LOG_FI5X.KV is '��. ������';
comment on column NBUR_LOG_FI5X.MATURITY_DATE is '���� ���������';
comment on column NBUR_LOG_FI5X.CUST_ID is '��. �볺���';
comment on column NBUR_LOG_FI5X.ND is '��. ��������';
comment on column NBUR_LOG_FI5X.BRANCH is '��� ��������';      

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_FI5X to BARSUPL;
grant SELECT on NBUR_LOG_FI5X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_FI5X to BARSREADER_ROLE;
