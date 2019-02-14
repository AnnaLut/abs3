
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_fd9x.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FD9X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FD9X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_FD9X
( REPORT_DATE     date       constraint CC_NBURLOGFD9X_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGFD9X_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR)  constraint CC_NBURLOGFD9X_EKP_NN            NOT NULL
, Q003_1          VARCHAR2(5 CHAR)  constraint CC_NBURLOGFD9X_Q003_1_NN         NOT NULL 
, K020_1          VARCHAR2(10 CHAR)  constraint CC_NBURLOGFD9X_K020_1_NN         NOT NULL
, K021_1          VARCHAR2(1 CHAR)  constraint CC_NBURLOGFD9X_K021_1_NN         NOT NULL
, Q001_1          VARCHAR2(255 CHAR)  constraint CC_NBURLOGFD9X_Q001_1_NN         NOT NULL
, Q029_1          VARCHAR2(50 CHAR)
, K020_2          VARCHAR2(10 CHAR)  constraint CC_NBURLOGFD9X_K020_2_NN         NOT NULL
, K021_2          VARCHAR2(1 CHAR)  constraint CC_NBURLOGFD9X_K021_2_NN         NOT NULL
, Q001_2          VARCHAR2(255 CHAR)  constraint CC_NBURLOGFD9X_Q001_2_NN         NOT NULL
, Q029_2          VARCHAR2(50 CHAR)
, K014            VARCHAR2(1 CHAR)  constraint CC_NBURLOGFD9X_K014_NN         NOT NULL
, K040            VARCHAR2(3 CHAR)  constraint CC_NBURLOGFD9X_K040_NN         NOT NULL
, KU_1            VARCHAR2(3 CHAR)
, K110            VARCHAR2(5 CHAR)
, T090_1          NUMBER(38)
, T090_2          NUMBER(38)
, DESCRIPTION     VARCHAR2(250)
, KV              NUMBER(3)
, CUST_ID         NUMBER(38)     
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

  dbms_output.put_line( 'Table "NBUR_LOG_FD9X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_FD9X" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_FD9X' );
end;
/

commit;

comment on table  NBUR_LOG_FD9X is 'D9X���� ��� ��������� (������ �� ���������������) �������� ����������� �����';
comment on column NBUR_LOG_FD9X.REPORT_DATE is '��i��� ����';
comment on column NBUR_LOG_FD9X.KF is '�i�i�';
comment on column NBUR_LOG_FD9X.VERSION_ID is '����� ���� �����';
comment on column NBUR_LOG_FD9X.NBUC   is '��� ���';
comment on column NBUR_LOG_FD9X.EKP    is '��� ���������';
comment on column NBUR_LOG_FD9X.Q003_1 is '������� ���������� ����� ������';
comment on column NBUR_LOG_FD9X.K020_1 is '��� �����������';
comment on column NBUR_LOG_FD9X.K021_1 is '������ ���� �����������';
comment on column NBUR_LOG_FD9X.Q001_1 is '����� �����������';
comment on column NBUR_LOG_FD9X.Q029_1 is '��� ����������� �����������';
comment on column NBUR_LOG_FD9X.K020_2 is '��� �������� �����������';
comment on column NBUR_LOG_FD9X.K021_2 is '������ ���� �������� �����������';
comment on column NBUR_LOG_FD9X.Q001_2 is '����� �������� �����������';
comment on column NBUR_LOG_FD9X.Q029_2 is '��� �������� ����������� �����������';
comment on column NBUR_LOG_FD9X.K014   is '��� �������� �����������';
comment on column NBUR_LOG_FD9X.K040   is '����� �������� �����������';
comment on column NBUR_LOG_FD9X.KU_1   is '����� ��������� �������� �����������';
comment on column NBUR_LOG_FD9X.K110   is '���� �������� �����������';
comment on column NBUR_LOG_FD9X.T090_1 is '³������ ����� ����� ��������';
comment on column NBUR_LOG_FD9X.T090_2 is '³������ �������������� ����� ��������';

comment on column NBUR_LOG_FD9X.DESCRIPTION is '���� (��������)';
comment on column NBUR_LOG_FD9X.KV is '��. ������';
comment on column NBUR_LOG_FD9X.CUST_ID is '��. �볺���';
comment on column NBUR_LOG_FD9X.BRANCH is '��� ��������';

begin
    execute immediate 'alter table bars.nbur_log_fd9x add (T090_1A  NUMBER(12,4))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
comment on column NBUR_LOG_FD9X.T090_1A is '³������ ����� ����� ��������';

begin
    execute immediate 'alter table bars.nbur_log_fd9x add (T090_2A  NUMBER(12,4))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
comment on column NBUR_LOG_FD9X.T090_2A is '³������ �������������� ����� ��������';


grant SELECT on NBUR_LOG_FD9X to BARSUPL;
grant SELECT on NBUR_LOG_FD9X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_FD9X to BARSREADER_ROLE;
                          
                          
PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_fd9x.sql ======= *** End *** ===
PROMPT ===================================================================================== 
                          
                            
