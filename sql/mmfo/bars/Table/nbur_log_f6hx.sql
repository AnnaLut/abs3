
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_f6Hx.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F6HX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F6HX', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F6HX
( REPORT_DATE     date       constraint CC_NBURLOGF6HX_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGF6HX_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, VERSION_D8	  NUMBER
, EKP             VARCHAR2(6 CHAR)   constraint CC_NBURLOGF6HX_EKP_NN          NOT NULL
, K020		  VARCHAR2(10 CHAR) constraint CC_NBURLOGF6HX_K020_NN          NOT NULL
, K021		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6HX_K021_NN          NOT NULL
, Q003_2	  VARCHAR2(4 CHAR)
, Q003_4	  VARCHAR2(2 CHAR)
, R030		  VARCHAR2(3 CHAR)  constraint CC_NBURLOGF6HX_R030_NN          NOT NULL
, Q007_1	  date
, Q007_2	  date
, S210		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6HX_S210_NN          NOT NULL
, S083		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6HX_S083_NN          NOT NULL
, S080_1	  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6HX_S080_1_NN        NOT NULL
, S080_2	  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6HX_S080_2_NN        NOT NULL
, F074		  VARCHAR2(3 CHAR)  constraint CC_NBURLOGF6HX_F074_NN          NOT NULL
, F077		  VARCHAR2(3 CHAR)  constraint CC_NBURLOGF6HX_F077_NN          NOT NULL
, F078		  VARCHAR2(6 CHAR)  constraint CC_NBURLOGF6HX_F078_NN          NOT NULL
, F102		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6HX_F102_NN          NOT NULL
, Q017		  VARCHAR2(49 CHAR) 
, Q027		  VARCHAR2(239 CHAR) 
, Q034		  VARCHAR2(17 CHAR) 
, Q035		  VARCHAR2(69 CHAR) 
, T070_2	  NUMBER(16) 
, T090		  NUMBER(9,4) 
, T100_1	  VARCHAR2(6 CHAR) 
, T100_2	  VARCHAR2(4 CHAR) 
, T100_3	  VARCHAR2(4 CHAR) 
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, CUST_ID         NUMBER(38)     
, CUST_CODE	  VARCHAR2(14)
, CUST_NAME	  VARCHAR2(70)
, ND              NUMBER(38)
, AGRM_NUM	  VARCHAR2(50)
, BEG_DT	  date
, END_DT          date
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

  dbms_output.put_line( 'Table "NBUR_LOG_F6HX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F6HX" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F6HX' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f6Hx                 Comments

comment on table  NBUR_LOG_F6HX is '6HX ���i ��� ������������ ������ �� ��������� ���������� ����� � ������������� � �� (���������� �� �������� �� ��������)';
comment on column NBUR_LOG_F6HX.REPORT_DATE is '��i��� ����';
comment on column NBUR_LOG_F6HX.KF 	is '�i�i�';
comment on column NBUR_LOG_F6HX.VERSION_ID is '����� ���� �����';
comment on column NBUR_LOG_F6HX.VERSION_D8 is '����� ���� ����� #D8';
comment on column NBUR_LOG_F6HX.NBUC 	is '��� ���';
comment on column NBUR_LOG_F6HX.EKP	is '��� ���������';
comment on column NBUR_LOG_F6HX.K020	is '����������������/������������ ���/����� �����������/���?����� � ������ �����';
comment on column NBUR_LOG_F6HX.K021	is '��� ������ �����������������/������������� ����/������';
comment on column NBUR_LOG_F6HX.Q003_2  is '������� ���������� ����� ��������';
comment on column NBUR_LOG_F6HX.Q003_4	is '������� ���������� ����� ������';
comment on column NBUR_LOG_F6HX.R030	is '��� ������';
comment on column NBUR_LOG_F6HX.Q007_1	is '���� ���������� �������������/���.����������';
comment on column NBUR_LOG_F6HX.Q007_2	is '���� �������� ��������� �������������/���.����������';
comment on column NBUR_LOG_F6HX.S210	is '��� ������� �������� ���� ����������������/��������������';
comment on column NBUR_LOG_F6HX.S083	is '��� ���� ������ ���������� ������';
comment on column NBUR_LOG_F6HX.S080_1  is '��� ����� �����������/������� � ������ �����';
comment on column NBUR_LOG_F6HX.S080_2  is '��� ������������� ����� �����������/������� � ������ �����';
comment on column NBUR_LOG_F6HX.F074	is '��� ������� ���� ��������� �� ����� ��������� ��� �� ������� ��������� ��� �� ����� ��������� �����������';
comment on column NBUR_LOG_F6HX.F077	is '��� ������� ���� ���������� ������ �����';
comment on column NBUR_LOG_F6HX.F078	is '��� ������� ���� ���������� �������������';
comment on column NBUR_LOG_F6HX.F102	is '��� ���� �������� ���������� � ���������� �����';
comment on column NBUR_LOG_F6HX.Q017	is '��� ������� ���� �������� ������, �� ������� ��� ������� ��������� ����� (�� F075)';
comment on column NBUR_LOG_F6HX.Q027	is '��� ������� ���� ��䳿 ������� (�� F076)';
comment on column NBUR_LOG_F6HX.Q034	is '��� �������, �� ������ ����� ����������� ���� �����������/�������� � ������ ����� (�� F079)';
comment on column NBUR_LOG_F6HX.Q035	is '��� ������ ��䳿 �������, ���� ��� �������� ��������� ������� (�� F080)';
comment on column NBUR_LOG_F6HX.T070_2  is '����� ���������� ������ (CR)';
comment on column NBUR_LOG_F6HX.T090	is '��������� ������';
comment on column NBUR_LOG_F6HX.T100_1  is '���������� ������ ���������� ������ (PD)';
comment on column NBUR_LOG_F6HX.T100_2  is '���������� LGD';
comment on column NBUR_LOG_F6HX.T100_3  is '���������� CCF';
comment on column NBUR_LOG_F6HX.DESCRIPTION 	is '���� (��������)';
comment on column NBUR_LOG_F6HX.ACC_ID		is '��. �������';
comment on column NBUR_LOG_F6HX.ACC_NUM 	is '����� �������';
comment on column NBUR_LOG_F6HX.KV		is '��. ������';
comment on column NBUR_LOG_F6HX.CUST_ID 	is '��. �볺���';
comment on column NBUR_LOG_F6HX.CUST_CODE       is '��� �볺���';
comment on column NBUR_LOG_F6HX.CUST_NAME	is '����� �볺���';
comment on column NBUR_LOG_F6HX.ND		is '��. ��������';
comment on column NBUR_LOG_F6HX.AGRM_NUM	is '����� ��������';
comment on column NBUR_LOG_F6HX.BEG_DT		is '���� ������� ��������';
comment on column NBUR_LOG_F6HX.END_DT		is '���� ��������� ��������';
comment on column NBUR_LOG_F6HX.BRANCH		is '��� ��������';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f6Hx                   Grants

grant SELECT on NBUR_LOG_F6HX to BARSUPL;
grant SELECT on NBUR_LOG_F6HX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F6HX to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_f6Hx.sql ======= *** End *** ===
PROMPT ===================================================================================== 
