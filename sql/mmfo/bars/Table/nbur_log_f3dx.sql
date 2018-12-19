-- ======================================================================================
-- Module : NBUR
-- Author : Chaika
-- Date   : 12/12/2018
-- ======================================================================================
-- create table NBUR_LOG_F3DX
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_F3DX
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F3DX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F3DX', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_LOG_F3DX';
exception
  when e_tab_not_exists then null;  
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F3DX
( REPORT_DATE   date       constraint CC_NBURLOGF3DX_REPORTDT_NN NOT NULL
, KF            char(6)    constraint CC_NBURLOGF3DX_KF_NN       NOT NULL
, VERSION_ID    NUMBER
, NBUC          VARCHAR2(20 CHAR)     
, EKP		char(6)
, Q003_1	VARCHAR2(5 CHAR)
, Q003_2	VARCHAR2(30 CHAR)
, Q007_1        date
, T070_1	NUMBER(16)
, T070_2	NUMBER(16)
, T070_3	NUMBER(16)
, T070_4	NUMBER(16)
, Q003_3        VARCHAR2(30 CHAR)
, Q007_2	date
, S031		VARCHAR2(2 CHAR)
, T070_5	NUMBER(16)
, T090		NUMBER(9,4)
, Q014		VARCHAR2(30 CHAR)
, Q001_1	VARCHAR2(150 CHAR)
, Q015_1	VARCHAR2(150 CHAR)
, Q015_2	VARCHAR2(150 CHAR)
, Q001_2	VARCHAR2(150 CHAR)
, K020_1	VARCHAR2(10 CHAR)
, Q003_4        VARCHAR2(30 CHAR)
, F017_1	VARCHAR2(1 CHAR)
, Q007_3	date
, F018_1	VARCHAR2(1 CHAR)
, Q007_4	date
, Q005		NUMBER(16)
, T070_6        NUMBER(16)
, T070_7	NUMBER(16)
, T070_8	NUMBER(16)
, T070_9	NUMBER(16)
, IDKU_1	VARCHAR2(2 CHAR)
, Q002_1        VARCHAR2(40 CHAR)
, Q002_2	VARCHAR2(30 CHAR)
, Q002_3	VARCHAR2(60 CHAR)
, Q001_3	VARCHAR2(150 CHAR)
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, MATURITY_DATE	  date
, CUST_ID         NUMBER(38)     
, CUST_CODE	  VARCHAR2(14)
, CUST_NAME	  VARCHAR2(70)
, ND              NUMBER(38)
, AGRM_NUM	  VARCHAR2(50)
, BEG_DT	  date
, END_DT          date
, REF             NUMBER(38)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F3DX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F3DX" already exists.' );
end;
/


SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F3DX' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  NBUR_LOG_F3DX             	is '3DX ���� ������� �������� ������� ��� �� ���� ����� ���������� � ������� (��� �������� ����)';

comment on column NBUR_LOG_F3DX.REPORT_DATE 	is '����� ����';
comment on column NBUR_LOG_F3DX.KF          	is '��� �i�i��� (���)';
comment on column NBUR_LOG_F3DX.VERSION_ID  	is '������������� ����';
comment on column NBUR_LOG_F3DX.EKP         	is '��� ���������';
comment on column NBUR_LOG_F3DX.Q003_1		is '������� ���������� ����� ���������� ��������';
comment on column NBUR_LOG_F3DX.Q003_2		is '����� ���������� ��������';
comment on column NBUR_LOG_F3DX.Q007_1		is '���� ���������� ��������';
comment on column NBUR_LOG_F3DX.T070_1		is '������� ������� ������������� �� ����� ����';      
comment on column NBUR_LOG_F3DX.T070_2		is '������� ������������� �� ���������';
comment on column NBUR_LOG_F3DX.T070_3		is '��������� ���� �������';
comment on column NBUR_LOG_F3DX.T070_4		is '���� ���������� ���';
comment on column NBUR_LOG_F3DX.Q003_3		is '����� �������� �������/�������';
comment on column NBUR_LOG_F3DX.Q007_2		is '���� �������� �������/�������';
comment on column NBUR_LOG_F3DX.S031		is '��� ������������ �������';
comment on column NBUR_LOG_F3DX.T070_5		is '�������� ������� ���� �������� �������';
comment on column NBUR_LOG_F3DX.T090  		is '�������� ����������� �����������';
comment on column NBUR_LOG_F3DX.Q014		is '�������� ������������ ����';
comment on column NBUR_LOG_F3DX.Q001_1		is '����� �����/�������, �������� �������, �� ������� �� ������� �� ��������� �������������� ���';
comment on column NBUR_LOG_F3DX.Q015_1		is '������� ������� �������������� �������� �������';
comment on column NBUR_LOG_F3DX.Q015_2		is 'ʳ������ �������������� (����� ����)/ ����� ������ �������� �������';
comment on column NBUR_LOG_F3DX.Q001_2		is '����� ������������ ������������ / ������������';
comment on column NBUR_LOG_F3DX.K020_1		is '��� ������������ / ������������';
comment on column NBUR_LOG_F3DX.Q003_4		is '����� �������� ��� �������� ���������';
comment on column NBUR_LOG_F3DX.F017_1		is '���� ����� �� ��������� �����������';
comment on column NBUR_LOG_F3DX.Q007_3		is '���� �������� �������� ����� ����� ������ / ���� ���������';
comment on column NBUR_LOG_F3DX.F018_1		is '���� ����� �� ���� �������� ��������';
comment on column NBUR_LOG_F3DX.Q007_4		is '���� ��������� �������� ����������� / ���� ��������� ������ ������';
comment on column NBUR_LOG_F3DX.Q005		is '��������� ������� ������ ������';	
comment on column NBUR_LOG_F3DX.T070_6		is '��������� ������� ������ ������';      
comment on column NBUR_LOG_F3DX.T070_7		is '����������� ������� ������ ������';
comment on column NBUR_LOG_F3DX.T070_8		is '�������� ������� �������� �������';
comment on column NBUR_LOG_F3DX.T070_9		is '�������� ������� ����� / �������� �������';
comment on column NBUR_LOG_F3DX.IDKU_1		is '̳�������������� �����/�������, �������� ������� ';
comment on column NBUR_LOG_F3DX.Q002_1		is '����� ��������������� �����/�������, �������� �������';
comment on column NBUR_LOG_F3DX.Q002_2		is '���������� ����� ��������������� �����/�������, �������� �������';
comment on column NBUR_LOG_F3DX.Q002_3		is '����� ������, ����� �������, ����� �������� ��������������� �����/�������, �������� �������';
comment on column NBUR_LOG_F3DX.Q001_3		is '���������� ������������� (��� ������ ������)';
comment on column NBUR_LOG_F3DX.DESCRIPTION 	is '���� (��������)';    
comment on column NBUR_LOG_F3DX.ACC_ID		is '��. �������';             
comment on column NBUR_LOG_F3DX.ACC_NUM 	is '����� �������';          
comment on column NBUR_LOG_F3DX.KV 		is '��. ������';                  
comment on column NBUR_LOG_F3DX.MATURITY_DATE 	is '���� ���������';   
comment on column NBUR_LOG_F3DX.CUST_ID 	is '��. �볺���';            
comment on column NBUR_LOG_F3DX.CUST_CODE 	is '��� �볺���';          
comment on column NBUR_LOG_F3DX.CUST_NAME 	is '����� �볺���';        
comment on column NBUR_LOG_F3DX.ND 		is '��. ��������';                
comment on column NBUR_LOG_F3DX.AGRM_NUM 	is '����� ��������';        
comment on column NBUR_LOG_F3DX.BEG_DT 		is '���� ������� ��������';   
comment on column NBUR_LOG_F3DX.END_DT 		is '���� ��������� ��������';
comment on column NBUR_LOG_F3DX.REF 		is '��. ��������� ���������';   
comment on column NBUR_LOG_F3DX.BRANCH 		is '��� ��������';          

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_F3DX to BARSUPL;
grant SELECT on NBUR_LOG_F3DX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F3DX to BARSREADER_ROLE;
