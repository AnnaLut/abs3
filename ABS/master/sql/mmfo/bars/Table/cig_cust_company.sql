

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_CUST_COMPANY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_CUST_COMPANY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_CUST_COMPANY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_CUST_COMPANY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_CUST_COMPANY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_CUST_COMPANY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_CUST_COMPANY 
   (	CUST_ID NUMBER(38,0), 
	ROLE_ID NUMBER(4,0), 
	STATUS_ID NUMBER(4,0), 
	LANG_NAME VARCHAR2(5), 
	NAME VARCHAR2(250), 
	LANG_ABBREVIATION VARCHAR2(5), 
	ABBREVIATION VARCHAR2(182), 
	OWNERSHIP NUMBER(4,0), 
	REGISTR_DATE DATE, 
	ECONOMIC_ACTIVITY NUMBER(4,0), 
	EMPLOYE_COUNT NUMBER(4,0), 
	REG_NUM VARCHAR2(14), 
	PHONE_OFFICE VARCHAR2(20), 
	PHONE_MOBILE VARCHAR2(20), 
	PHONE_FAX VARCHAR2(20), 
	EMAIL VARCHAR2(38), 
	WEBSITE VARCHAR2(38), 
	FACT_TERRITORY_ID NUMBER, 
	FACT_STREET_BUILDNUM VARCHAR2(250), 
	FACT_POST_INDEX VARCHAR2(20), 
	REG_TERRITORY_ID NUMBER, 
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




PROMPT *** ALTER_POLICIES to CIG_CUST_COMPANY ***
 exec bpa.alter_policies('CIG_CUST_COMPANY');


COMMENT ON TABLE BARS.CIG_CUST_COMPANY IS 'Таблиця персональних відомостей ЮО';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.CUST_ID IS 'Код клієнта';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.ROLE_ID IS 'Опис ролі суб`єкта (D02)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.STATUS_ID IS 'Статус діяльності(D12)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.LANG_NAME IS 'Мова написання повного найменування підприємства ';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.NAME IS 'Повне найменування';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.LANG_ABBREVIATION IS 'Мова написання скороченого найменування підприємства';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.ABBREVIATION IS 'Скорочене найменування';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.OWNERSHIP IS 'Форма власності(D10)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.REGISTR_DATE IS 'Дата державної  реєстрації';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.ECONOMIC_ACTIVITY IS 'Класифікатор економічної діяльності(D11)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.EMPLOYE_COUNT IS 'Кількість працюючих(D22)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.REG_NUM IS 'Номер запису про державну реестрацію(підприємці)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.PHONE_OFFICE IS 'Номер телефону(робочий)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.PHONE_MOBILE IS 'Номер телефону(мобільний)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.PHONE_FAX IS 'Номер телефону(Факс)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.EMAIL IS 'Адреса електронної пошти';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.WEBSITE IS 'Адреса Web-сторінки';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.FACT_TERRITORY_ID IS 'Код населенного пункту(Фактична адреса)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.FACT_STREET_BUILDNUM IS 'Вулиця, №будинку, літера будинку, поверх.(Фактична адреса)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.FACT_POST_INDEX IS 'Почтовий індекс(Фактична адреса)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.REG_TERRITORY_ID IS 'Код населеного пункту(Юридична адреса)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.REG_STREET_BUILDNUM IS 'Вулиця, №будинку, літера будинку, поверх(Юридична адреса)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.REG_POST_INDEX IS 'Почтовий індекс(Юридична адреса)';
COMMENT ON COLUMN BARS.CIG_CUST_COMPANY.BRANCH IS '';




PROMPT *** Create  constraint CC_CIGCUSTCOMP_STATUSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (STATUS_ID CONSTRAINT CC_CIGCUSTCOMP_STATUSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTOMP_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (BRANCH CONSTRAINT CC_CIGCUSTOMP_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (CUST_ID CONSTRAINT CC_CIGCUSTCOMP_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIGCUSTCOMP_CIGCUSTOMERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY ADD CONSTRAINT FK_CIGCUSTCOMP_CIGCUSTOMERS FOREIGN KEY (CUST_ID, BRANCH)
	  REFERENCES BARS.CIG_CUSTOMERS (CUST_ID, BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIGCUSTCOMP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY ADD CONSTRAINT PK_CIGCUSTCOMP PRIMARY KEY (CUST_ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_LANGNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (LANG_NAME CONSTRAINT CC_CIGCUSTCOMP_LANGNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (NAME CONSTRAINT CC_CIGCUSTCOMP_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_LANGABBREV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (LANG_ABBREVIATION CONSTRAINT CC_CIGCUSTCOMP_LANGABBREV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_ABBREV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (ABBREVIATION CONSTRAINT CC_CIGCUSTCOMP_ABBREV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_OWNERSHIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (OWNERSHIP CONSTRAINT CC_CIGCUSTCOMP_OWNERSHIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_REGISTRDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (REGISTR_DATE CONSTRAINT CC_CIGCUSTCOMP_REGISTRDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_FACTTERRIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (FACT_TERRITORY_ID CONSTRAINT CC_CIGCUSTCOMP_FACTTERRIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_FACSTBUNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (FACT_STREET_BUILDNUM CONSTRAINT CC_CIGCUSTCOMP_FACSTBUNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_REGSTBUNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (REG_STREET_BUILDNUM CONSTRAINT CC_CIGCUSTCOMP_REGSTBUNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCOMP_ROLEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY MODIFY (ROLE_ID CONSTRAINT CC_CIGCUSTCOMP_ROLEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGCUSTCOMP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGCUSTCOMP ON BARS.CIG_CUST_COMPANY (CUST_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_CUST_COMPANY ***
grant SELECT                                                                 on CIG_CUST_COMPANY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_CUST_COMPANY to BARS_DM;
grant SELECT                                                                 on CIG_CUST_COMPANY to CIG_ROLE;



PROMPT *** Create SYNONYM  to CIG_CUST_COMPANY ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_CUST_COMPANY FOR BARS.CIG_CUST_COMPANY;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_CUST_COMPANY.sql =========*** End 
PROMPT ===================================================================================== 
