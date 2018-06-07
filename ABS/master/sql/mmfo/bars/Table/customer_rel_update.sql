

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_REL_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_REL_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_REL_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUSTOMER_REL_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMER_REL_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_REL_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_REL_UPDATE 
   (	IDUPD NUMBER(22,0), 
	CHGDATE DATE, 
	CHGACTION NUMBER(1,0), 
	DONEBY VARCHAR2(64), 
	RNK NUMBER(22,0), 
	REL_ID NUMBER(22,0), 
	REL_RNK NUMBER(22,0), 
	REL_INTEXT NUMBER(1,0), 
	VAGA1 NUMBER(8,4), 
	VAGA2 NUMBER(8,4), 
	TYPE_ID NUMBER(22,0), 
	POSITION VARCHAR2(100), 
	FIRST_NAME VARCHAR2(70), 
	MIDDLE_NAME VARCHAR2(70), 
	LAST_NAME VARCHAR2(70), 
	DOCUMENT_TYPE_ID NUMBER(22,0), 
	DOCUMENT VARCHAR2(70), 
	TRUST_REGNUM VARCHAR2(38), 
	TRUST_REGDAT DATE, 
	BDATE DATE, 
	EDATE DATE, 
	NOTARY_NAME VARCHAR2(70), 
	NOTARY_REGION VARCHAR2(70), 
	SIGN_PRIVS NUMBER(1,0), 
	SIGN_ID NUMBER(22,0), 
	NAME_R VARCHAR2(100), 
	EFFECTDATE DATE, 
	GLOBAL_BDATE DATE, 
	POSITION_R VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_REL_UPDATE ***
 exec bpa.alter_policies('CUSTOMER_REL_UPDATE');


COMMENT ON TABLE BARS.CUSTOMER_REL_UPDATE IS 'Історія змін: Лица, имеющие отношение к клиенту';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.TRUST_REGDAT IS 'Дата регистрации доверенности';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.BDATE IS 'Дата начала действия доверенности';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.EDATE IS 'Дата окончания действия доверенности';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.NOTARY_NAME IS 'ПІБ нотаріуса';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.NOTARY_REGION IS 'Нотаріальний округ';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.SIGN_PRIVS IS 'Наявність права підпису в довіреної особи (0/1)';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.SIGN_ID IS 'Идентификатор графического представления подписи доверенного лица';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.NAME_R IS 'ФИО доверенного лица в родительном падеже';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.EFFECTDATE IS 'Локальна  банківська дата зміни';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.GLOBAL_BDATE IS 'Глобальна банківська дата зміни';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.POSITION_R IS 'Должность в родительном падеже';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.IDUPD IS 'Ідентифікатор зміни';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.CHGDATE IS 'Календарна дата зміни';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.CHGACTION IS 'Код типу зміни';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.DONEBY IS 'Ідентифікатор користувача, що виконав зміни';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.RNK IS 'РНК';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.REL_ID IS 'Код отношения';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.REL_RNK IS 'РНК або ідентифікатор НЕклієнта банку пов`язаної особи';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.REL_INTEXT IS 'Тип пов`язаної особи (1-клієнт, 0-НЕклієнт банку)';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.VAGA1 IS 'Удельный вес прямого участия в уставном фонде';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.VAGA2 IS 'Удельный вес опосредствованного участия в уставном фонде';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.TYPE_ID IS 'Идентификатор типа довереного лица';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.POSITION IS 'Посада';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.FIRST_NAME IS 'ПІБ: Імя/Назва';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.MIDDLE_NAME IS 'ПІБ: Отчество';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.LAST_NAME IS 'ПІБ: Прізвище';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.DOCUMENT_TYPE_ID IS 'Идентификатор типа документа, на основании которого ФЛ является довереным лицом';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.DOCUMENT IS 'Документ доверенности';
COMMENT ON COLUMN BARS.CUSTOMER_REL_UPDATE.TRUST_REGNUM IS 'Номер регистрации доверенности';




PROMPT *** Create  constraint CC_CUSTOMERRELUPDATE_CHGACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE ADD CONSTRAINT CC_CUSTOMERRELUPDATE_CHGACTION CHECK (chgaction in (1,2,3)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMERRELUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE ADD CONSTRAINT PK_CUSTOMERRELUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_CUSTOMERRELUPD_GLOBALBD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE ADD CONSTRAINT CC_CUSTOMERRELUPDATE_KF_NN CHECK (KF IS NOT NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE MODIFY (IDUPD CONSTRAINT CC_CUSTOMERRELUPD_IDUPD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE MODIFY (CHGDATE CONSTRAINT CC_CUSTOMERRELUPD_CHGDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE MODIFY (CHGACTION CONSTRAINT CC_CUSTOMERRELUPD_CHGACTION_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE MODIFY (DONEBY CONSTRAINT CC_CUSTOMERRELUPD_DONEBY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPD_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE MODIFY (RNK CONSTRAINT CC_CUSTOMERRELUPD_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPD_RELID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE MODIFY (REL_ID CONSTRAINT CC_CUSTOMERRELUPD_RELID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPD_RELRNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE MODIFY (REL_RNK CONSTRAINT CC_CUSTOMERRELUPD_RELRNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPD_RELINTEXT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE MODIFY (REL_INTEXT CONSTRAINT CC_CUSTOMERRELUPD_RELINTEXT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERRELUPD_EFFECTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_CUSTOMERRELUPD_EFFECTDT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CUSTOMERRELUPD_RNK_RELID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CUSTOMERRELUPD_RNK_RELID ON BARS.CUSTOMER_REL_UPDATE (RNK, REL_ID, REL_RNK, REL_INTEXT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CUSTOMERRELUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CUSTOMERRELUPD_GLBDT_EFFDT ON BARS.CUSTOMER_REL_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERRELUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERRELUPDATE ON BARS.CUSTOMER_REL_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

prompt CREATE UQ INDEX CUSTOMER_REL_UPDATE : I_KF_IDUPD_KEY_CUSTRELSUPD (KF, IDUPD, RNK, REL_RNK, REL_ID, REL_INTEXT)
begin
    execute immediate q'[
create unique index I_KF_IDUPD_KEY_CUSTRELSUPD on customer_rel_update (kf, idupd, rnk, rel_rnk, rel_id, rel_intext) 
GLOBAL PARTITION BY RANGE (KF)
( PARTITION CUSTRELUPD_MIN values less than ('300465')
, PARTITION CUSTRELUPD_300465 values less than ('302076')
, PARTITION CUSTRELUPD_302076 values less than ('303398')
, PARTITION CUSTRELUPD_303398 values less than ('304665')
, PARTITION CUSTRELUPD_304665 values less than ('305482')
, PARTITION CUSTRELUPD_305482 values less than ('311647')
, PARTITION CUSTRELUPD_311647 values less than ('312356')
, PARTITION CUSTRELUPD_312356 values less than ('313957')
, PARTITION CUSTRELUPD_313957 values less than ('315784')
, PARTITION CUSTRELUPD_315784 values less than ('322669')
, PARTITION CUSTRELUPD_322669 values less than ('323475')
, PARTITION CUSTRELUPD_323475 values less than ('324805')
, PARTITION CUSTRELUPD_324805 values less than ('325796')
, PARTITION CUSTRELUPD_325796 values less than ('326461')
, PARTITION CUSTRELUPD_326461 values less than ('328845')
, PARTITION CUSTRELUPD_328845 values less than ('331467')
, PARTITION CUSTRELUPD_331467 values less than ('333368')
, PARTITION CUSTRELUPD_333368 values less than ('335106')
, PARTITION CUSTRELUPD_335106 values less than ('336503')
, PARTITION CUSTRELUPD_336503 values less than ('337568')
, PARTITION CUSTRELUPD_337568 values less than ('338545')
, PARTITION CUSTRELUPD_338545 values less than ('351823')
, PARTITION CUSTRELUPD_351823 values less than ('352457')
, PARTITION CUSTRELUPD_352457 values less than ('353553')
, PARTITION CUSTRELUPD_353553 values less than ('354507')
, PARTITION CUSTRELUPD_354507 values less than ('356334')
, PARTITION CUSTRELUPD_356334 values less than (maxvalue)
)
tablespace brsbigi compress 1
online]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/


PROMPT *** Create  grants  CUSTOMER_REL_UPDATE ***
grant SELECT                                                                 on CUSTOMER_REL_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMER_REL_UPDATE to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_REL_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_REL_UPDATE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_REL_UPDATE to CUST001;
grant SELECT                                                                 on CUSTOMER_REL_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_REL_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
