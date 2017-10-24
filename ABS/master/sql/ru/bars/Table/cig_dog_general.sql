

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_DOG_GENERAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_DOG_GENERAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_DOG_GENERAL'', ''FILIAL'' , null, null, null, ''E'');
               bpa.alter_policy_info(''CIG_DOG_GENERAL'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_DOG_GENERAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_DOG_GENERAL 
   (	ID NUMBER(38,0), 
	ND NUMBER(38,0), 
	CUST_ID NUMBER(38,0), 
	PHASE_ID NUMBER(4,0), 
	PAY_METHOD_ID NUMBER(3,0), 
	PAY_PERIOD_ID NUMBER(3,0), 
	OPERATION NUMBER(1,0), 
	CONTRACT_TYPE NUMBER(4,0), 
	CONTRACT_CODE VARCHAR2(50), 
	CONTRACT_DATE DATE, 
	CONTRACT_START_DATE DATE, 
	CURRENCY_ID NUMBER(3,0), 
	CREDIT_PURPOSE NUMBER(3,0), 
	NEGATIVE_STATUS NUMBER(3,0), 
	APPLICATION_DATE DATE, 
	EXP_END_DATE DATE, 
	FACT_END_DATE DATE, 
	UPD_DATE DATE, 
	SYNC_DATE DATE, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	BRANCH_DOG VARCHAR2(30), 
	SEND_DATE DATE, 
	SEND_ID NUMBER, 
	BATCH_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_DOG_GENERAL ***
 exec bpa.alter_policies('CIG_DOG_GENERAL');


COMMENT ON TABLE BARS.CIG_DOG_GENERAL IS '�������� ���������� ��� ������� �����';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.SEND_ID IS '��� ������ (�����)';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.BATCH_ID IS '��� ������ �������� ���ʲ';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.SEND_DATE IS '���� �������� �� ���ʲ';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.ID IS '���';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.ND IS '��� ���������� ��������';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.CUST_ID IS '��� �볺���';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.PHASE_ID IS '���� �������� (D15)';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.PAY_METHOD_ID IS '����� ������� (D19)';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.PAY_PERIOD_ID IS '����������� ������� (D18)';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.OPERATION IS 'ĳ� (D25)';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.CONTRACT_TYPE IS '��� ��������';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.CONTRACT_CODE IS '����� �������� ��� �������';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.CONTRACT_DATE IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.CONTRACT_START_DATE IS '���� ������� 䳿 ��������';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.CURRENCY_ID IS '��� ������';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.CREDIT_PURPOSE IS 'ֳ� ������������ (D14)';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.NEGATIVE_STATUS IS '���������� ������ �������� (D16)';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.APPLICATION_DATE IS '���� ����� �� ������ (���� ������� - ���� ������� 䳿)';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.EXP_END_DATE IS '��������� ���� ��������� ��������';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.FACT_END_DATE IS '�������� ��������� 䳿 ��������';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.UPD_DATE IS '���� ��������� �������� ��������';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.SYNC_DATE IS '���� �������� �������� �� ���������� ����';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.BRANCH IS '';
COMMENT ON COLUMN BARS.CIG_DOG_GENERAL.BRANCH_DOG IS '����� ��������';




PROMPT *** Create  constraint FK_CIGDOGG_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL ADD CONSTRAINT FK_CIGDOGG_TABVAL FOREIGN KEY (CURRENCY_ID)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIGDOGGEN_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL ADD CONSTRAINT FK_CIGDOGGEN_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIGDOGEN_BRANCH_DOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL ADD CONSTRAINT FK_CIGDOGEN_BRANCH_DOG FOREIGN KEY (BRANCH_DOG)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIGDOGG_CIGCUSTOMERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL ADD CONSTRAINT FK_CIGDOGG_CIGCUSTOMERS FOREIGN KEY (CUST_ID, BRANCH)
	  REFERENCES BARS.CIG_CUSTOMERS (CUST_ID, BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIGDOGGENERAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL ADD CONSTRAINT PK_CIGDOGGENERAL PRIMARY KEY (ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGGEN_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (BRANCH CONSTRAINT CC_CIGDOGGEN_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGG_EXPDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (EXP_END_DATE CONSTRAINT CC_CIGDOGG_EXPDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGG_APPDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (APPLICATION_DATE CONSTRAINT CC_CIGDOGG_APPDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGG_CURID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (CURRENCY_ID CONSTRAINT CC_CIGDOGG_CURID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGG_CNTRSTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (CONTRACT_START_DATE CONSTRAINT CC_CIGDOGG_CNTRSTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGG_CNTRDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (CONTRACT_DATE CONSTRAINT CC_CIGDOGG_CNTRDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGG_CNTRCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (CONTRACT_CODE CONSTRAINT CC_CIGDOGG_CNTRCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGG_CNTRTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (CONTRACT_TYPE CONSTRAINT CC_CIGDOGG_CNTRTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGG_OPERATION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (OPERATION CONSTRAINT CC_CIGDOGG_OPERATION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_PAYPERIOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (PAY_PERIOD_ID CONSTRAINT CC_CIGDOGINST_PAYPERIOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGG_PHASEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (PHASE_ID CONSTRAINT CC_CIGDOGG_PHASEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGGENERAL_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (CUST_ID CONSTRAINT CC_CIGDOGGENERAL_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGGENERAL_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (ND CONSTRAINT CC_CIGDOGGENERAL_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGGENERAL_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL MODIFY (ID CONSTRAINT CC_CIGDOGGENERAL_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CIGDOGG_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL ADD CONSTRAINT UK_CIGDOGG_ID UNIQUE (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CIGDOGG_ND_CT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_GENERAL ADD CONSTRAINT UK_CIGDOGG_ND_CT UNIQUE (ND, CONTRACT_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CIGDOGG_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CIGDOGG_ID ON BARS.CIG_DOG_GENERAL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CIGDOGG_ND_CT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CIGDOGG_ND_CT ON BARS.CIG_DOG_GENERAL (ND, CONTRACT_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGDOGGENERAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGDOGGENERAL ON BARS.CIG_DOG_GENERAL (ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_DOG_GENERAL ***
grant SELECT,UPDATE                                                          on CIG_DOG_GENERAL to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on CIG_DOG_GENERAL to CIG_ROLE;



PROMPT *** Create SYNONYM  to CIG_DOG_GENERAL ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_DOG_GENERAL FOR BARS.CIG_DOG_GENERAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_DOG_GENERAL.sql =========*** End *
PROMPT ===================================================================================== 
