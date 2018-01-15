

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_CUST_INDIVIDUAL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_CUST_INDIVIDUAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_CUST_INDIVIDUAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_CUST_INDIVIDUAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_CUST_INDIVIDUAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_CUST_INDIVIDUAL 
   (	CUST_ID NUMBER(38,0), 
	ROLE_ID NUMBER(4,0), 
	FIRST_NAME VARCHAR2(38), 
	SURNAME VARCHAR2(38), 
	FATHERS_NAME VARCHAR2(38), 
	GENDER NUMBER(1,0), 
	CLASSIFICATION NUMBER(4,0), 
	BIRTH_SURNAME VARCHAR2(38), 
	DATE_BIRTH DATE, 
	PLACE_BIRTH VARCHAR2(70), 
	RESIDENCY NUMBER(4,0), 
	CITIZENSHIP CHAR(2), 
	NEG_STATUS NUMBER(4,0), 
	EDUCATION NUMBER(4,0), 
	MARITAL_STATUS NUMBER(4,0), 
	POSITION NUMBER(4,0), 
	CUST_KEY VARCHAR2(70), 
	PASSP_SER VARCHAR2(10), 
	PASSP_NUM VARCHAR2(20), 
	PASSP_ISS_DATE DATE, 
	PASSP_EXP_DATE DATE, 
	PASSP_ORGAN VARCHAR2(70), 
	PHONE_OFFICE VARCHAR2(20), 
	PHONE_MOBILE VARCHAR2(20), 
	PHONE_FAX VARCHAR2(20), 
	EMAIL VARCHAR2(38), 
	WEBSITE VARCHAR2(38), 
	FACT_TERRITORY_ID NUMBER(38,0), 
	FACT_STREET_BUILDNUM VARCHAR2(250), 
	FACT_POST_INDEX VARCHAR2(20), 
	REG_TERRITORY_ID NUMBER(38,0), 
	REG_STREET_BUILDNUM VARCHAR2(250), 
	REG_POST_INDEX VARCHAR2(20), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_CUST_INDIVIDUAL ***
 exec bpa.alter_policies('CIG_CUST_INDIVIDUAL');


COMMENT ON TABLE BARS.CIG_CUST_INDIVIDUAL IS '������� ������������ ��������� ��';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.CUST_ID IS '��� �볺���';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.ROLE_ID IS '���� ��� ���`���� (D02)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.FIRST_NAME IS '��`� �����';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.SURNAME IS '������� �����';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.FATHERS_NAME IS '�� �������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.GENDER IS '�����';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.CLASSIFICATION IS '������������ ���`���� (D01)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.BIRTH_SURNAME IS '������� ��� ���������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.DATE_BIRTH IS '���� ����������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PLACE_BIRTH IS '̳��� ����������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.RESIDENCY IS '�������� (D03)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.CITIZENSHIP IS '';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.NEG_STATUS IS '���������� ������ (D05)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.EDUCATION IS '����� (D07)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.MARITAL_STATUS IS 'ѳ������ ���� (D08)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.POSITION IS '������ ��������� ����� (D09)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.CUST_KEY IS '��������� ���� ("���" + "�������" + "���� ����������")';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PASSP_SER IS '���� ��������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PASSP_NUM IS '����� ��������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PASSP_ISS_DATE IS '���� ������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PASSP_EXP_DATE IS '���� ��������� 䳿 ���������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PASSP_ORGAN IS '��� ������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PHONE_OFFICE IS '����� ��������(�������)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PHONE_MOBILE IS '����� ��������(��������)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PHONE_FAX IS '����� ��������(����)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.EMAIL IS '������ ���������� �����';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.WEBSITE IS '������ Web-�������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.FACT_TERRITORY_ID IS '��� ����������� ������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.FACT_STREET_BUILDNUM IS '������, ��������, ����� �������, ������.';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.FACT_POST_INDEX IS '�������� ������';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.REG_TERRITORY_ID IS '��� ���������� ������(������������)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.REG_STREET_BUILDNUM IS '������, ��������, ����� �������, ������(������������)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.REG_POST_INDEX IS '�������� ������(������������)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.BRANCH IS '';


PROMPT *** Create  constraint FK_CIGCUSTIND_FACRTERRIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL ADD CONSTRAINT FK_CIGCUSTIND_FACRTERRIT FOREIGN KEY (FACT_TERRITORY_ID)
	  REFERENCES BARS.TERRITORY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIGCUSTIND_D06 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL ADD CONSTRAINT FK_CIGCUSTIND_D06 FOREIGN KEY (GENDER)
	  REFERENCES BARS.CIG_D06 (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIGCUSTIND_CIGCUSTOMERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL ADD CONSTRAINT FK_CIGCUSTIND_CIGCUSTOMERS FOREIGN KEY (CUST_ID, BRANCH)
	  REFERENCES BARS.CIG_CUSTOMERS (CUST_ID, BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIGCUSTIND_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL ADD CONSTRAINT FK_CIGCUSTIND_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIGCUSTIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL ADD CONSTRAINT PK_CIGCUSTIND PRIMARY KEY (CUST_ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_SEX ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL ADD CONSTRAINT CC_CIGCUSTIND_SEX CHECK (gender in (1,2,0)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (BRANCH CONSTRAINT CC_CIGCUSTIND_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_FACSTBUNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (FACT_STREET_BUILDNUM CONSTRAINT CC_CIGCUSTIND_FACSTBUNUM_NN NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_FACTTERRIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (FACT_TERRITORY_ID CONSTRAINT CC_CIGCUSTIND_FACTTERRIT_NN NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_PASSPORGAN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (PASSP_ORGAN CONSTRAINT CC_CIGCUSTIND_PASSPORGAN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_PASSPIDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (PASSP_ISS_DATE CONSTRAINT CC_CIGCUSTIND_PASSPIDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_PASSPNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (PASSP_NUM CONSTRAINT CC_CIGCUSTIND_PASSPNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_PASSPSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (PASSP_SER CONSTRAINT CC_CIGCUSTIND_PASSPSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_CUSTKEY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (CUST_KEY CONSTRAINT CC_CIGCUSTIND_CUSTKEY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_POSITION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (POSITION CONSTRAINT CC_CIGCUSTIND_POSITION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_CITIZENSHIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (CITIZENSHIP CONSTRAINT CC_CIGCUSTIND_CITIZENSHIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_RESIDENCY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (RESIDENCY CONSTRAINT CC_CIGCUSTIND_RESIDENCY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_DATEBIRTH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (DATE_BIRTH CONSTRAINT CC_CIGCUSTIND_DATEBIRTH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_CLASSIFICAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (CLASSIFICATION CONSTRAINT CC_CIGCUSTIND_CLASSIFICAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_GENDER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (GENDER CONSTRAINT CC_CIGCUSTIND_GENDER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_SURNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (SURNAME CONSTRAINT CC_CIGCUSTIND_SURNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_FIRSTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (FIRST_NAME CONSTRAINT CC_CIGCUSTIND_FIRSTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_ROLEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (ROLE_ID CONSTRAINT CC_CIGCUSTIND_ROLEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (CUST_ID CONSTRAINT CC_CIGCUSTIND_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGCUSTIND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGCUSTIND ON BARS.CIG_CUST_INDIVIDUAL (CUST_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_CUST_INDIVIDUAL ***
grant SELECT                                                                 on CIG_CUST_INDIVIDUAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_CUST_INDIVIDUAL to CIG_ROLE;



PROMPT *** Create SYNONYM  to CIG_CUST_INDIVIDUAL ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_CUST_INDIVIDUAL FOR BARS.CIG_CUST_INDIVIDUAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_CUST_INDIVIDUAL.sql =========*** E
PROMPT ===================================================================================== 
