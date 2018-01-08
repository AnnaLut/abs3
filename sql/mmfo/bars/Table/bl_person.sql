

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_PERSON.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_PERSON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_PERSON'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_PERSON'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_PERSON'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_PERSON ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_PERSON 
   (	PERSON_ID NUMBER, 
	INN VARCHAR2(10), 
	LNAME VARCHAR2(50), 
	FNAME VARCHAR2(50), 
	MNAME VARCHAR2(50), 
	BDATE DATE, 
	INN_DATE DATE, 
	INS_DATE DATE, 
	USER_ID NUMBER, 
	BASE_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_PERSON ***
 exec bpa.alter_policies('BL_PERSON');


COMMENT ON TABLE BARS.BL_PERSON IS 'ФИЗЛИЦА';
COMMENT ON COLUMN BARS.BL_PERSON.PERSON_ID IS 'Уникальный идентификатор.';
COMMENT ON COLUMN BARS.BL_PERSON.INN IS 'Идентификационный налоговый номер.';
COMMENT ON COLUMN BARS.BL_PERSON.LNAME IS 'Фамилия';
COMMENT ON COLUMN BARS.BL_PERSON.FNAME IS 'Имя';
COMMENT ON COLUMN BARS.BL_PERSON.MNAME IS 'Отчество';
COMMENT ON COLUMN BARS.BL_PERSON.BDATE IS 'Дата рождения';
COMMENT ON COLUMN BARS.BL_PERSON.INN_DATE IS 'Дата выдачи идентификационного налогового номера';
COMMENT ON COLUMN BARS.BL_PERSON.INS_DATE IS 'Дата добавления записи';
COMMENT ON COLUMN BARS.BL_PERSON.USER_ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.BL_PERSON.BASE_ID IS '';




PROMPT *** Create  constraint NN_BL_PERSON_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PERSON MODIFY (PERSON_ID CONSTRAINT NN_BL_PERSON_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PERSON_USER ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PERSON MODIFY (USER_ID CONSTRAINT NN_BL_PERSON_USER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PERSON_BASE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PERSON MODIFY (BASE_ID CONSTRAINT NN_BL_PERSON_BASE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint BL_PERSON_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PERSON ADD CONSTRAINT BL_PERSON_PK PRIMARY KEY (BASE_ID, PERSON_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_PERSON_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.BL_PERSON_PK ON BARS.BL_PERSON (BASE_ID, PERSON_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_PERSON_INN ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_PERSON_INN ON BARS.BL_PERSON (INN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_PERSON_FIO ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_PERSON_FIO ON BARS.BL_PERSON (LNAME, FNAME, MNAME, BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_PERSON ***
grant SELECT                                                                 on BL_PERSON       to BARSREADER_ROLE;
grant SELECT                                                                 on BL_PERSON       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BL_PERSON       to RBL;
grant SELECT                                                                 on BL_PERSON       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_PERSON.sql =========*** End *** ===
PROMPT ===================================================================================== 
