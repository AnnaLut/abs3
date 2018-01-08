

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/PERSON.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  table PERSON ***
begin 
  execute immediate '
  CREATE TABLE FINMON.PERSON 
   (	ID VARCHAR2(15), 
	CL_ID VARCHAR2(10), 
	CL_STP VARCHAR2(1), 
	CL_REZ VARCHAR2(1), 
	CL_NM1 VARCHAR2(254), 
	CL_NM2 VARCHAR2(50), 
	CL_NM3 VARCHAR2(30), 
	CL_DATE DATE, 
	DOC_NM_R VARCHAR2(21), 
	DOC_OG_R VARCHAR2(254), 
	DOC_DT_R DATE, 
	ADR_STR_U VARCHAR2(3), 
	ADR_OBL_U VARCHAR2(2), 
	ADR_U VARCHAR2(254), 
	ADR_STR_P VARCHAR2(3), 
	ADR_OBL_P VARCHAR2(2), 
	ADR_P VARCHAR2(254), 
	DOC_TYP_P VARCHAR2(2), 
	DOC_SR_P VARCHAR2(7), 
	DOC_NM_P VARCHAR2(21), 
	DOC_DT_P DATE, 
	DOC_OG_P VARCHAR2(254), 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.PERSON IS 'Каталог участников операций';
COMMENT ON COLUMN FINMON.PERSON.ID IS 'Идентификатор записи';
COMMENT ON COLUMN FINMON.PERSON.CL_ID IS 'Код ОКПО';
COMMENT ON COLUMN FINMON.PERSON.CL_STP IS 'Тип участника';
COMMENT ON COLUMN FINMON.PERSON.CL_REZ IS 'Резидентность';
COMMENT ON COLUMN FINMON.PERSON.CL_NM1 IS 'Наименование/Фамилия';
COMMENT ON COLUMN FINMON.PERSON.CL_NM2 IS 'Краткое наименование/Имя';
COMMENT ON COLUMN FINMON.PERSON.CL_NM3 IS 'Отчество';
COMMENT ON COLUMN FINMON.PERSON.CL_DATE IS 'Дата рождения';
COMMENT ON COLUMN FINMON.PERSON.DOC_NM_R IS 'Номер документа регистрации в гос.органах';
COMMENT ON COLUMN FINMON.PERSON.DOC_OG_R IS 'Зарегистрировавший орган';
COMMENT ON COLUMN FINMON.PERSON.DOC_DT_R IS 'Дата регистрации';
COMMENT ON COLUMN FINMON.PERSON.ADR_STR_U IS 'Адрес: код страны';
COMMENT ON COLUMN FINMON.PERSON.ADR_OBL_U IS 'Адрес: код области';
COMMENT ON COLUMN FINMON.PERSON.ADR_U IS 'Адрес: почтовый адрес';
COMMENT ON COLUMN FINMON.PERSON.ADR_STR_P IS 'Временный адрес: код страны';
COMMENT ON COLUMN FINMON.PERSON.ADR_OBL_P IS 'Временный адрес: код области';
COMMENT ON COLUMN FINMON.PERSON.ADR_P IS 'Временный адрес: почтовый адрес';
COMMENT ON COLUMN FINMON.PERSON.DOC_TYP_P IS 'Удостоверение физ. лица: тип документа';
COMMENT ON COLUMN FINMON.PERSON.DOC_SR_P IS 'Удостоверение физ. лица: серия документа';
COMMENT ON COLUMN FINMON.PERSON.DOC_NM_P IS 'Удостоверение физ. лица: номер документа';
COMMENT ON COLUMN FINMON.PERSON.DOC_DT_P IS 'Удостоверение физ. лица: дата выдачи';
COMMENT ON COLUMN FINMON.PERSON.DOC_OG_P IS 'Удостоверение физ. лица: орган, что выдал документ';
COMMENT ON COLUMN FINMON.PERSON.BRANCH_ID IS '';




PROMPT *** Create  constraint R_PERSON_KDFM11_U ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON ADD CONSTRAINT R_PERSON_KDFM11_U FOREIGN KEY (ADR_OBL_U)
	  REFERENCES FINMON.K_DFM11 (CODE) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PERSON_KDFM11_P ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON ADD CONSTRAINT R_PERSON_KDFM11_P FOREIGN KEY (ADR_OBL_P)
	  REFERENCES FINMON.K_DFM11 (CODE) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PERSON_KDFM07 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON ADD CONSTRAINT R_PERSON_KDFM07 FOREIGN KEY (CL_STP)
	  REFERENCES FINMON.K_DFM07 (CODE) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PERSON_KDFM04 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON ADD CONSTRAINT R_PERSON_KDFM04 FOREIGN KEY (DOC_TYP_P)
	  REFERENCES FINMON.K_DFM04 (CODE) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PERSON_BANK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON ADD CONSTRAINT R_PERSON_BANK FOREIGN KEY (BRANCH_ID)
	  REFERENCES FINMON.BANK (ID) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_PERSON ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON ADD CONSTRAINT XPK_PERSON PRIMARY KEY (ID, BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE SYSTEM  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PERSON_KDFM12 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON ADD CONSTRAINT R_PERSON_KDFM12 FOREIGN KEY (CL_REZ)
	  REFERENCES FINMON.K_DFM12 (CODE) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_PERSON_CLNM1 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON MODIFY (CL_NM1 CONSTRAINT NK_PERSON_CLNM1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_PERSON_CLREZ ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON MODIFY (CL_REZ CONSTRAINT NK_PERSON_CLREZ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_PERSON_CLSTP ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON MODIFY (CL_STP CONSTRAINT NK_PERSON_CLSTP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_PERSON_CLID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON MODIFY (CL_ID CONSTRAINT NK_PERSON_CLID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PERSON ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_PERSON ON FINMON.PERSON (ID, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE SYSTEM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_PERSON ***
begin   
 execute immediate '
  CREATE INDEX FINMON.XAK_PERSON ON FINMON.PERSON (CL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PERSON ***
grant SELECT                                                                 on PERSON          to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/PERSON.sql =========*** End *** ====
PROMPT ===================================================================================== 
