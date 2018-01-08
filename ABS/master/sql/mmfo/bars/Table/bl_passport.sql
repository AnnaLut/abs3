

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_PASSPORT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_PASSPORT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_PASSPORT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_PASSPORT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_PASSPORT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_PASSPORT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_PASSPORT 
   (	PASSPORT_ID NUMBER, 
	PERSON_ID NUMBER, 
	PASS_SER VARCHAR2(10), 
	PASS_NUM VARCHAR2(6), 
	PASS_DATE DATE, 
	PASS_OFFICE VARCHAR2(300), 
	PASS_REGION VARCHAR2(30), 
	INS_DATE DATE, 
	USER_ID NUMBER, 
	BASE_ID NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_PASSPORT ***
 exec bpa.alter_policies('BL_PASSPORT');


COMMENT ON TABLE BARS.BL_PASSPORT IS 'ПАСПОРТНЫЕ ДАННЫЕ ФИЗЛИЦ';
COMMENT ON COLUMN BARS.BL_PASSPORT.PASSPORT_ID IS 'Уникальный идентификатор';
COMMENT ON COLUMN BARS.BL_PASSPORT.PERSON_ID IS 'Link to BL_PERSON. Не уникальный идентификатор.';
COMMENT ON COLUMN BARS.BL_PASSPORT.PASS_SER IS 'Серия паспорта. Кириллица в верхнем регистре.';
COMMENT ON COLUMN BARS.BL_PASSPORT.PASS_NUM IS 'Номер паспорта, с ведущими нулями.';
COMMENT ON COLUMN BARS.BL_PASSPORT.PASS_DATE IS 'Дата выдачи паспорта';
COMMENT ON COLUMN BARS.BL_PASSPORT.PASS_OFFICE IS 'Кем выдан паспорт';
COMMENT ON COLUMN BARS.BL_PASSPORT.PASS_REGION IS 'Регион выдачи паспорта';
COMMENT ON COLUMN BARS.BL_PASSPORT.INS_DATE IS 'Дата добавления записи.';
COMMENT ON COLUMN BARS.BL_PASSPORT.USER_ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.BL_PASSPORT.BASE_ID IS '';




PROMPT *** Create  constraint BL_PASSPORT_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT ADD CONSTRAINT BL_PASSPORT_PK PRIMARY KEY (BASE_ID, PASSPORT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint BL_PASSPORT_BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT ADD CONSTRAINT BL_PASSPORT_BASE FOREIGN KEY (BASE_ID)
	  REFERENCES BARS.BL_BASE_DICT (BASE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PASSPORT_BASE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT MODIFY (BASE_ID CONSTRAINT NN_BL_PASSPORT_BASE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PASSPORT_USER ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT MODIFY (USER_ID CONSTRAINT NN_BL_PASSPORT_USER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PASSPORT_PASS_NUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT MODIFY (PASS_NUM CONSTRAINT NN_BL_PASSPORT_PASS_NUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PASSPORT_PASS_SER ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT MODIFY (PASS_SER CONSTRAINT NN_BL_PASSPORT_PASS_SER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PASSPORT_PERSON_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT MODIFY (PERSON_ID CONSTRAINT NN_BL_PASSPORT_PERSON_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint BL_PASSPORT_PERSON_FK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT ADD CONSTRAINT BL_PASSPORT_PERSON_FK FOREIGN KEY (BASE_ID, PERSON_ID)
	  REFERENCES BARS.BL_PERSON (BASE_ID, PERSON_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint BL_PASSPORT_USER_FK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT ADD CONSTRAINT BL_PASSPORT_USER_FK FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PASSPORT_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT MODIFY (PASSPORT_ID CONSTRAINT NN_BL_PASSPORT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_PASSPORT_PERS ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_PASSPORT_PERS ON BARS.BL_PASSPORT (BASE_ID, PERSON_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_PASSPORT_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.BL_PASSPORT_PK ON BARS.BL_PASSPORT (BASE_ID, PASSPORT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_PASSPORT ***
grant SELECT                                                                 on BL_PASSPORT     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BL_PASSPORT     to RBL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_PASSPORT.sql =========*** End *** =
PROMPT ===================================================================================== 
