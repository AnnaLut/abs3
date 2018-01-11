

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_REL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_REL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_REL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_REL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_REL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_REL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_REL 
   (	RNK NUMBER(22,0), 
	REL_ID NUMBER(22,0), 
	REL_RNK NUMBER(22,0), 
	REL_INTEXT NUMBER(1,0), 
	VAGA1 NUMBER(14,10), 
	VAGA2 NUMBER(14,10), 
	TYPE_ID NUMBER(22,0) DEFAULT 1, 
	POSITION VARCHAR2(100), 
	FIRST_NAME VARCHAR2(70), 
	MIDDLE_NAME VARCHAR2(70), 
	LAST_NAME VARCHAR2(70), 
	DOCUMENT_TYPE_ID NUMBER(22,0) DEFAULT 3, 
	DOCUMENT VARCHAR2(70), 
	TRUST_REGNUM VARCHAR2(38), 
	TRUST_REGDAT DATE, 
	BDATE DATE, 
	EDATE DATE, 
	NOTARY_NAME VARCHAR2(70), 
	NOTARY_REGION VARCHAR2(70), 
	SIGN_PRIVS NUMBER(1,0) DEFAULT 0, 
	SIGN_ID NUMBER(22,0), 
	NAME_R VARCHAR2(100), 
	POSITION_R VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_REL ***
 exec bpa.alter_policies('CUSTOMER_REL');


COMMENT ON TABLE BARS.CUSTOMER_REL IS 'История обновлений: Лица, имеющие отношение к клиенту';
COMMENT ON COLUMN BARS.CUSTOMER_REL.POSITION_R IS 'Должность в родительном падеже';
COMMENT ON COLUMN BARS.CUSTOMER_REL.RNK IS 'РНК';
COMMENT ON COLUMN BARS.CUSTOMER_REL.REL_ID IS 'Код отношения';
COMMENT ON COLUMN BARS.CUSTOMER_REL.REL_RNK IS 'РНК связанного лица';
COMMENT ON COLUMN BARS.CUSTOMER_REL.REL_INTEXT IS 'Тип связанного лица (1-клиент банка, 0-НЕклиент банка)';
COMMENT ON COLUMN BARS.CUSTOMER_REL.VAGA1 IS 'Удельный вес прямого участия в уставном фонде';
COMMENT ON COLUMN BARS.CUSTOMER_REL.VAGA2 IS 'Удельный вес опосредствованного участия в уставном фонде';
COMMENT ON COLUMN BARS.CUSTOMER_REL.TYPE_ID IS 'Идентификатор типа довереного лица';
COMMENT ON COLUMN BARS.CUSTOMER_REL.POSITION IS 'Должность';
COMMENT ON COLUMN BARS.CUSTOMER_REL.FIRST_NAME IS 'ФИО Имя/Наименование';
COMMENT ON COLUMN BARS.CUSTOMER_REL.MIDDLE_NAME IS 'ФИО Отчество';
COMMENT ON COLUMN BARS.CUSTOMER_REL.LAST_NAME IS 'ФИО Фамилия';
COMMENT ON COLUMN BARS.CUSTOMER_REL.DOCUMENT_TYPE_ID IS 'Идентификатор типа документа, на основании которого ФЛ является довереным лицом';
COMMENT ON COLUMN BARS.CUSTOMER_REL.DOCUMENT IS 'Документ доверенности';
COMMENT ON COLUMN BARS.CUSTOMER_REL.TRUST_REGNUM IS 'Номер регистрации доверенности';
COMMENT ON COLUMN BARS.CUSTOMER_REL.TRUST_REGDAT IS 'Дата регистрации доверенности';
COMMENT ON COLUMN BARS.CUSTOMER_REL.BDATE IS 'Дата начала действия доверенности';
COMMENT ON COLUMN BARS.CUSTOMER_REL.EDATE IS 'Дата окончания действия доверенности';
COMMENT ON COLUMN BARS.CUSTOMER_REL.NOTARY_NAME IS 'ФИО нотариуса';
COMMENT ON COLUMN BARS.CUSTOMER_REL.NOTARY_REGION IS 'Нотариальный округ';
COMMENT ON COLUMN BARS.CUSTOMER_REL.SIGN_PRIVS IS 'Есть ли у доверенного лица право подписи (0/1)';
COMMENT ON COLUMN BARS.CUSTOMER_REL.SIGN_ID IS 'Идентификатор графического представления подписи доверенного лица';
COMMENT ON COLUMN BARS.CUSTOMER_REL.NAME_R IS 'ФИО доверенного лица в родительном падеже';




PROMPT *** Create  constraint PK_CUSTOMERREL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT PK_CUSTOMERREL PRIMARY KEY (RNK, REL_ID, REL_RNK, REL_INTEXT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERREL_RELINTEXT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT CC_CUSTOMERREL_RELINTEXT CHECK (rel_intext in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERREL_SIGNPRIVS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT CC_CUSTOMERREL_SIGNPRIVS CHECK (sign_privs in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERREL_TYPEID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT CC_CUSTOMERREL_TYPEID CHECK (decode(rel_id, 20, type_id, 0) is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERREL_SIGNPRIVS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT CC_CUSTOMERREL_SIGNPRIVS2 CHECK (decode(rel_id, 20, sign_privs, 0) is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERREL_VAGA1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT CC_CUSTOMERREL_VAGA1 CHECK (vaga1<=100) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERREL_VAGA2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT CC_CUSTOMERREL_VAGA2 CHECK (vaga2<=100) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERREL_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL MODIFY (RNK CONSTRAINT CC_CUSTOMERREL_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERREL_RELID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL MODIFY (REL_ID CONSTRAINT CC_CUSTOMERREL_RELID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERREL_RELRNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL MODIFY (REL_RNK CONSTRAINT CC_CUSTOMERREL_RELRNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERREL_RELINTEXT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL MODIFY (REL_INTEXT CONSTRAINT CC_CUSTOMERREL_RELINTEXT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERREL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERREL ON BARS.CUSTOMER_REL (RNK, REL_ID, REL_RNK, REL_INTEXT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_REL ***
grant SELECT                                                                 on CUSTOMER_REL    to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMER_REL    to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_REL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_REL    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_REL    to CUST001;
grant SELECT                                                                 on CUSTOMER_REL    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_REL    to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUSTOMER_REL    to WR_CUSTREG;



PROMPT *** Create SYNONYM  to CUSTOMER_REL ***

  CREATE OR REPLACE PUBLIC SYNONYM CUSTOMER_REL FOR BARS.CUSTOMER_REL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_REL.sql =========*** End *** 
PROMPT ===================================================================================== 
