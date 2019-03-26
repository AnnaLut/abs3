-- ======================================================================================
-- Module : NBUR
-- Author : 
-- Date   : 25.06.2018
-- ======================================================================================
-- create table NBUR_LOG_F08X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_F08X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F08X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F08X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F08X
( REPORT_DATE     date       constraint CC_NBURLOGF08X_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGF08X_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR) constraint CC_NBURLOGF08X_EKP_NN        NOT NULL
, KU              VARCHAR2(3 CHAR) constraint CC_NBURLOGF08X_KU_NN         NOT NULL
, T020            VARCHAR2(2 CHAR) constraint CC_NBURLOGF08X_T020_NN         NOT NULL
, R020            VARCHAR2(4 CHAR)
, R011            VARCHAR2(1 CHAR) 
, R030            VARCHAR2(3 CHAR) constraint CC_NBURLOGF08X_R030_NN         NOT NULL
, K040            VARCHAR2(3 CHAR) constraint CC_NBURLOGF08X_K040_NN         NOT NULL
, K072            VARCHAR2(32 CHAR) constraint CC_NBURLOGF08X_K072_NN        NOT NULL
, S130            VARCHAR2(2 CHAR) constraint CC_NBURLOGF08X_S130_NN         NOT NULL
, S183            VARCHAR2(1 CHAR) constraint CC_NBURLOGF08X_S183_NN         NOT NULL 
, T070            NUMBER(38)
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, MATURITY_DATE   DATE
, CUST_ID         NUMBER(38)     
, REF             NUMBER(38)
, ND              NUMBER(38)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F08X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F08X" already exists.' );
end;
/
SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F08X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table NBUR_LOG_F08X is '08X ��, ��������������, ������, �������';

comment on column NBUR_LOG_F08X.REPORT_DATE is '��i��� ����';
comment on column NBUR_LOG_F08X.KF is '��� �i�i��� (���)';
comment on column NBUR_LOG_F08X.VERSION_ID is '��. ���� �����';
comment on column NBUR_LOG_F08X.NBUC is '��� ������i ����i�� �������� �����';
comment on column NBUR_LOG_F08X.EKP is '��� ���������';
comment on column NBUR_LOG_F08X.KU is '��� �������';
comment on column NBUR_LOG_F08X.T020 is '������� �������';
comment on column NBUR_LOG_F08X.R020 is '����� �������';
comment on column NBUR_LOG_F08X.R011 is '��� �� ���������� �������� ����������� ������� R011';
comment on column NBUR_LOG_F08X.R030 is '��� ������';
comment on column NBUR_LOG_F08X.K040 is '��� �����';
comment on column NBUR_LOG_F08X.K072 is '��� ������� ��������';
comment on column NBUR_LOG_F08X.S130 is '��� ���� ������� ������';
comment on column NBUR_LOG_F08X.S183 is '������������ ��� ���������� ������ ���������';
comment on column NBUR_LOG_F08X.T070 is '����';
comment on column NBUR_LOG_F08X.DESCRIPTION is '���� (��������)';
comment on column NBUR_LOG_F08X.ACC_ID is '��. �������';
comment on column NBUR_LOG_F08X.ACC_NUM is '����� �������';
comment on column NBUR_LOG_F08X.KV is '��. ������';
comment on column NBUR_LOG_F08X.MATURITY_DATE is '���� ���������';
comment on column NBUR_LOG_F08X.CUST_ID is '��. �볺���';
comment on column NBUR_LOG_F08X.REF is '��. ��������� ���������';
comment on column NBUR_LOG_F08X.ND is '��. ��������';
comment on column NBUR_LOG_F08X.BRANCH is '��� ��������';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_F08X to BARSUPL;
grant SELECT on NBUR_LOG_F08X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F08X to BARSREADER_ROLE;