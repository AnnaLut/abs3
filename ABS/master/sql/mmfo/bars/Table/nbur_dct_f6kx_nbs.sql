PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DCT_F6KX_NBS.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to NBUR_DCT_F6KX_NBS ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DCT_F6KX_NBS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DCT_F6KX_NBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DCT_F6KX_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DCT_F6KX_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DCT_F6KX_NBS 
   (	
        RULE_ID         NUMBER constraint CC_NBURDCT6KXNBS_RULEID_NN NOT NULL,
        R020            VARCHAR2(4 CHAR),
        T020            VARCHAR2(1 CHAR),
        R011            VARCHAR2(1 CHAR),    
        R013            VARCHAR2(1 CHAR), 
        S130            VARCHAR2(2 CHAR),
        K030            VARCHAR2(1 CHAR),
        M030	        VARCHAR2(1 CHAR),
        K040            VARCHAR2(3 CHAR),
        K180            VARCHAR2(1 CHAR),
        K190            VARCHAR2(1 CHAR),
        S240            VARCHAR2(1 CHAR),
        BLKD            VARCHAR2(1 CHAR),
        BLKK            VARCHAR2(1 CHAR),
        MSG_RETURN_FLG  VARCHAR2(1 CHAR),
        DEFAULT_FLG     VARCHAR2(1 CHAR),
        LIQUID_TYPE     VARCHAR2(1 CHAR),
        CREDIT_WORK_FLG VARCHAR2(1 CHAR),
		CREDIT_IRR_COMM_FLG  VARCHAR2(1 CHAR),
        CUST_TYPE       VARCHAR2(2 CHAR),
        CUST_RATING     VARCHAR2(2 CHAR),
        FACTOR          NUMBER,
        EKP             VARCHAR2(6 CHAR)   constraint CC_NBURDCT6KXNBS_EKP_NN NOT NULL, 
	    LCY_PCT         NUMBER(12, 2), 
	    FCY_PCT         NUMBER(12, 2),
        FLG_REFINANS    VARCHAR2(1 CHAR),
        FLG_OBSERVE_LCR VARCHAR2(1 CHAR)   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6KX_NBS 
  ADD (CREDIT_IRR_COMM_FLG  VARCHAR2(1 CHAR))';
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end; 
/  

begin 
  execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6KX_NBS 
  ADD (BLKK  VARCHAR2(1 CHAR))';
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end; 
/ 
begin 
  execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6KX_NBS 
  ADD (FLG_REFINANS  VARCHAR2(1 CHAR))';
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end; 
/  

begin 
  execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6KX_NBS 
  ADD (FLG_OBSERVE_LCR  VARCHAR2(1 CHAR))';
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end; 
/ 

PROMPT *** ALTER_POLICIES to NBUR_DCT_F6KX_NBS ***
 exec bpa.alter_policies('NBUR_DCT_F6KX_NBS');

COMMENT ON TABLE BARS.NBUR_DCT_F6KX_NBS IS '��������� �� ��������� ����� 6KX';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.RULE_ID IS '���������� ������������� �������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.R020 IS '���������� �������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.T020 IS '�������� �����/�����';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.R011 IS '�������� R011';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.R013 IS '�������� R013';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.S130 IS '�������� S130';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.K030 IS '������������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.M030 IS '���� ��������� �� 30 ���';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.K040 IS '��� �����';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.K180 IS '�������� K180';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.K190 IS '�������� K190';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.S240 IS '�������� S240';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.FACTOR IS '������� ���������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.BLKD IS '���� �������� ���������� ����������� �������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.BLKD IS '���� �������� ���������� ������������ �������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.MSG_RETURN_FLG IS '���� �������� ����������� ��� ���������� ������/��������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.DEFAULT_FLG IS '���� �������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.LIQUID_TYPE IS '��� ������� ������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.CUST_TYPE IS '��� �볺���';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.CUST_RATING IS '������ �볺���';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.CREDIT_WORK_FLG IS '���� ������� ���������� �������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.CREDIT_IRR_COMM_FLG IS '���� ������������ �����''����� ����� � ������������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.EKP IS '��� ���������';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.LCY_PCT IS '���������� ��������� � ����������� �����';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.FCY_PCT IS '���������� ��������� � �������� �����';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.FLG_REFINANS IS '������, �� ����� � ������������� �� ��������������� ���';
COMMENT ON COLUMN BARS.NBUR_DCT_F6KX_NBS.FLG_OBSERVE_LCR IS '������ ����, �� ���� ����������� LCR�� �� LCR�� �� �� ��������� �� ������� �����������������';

PROMPT *** Create  constraint PK_NBUR_DCT_F6KX_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6KX_NBS ADD CONSTRAINT PK_NBURDCT6KXNBS PRIMARY KEY (RULE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  NBUR_DCT_F6KX_NBS ***
grant SELECT                                                                 on NBUR_DCT_F6KX_NBS to BARS_DM;
grant SELECT                                                                 on NBUR_DCT_F6KX_NBS to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DCT_F6KX_NBS.sql =========*** End 
PROMPT ===================================================================================== 