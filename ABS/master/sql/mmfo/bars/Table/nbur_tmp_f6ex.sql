PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_F6EX.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to NBUR_TMP_F6EX ***

BEGIN     
  bpa.alter_policy_info('NBUR_TMP_F6EX', 'WHOLE' , null, null, null, null);    
END; 
/
declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_TMP_F6EX purge';
  dbms_output.put_line( 'Table "NBUR_TMP_F6EX" dropped.' );
exception
  when e_tab_not_exists then
    dbms_output.put_line( 'Table "NBUR_TMP_F6EX" does not exist.' );
end;
/
PROMPT *** Create  table NBUR_TMP_F6EX ***
begin 
  execute immediate q'[CREATE GLOBAL TEMPORARY TABLE BARS.NBUR_TMP_F6EX 
   (	
     REPORT_DATE        date              constraint CC_NBURTMPF6EX_REPORTDT_NN  NOT NULL
     , KF               char(6)           constraint CC_NBURTMPF6EX_KF_NN        NOT NULL
     , T020             VARCHAR2(1 CHAR)
     , NBS              VARCHAR2(4 CHAR)
     , R011             VARCHAR2(1 CHAR)
     , R013             VARCHAR2(1 CHAR)
     , S181             VARCHAR2(1 CHAR)
     , S240             VARCHAR2(1 CHAR)
     , K040             VARCHAR2(3 CHAR)
     , S190             VARCHAR2(1 CHAR)
     , AMOUNT           NUMBER(38)
     , S080             VARCHAR2(1 CHAR)
     , KOL              NUMBER
     , KOL26            VARCHAR2(500)
     , RESTRUCT_DATE    DATE
     , K030             VARCHAR2(1 CHAR)
     , M030             VARCHAR2(1 CHAR)  
     , K180             VARCHAR2(1 CHAR)
     , K190             VARCHAR2(1 CHAR)
     , BLKD             VARCHAR2(1 CHAR)
     , MSG_RETURN_FLG   VARCHAR2(1 CHAR)
     , DEFAULT_FLG      VARCHAR2(1 CHAR)
     , LIQUID_TYPE      VARCHAR2(1 CHAR)
     , CUST_TYPE        VARCHAR2(2 CHAR)
     , CUST_RATING      VARCHAR2(2 CHAR)
     , CREDIT_WORK_FLG  VARCHAR2(1 CHAR)
     , S130             VARCHAR2(2 CHAR)
     , DESCRIPTION      VARCHAR2(250 CHAR)
     , ACC_ID           NUMBER(38)     
     , ACC_NUM          VARCHAR2(20 CHAR)
     , KV               NUMBER(38)
     , MATURITY_DATE    DATE
     , CUST_ID          NUMBER(38)
     , ND	        NUMBER(38)
     , BRANCH           VARCHAR2(30 CHAR)          
   ) ON COMMIT PRESERVE ROWS ]';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBUR_TMP_F6EX ***
 exec bpa.alter_policies('NBUR_TMP_F6EX');

COMMENT ON TABLE BARS.NBUR_TMP_F6EX IS '������� ��������� ��� ������������� ����� 6EX';
comment on column BARS.NBUR_TMP_F6EX.REPORT_DATE is '��i��� ����';
comment on column BARS.NBUR_TMP_F6EX.KF is '��� �i�i��� (���)';
comment on column BARS.NBUR_TMP_F6EX.T020  is '�����/�����';
comment on column BARS.NBUR_TMP_F6EX.NBS is '���������� �������';
comment on column BARS.NBUR_TMP_F6EX.R011 is '�������� R011';
comment on column BARS.NBUR_TMP_F6EX.R013 is '�������� R013';
comment on column BARS.NBUR_TMP_F6EX.S181 is '�������� S181';
comment on column BARS.NBUR_TMP_F6EX.S240 is '�������� S240';
comment on column BARS.NBUR_TMP_F6EX.K040 is '��� �����';
comment on column BARS.NBUR_TMP_F6EX.S190 is '�������� S190';
comment on column BARS.NBUR_TMP_F6EX.AMOUNT is '����';
comment on column BARS.NBUR_TMP_F6EX.S080 is '�������� ���.����� �� FIN_351';
comment on column BARS.NBUR_TMP_F6EX.KOL is '';
comment on column BARS.NBUR_TMP_F6EX.KOL26 is '';
comment on column BARS.NBUR_TMP_F6EX.RESTRUCT_DATE is '���� ���������������';
comment on column BARS.NBUR_TMP_F6EX.K030 is '������������';
comment on column BARS.NBUR_TMP_F6EX.M030 IS '���� ��������� �� 30 ���';
comment on column BARS.NBUR_TMP_F6EX.K180 IS '�������� K180';
comment on column BARS.NBUR_TMP_F6EX.K190 IS '�������� K190';
comment on column BARS.NBUR_TMP_F6EX.BLKD IS '���� �������� ���������� ����������� �������';
comment on column BARS.NBUR_TMP_F6EX.MSG_RETURN_FLG IS '���� �������� ����������� ��� ���������� ������/��������';
comment on column BARS.NBUR_TMP_F6EX.DEFAULT_FLG IS '���� �������';
comment on column BARS.NBUR_TMP_F6EX.LIQUID_TYPE IS '��� ������� ������';
comment on column BARS.NBUR_TMP_F6EX.CUST_TYPE IS '��� �볺���';
comment on column BARS.NBUR_TMP_F6EX.CUST_RATING IS '������ �볺���';
comment on column BARS.NBUR_TMP_F6EX.CREDIT_WORK_FLG IS '���� ������� ���������� �������';
comment on column BARS.NBUR_TMP_F6EX.S130 IS '��� ���� ������� ������';
comment on column BARS.NBUR_TMP_F6EX.DESCRIPTION is '���� (��������)';
comment on column BARS.NBUR_TMP_F6EX.ACC_ID is '��. �������';
comment on column BARS.NBUR_TMP_F6EX.ACC_NUM is '����� �������';
comment on column BARS.NBUR_TMP_F6EX.KV is '��. ������';
comment on column BARS.NBUR_TMP_F6EX.MATURITY_DATE is '���� ���������';
comment on column BARS.NBUR_TMP_F6EX.CUST_ID is '��. �볺���';
comment on column BARS.NBUR_TMP_F6EX.ND is '��. ��������';
comment on column BARS.NBUR_TMP_F6EX.BRANCH is '��� ��������';

PROMPT *** Create  grants  NBUR_TMP_F6EX ***
grant SELECT                                                                 on NBUR_TMP_F6EX to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_TMP_F6EX to BARS_DM;
grant SELECT                                                                 on NBUR_TMP_F6EX to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_F6EX.sql =========*** End 
PROMPT ===================================================================================== 