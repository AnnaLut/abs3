

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_CUST_INDIVIDUAL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_CUST_INDIVIDUAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_CUST_INDIVIDUAL'', ''CENTER'' , null, null, null, null);
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


COMMENT ON TABLE BARS.CIG_CUST_INDIVIDUAL IS 'Таблиця персональних відомостей ФО';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.CUST_ID IS 'Код клієнта';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.ROLE_ID IS 'Опис ролі суб`єкта (D02)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.FIRST_NAME IS 'Ім`я особи';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.SURNAME IS 'Прізвище особи';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.FATHERS_NAME IS 'По батькові';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.GENDER IS 'Стать';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.CLASSIFICATION IS 'Класифікація суб`єкта (D01)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.BIRTH_SURNAME IS 'Прізвище при народженні';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.DATE_BIRTH IS 'Дата народження';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PLACE_BIRTH IS 'Місце народження';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.RESIDENCY IS 'Резидент (D03)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.CITIZENSHIP IS '';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.NEG_STATUS IS 'Негативний статус (D05)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.EDUCATION IS 'Освіта (D07)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.MARITAL_STATUS IS 'Сімейний стан (D08)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.POSITION IS 'Статус зайнятості особи (D09)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.CUST_KEY IS 'Складений ключ ("імя" + "прізвище" + "дата народження")';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PASSP_SER IS 'Серія паспорта';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PASSP_NUM IS 'Номер паспорта';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PASSP_ISS_DATE IS 'Дата видачі';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PASSP_EXP_DATE IS 'Дата закінчення дії документа';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PASSP_ORGAN IS 'Ким видано';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PHONE_OFFICE IS 'Номер телефону(робочий)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PHONE_MOBILE IS 'Номер телефону(мобільний)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.PHONE_FAX IS 'Номер телефону(Факс)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.EMAIL IS 'Адреса електронної пошти';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.WEBSITE IS 'Адреса Web-сторінки';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.FACT_TERRITORY_ID IS 'Код населенного пункту';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.FACT_STREET_BUILDNUM IS 'Вулиця, №будинку, літера будинку, поверх.';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.FACT_POST_INDEX IS 'Почтовий індекс';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.REG_TERRITORY_ID IS 'Код населеного пункту(необовязково)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.REG_STREET_BUILDNUM IS 'Вулиця, №будинку, літера будинку, поверх(необовязково)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.REG_POST_INDEX IS 'Почтовий індекс(необовязково)';
COMMENT ON COLUMN BARS.CIG_CUST_INDIVIDUAL.BRANCH IS '';




PROMPT *** Create  constraint PK_CIGCUSTIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL ADD CONSTRAINT PK_CIGCUSTIND PRIMARY KEY (CUST_ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_SEX ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL ADD CONSTRAINT CC_CIGCUSTIND_SEX CHECK (gender in (1,2,0)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_FACSTBUNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (FACT_STREET_BUILDNUM CONSTRAINT CC_CIGCUSTIND_FACSTBUNUM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_PASSPNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (PASSP_NUM CONSTRAINT CC_CIGCUSTIND_PASSPNUM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_PASSPIDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (PASSP_ISS_DATE CONSTRAINT CC_CIGCUSTIND_PASSPIDAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_PASSPORGAN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (PASSP_ORGAN CONSTRAINT CC_CIGCUSTIND_PASSPORGAN_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_FACTTERRIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (FACT_TERRITORY_ID CONSTRAINT CC_CIGCUSTIND_FACTTERRIT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (BRANCH CONSTRAINT CC_CIGCUSTIND_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (CUST_ID CONSTRAINT CC_CIGCUSTIND_CUSTID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_ROLEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (ROLE_ID CONSTRAINT CC_CIGCUSTIND_ROLEID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_FIRSTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (FIRST_NAME CONSTRAINT CC_CIGCUSTIND_FIRSTNAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_SURNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (SURNAME CONSTRAINT CC_CIGCUSTIND_SURNAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_GENDER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (GENDER CONSTRAINT CC_CIGCUSTIND_GENDER_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_CLASSIFICAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (CLASSIFICATION CONSTRAINT CC_CIGCUSTIND_CLASSIFICAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_DATEBIRTH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (DATE_BIRTH CONSTRAINT CC_CIGCUSTIND_DATEBIRTH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_RESIDENCY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (RESIDENCY CONSTRAINT CC_CIGCUSTIND_RESIDENCY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_CITIZENSHIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (CITIZENSHIP CONSTRAINT CC_CIGCUSTIND_CITIZENSHIP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_POSITION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (POSITION CONSTRAINT CC_CIGCUSTIND_POSITION_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_CUSTKEY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (CUST_KEY CONSTRAINT CC_CIGCUSTIND_CUSTKEY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTIND_PASSPSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_INDIVIDUAL MODIFY (PASSP_SER CONSTRAINT CC_CIGCUSTIND_PASSPSER_NN NOT NULL ENABLE NOVALIDATE)';
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
grant SELECT                                                                 on CIG_CUST_INDIVIDUAL to BARSREADER_ROLE;
grant SELECT                                                                 on CIG_CUST_INDIVIDUAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_CUST_INDIVIDUAL to BARS_DM;
grant SELECT                                                                 on CIG_CUST_INDIVIDUAL to CIG_ROLE;
grant SELECT                                                                 on CIG_CUST_INDIVIDUAL to UPLD;



PROMPT *** Create SYNONYM  to CIG_CUST_INDIVIDUAL ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_CUST_INDIVIDUAL FOR BARS.CIG_CUST_INDIVIDUAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_CUST_INDIVIDUAL.sql =========*** E
PROMPT ===================================================================================== 
