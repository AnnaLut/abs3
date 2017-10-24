

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_ACTS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_ACTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_ACTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_ACTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_ACTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_ACTS 
   (	ACT_ID NUMBER, 
	DIRECT NUMBER, 
	ACT_TYPE NUMBER, 
	RNK NUMBER, 
	BENEF_ID NUMBER, 
	NUM VARCHAR2(21), 
	KV NUMBER, 
	S NUMBER, 
	ACT_DATE DATE, 
	ALLOW_DATE DATE, 
	CREATE_DATE DATE, 
	CONTRACT_NUM VARCHAR2(50), 
	CONTRACT_DATE DATE, 
	FILE_NAME VARCHAR2(12), 
	FILE_DATE DATE, 
	BOUND_SUM NUMBER DEFAULT 0, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_ACTS ***
 exec bpa.alter_policies('CIM_ACTS');


COMMENT ON TABLE BARS.CIM_ACTS IS '���� �� ������� ���';
COMMENT ON COLUMN BARS.CIM_ACTS.ACT_ID IS 'Id ����';
COMMENT ON COLUMN BARS.CIM_ACTS.DIRECT IS '�������� (0 - �����, 1 - ������)';
COMMENT ON COLUMN BARS.CIM_ACTS.ACT_TYPE IS '���';
COMMENT ON COLUMN BARS.CIM_ACTS.RNK IS '������������ ����� �볺���';
COMMENT ON COLUMN BARS.CIM_ACTS.BENEF_ID IS 'Id �����������';
COMMENT ON COLUMN BARS.CIM_ACTS.NUM IS '�����';
COMMENT ON COLUMN BARS.CIM_ACTS.KV IS '��� ������';
COMMENT ON COLUMN BARS.CIM_ACTS.S IS '���� (� �����)';
COMMENT ON COLUMN BARS.CIM_ACTS.ACT_DATE IS '���� ���������� ����';
COMMENT ON COLUMN BARS.CIM_ACTS.ALLOW_DATE IS '���� �������';
COMMENT ON COLUMN BARS.CIM_ACTS.CREATE_DATE IS '��������� ���� ���������';
COMMENT ON COLUMN BARS.CIM_ACTS.CONTRACT_NUM IS '����� ���������';
COMMENT ON COLUMN BARS.CIM_ACTS.CONTRACT_DATE IS '���� ������� 䳿 ���������';
COMMENT ON COLUMN BARS.CIM_ACTS.FILE_NAME IS '����� ����� ������';
COMMENT ON COLUMN BARS.CIM_ACTS.FILE_DATE IS '���� ����� ������';
COMMENT ON COLUMN BARS.CIM_ACTS.BOUND_SUM IS '����`����� ������� ����';
COMMENT ON COLUMN BARS.CIM_ACTS.BRANCH IS '����� �������';




PROMPT *** Create  constraint FK_ACTS_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS ADD CONSTRAINT FK_ACTS_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS ADD CONSTRAINT FK_ACTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACTS_BENEFID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS ADD CONSTRAINT FK_ACTS_BENEFID FOREIGN KEY (BENEF_ID)
	  REFERENCES BARS.CIM_BENEFICIARIES (BENEF_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACTS_ACTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS ADD CONSTRAINT FK_ACTS_ACTTYPE FOREIGN KEY (ACT_TYPE)
	  REFERENCES BARS.CIM_ACT_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS ADD CONSTRAINT PK_ACTS PRIMARY KEY (ACT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS MODIFY (BRANCH CONSTRAINT CC_CIMACTS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTS_CREATEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS MODIFY (CREATE_DATE CONSTRAINT CC_CIMACTS_CREATEDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTS_SV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS MODIFY (S CONSTRAINT CC_CIMACTS_SV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTS_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS MODIFY (KV CONSTRAINT CC_CIMACTS_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTS_BENEFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS MODIFY (BENEF_ID CONSTRAINT CC_CIMACTS_BENEFID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS MODIFY (RNK CONSTRAINT CC_CIMACTS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTS_ACTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS MODIFY (ACT_TYPE CONSTRAINT CC_CIMACTS_ACTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTS_DIRECT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACTS MODIFY (DIRECT CONSTRAINT CC_CIMACTS_DIRECT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACTS ON BARS.CIM_ACTS (ACT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_ACTS ***
grant SELECT                                                                 on CIM_ACTS        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_ACTS        to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_ACTS.sql =========*** End *** ====
PROMPT ===================================================================================== 
