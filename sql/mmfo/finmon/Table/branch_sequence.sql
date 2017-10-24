

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/BRANCH_SEQUENCE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table BRANCH_SEQUENCE ***
begin 
  execute immediate '
  CREATE TABLE FINMON.BRANCH_SEQUENCE 
   (	ID_FILE_OUT NUMBER(10,0), 
	ID_FILE_IN NUMBER(10,0), 
	ID_BANK NUMBER(10,0), 
	ID_OPER NUMBER(10,0), 
	ID_USERS NUMBER(10,0), 
	ID_REQUEST NUMBER(10,0), 
	ID_PERSON NUMBER(10,0), 
	ID_PERSON_BANK NUMBER(10,0), 
	KL_ID NUMBER(10,0), 
	KL_ID_DATE DATE, 
	BRANCH_ID VARCHAR2(15), 
	IS_ACTIVE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.BRANCH_SEQUENCE IS 'Таблица последовательности идентификаторов';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.ID_FILE_OUT IS 'Номер идентификатора таблицы FILE_OUT';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.ID_FILE_IN IS 'Номер идентификатора таблицы FILE_IN';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.ID_BANK IS 'Номер идентификатора таблицы BANK';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.ID_OPER IS 'Номер идентификатора таблицы OPER';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.ID_USERS IS 'Номер идентификатора таблицы USERS';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.ID_REQUEST IS 'Номер идентификатора таблицы REQUEST';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.ID_PERSON IS 'Номер идентификатора таблицы PERSON';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.ID_PERSON_BANK IS 'Номер идентификатора таблицы PERSON_BANK';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.KL_ID IS 'Номер внешнего идентификатора сообщений';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.KL_ID_DATE IS 'Дата последнего изменения идентификатора сообщений';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.BRANCH_ID IS '';
COMMENT ON COLUMN FINMON.BRANCH_SEQUENCE.IS_ACTIVE IS '';




PROMPT *** Create  constraint NK_SEQ_ID_FILEIN ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (ID_FILE_IN CONSTRAINT NK_SEQ_ID_FILEIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQ_ID_FILE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (ID_FILE_OUT CONSTRAINT NK_SEQ_ID_FILE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_BRANCH_SEQUENCE_BANK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE ADD CONSTRAINT R_BRANCH_SEQUENCE_BANK FOREIGN KEY (BRANCH_ID)
	  REFERENCES FINMON.BANK (ID) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BRANCH_SEQUENCE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE ADD CONSTRAINT XPK_BRANCH_SEQUENCE PRIMARY KEY (BRANCH_ID, IS_ACTIVE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE SYSTEM  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQ_ID_BANK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (ID_BANK CONSTRAINT NK_SEQ_ID_BANK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQ_ID_OPER ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (ID_OPER CONSTRAINT NK_SEQ_ID_OPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BRANCE_SEQUENCE_IS_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (IS_ACTIVE CONSTRAINT NK_BRANCE_SEQUENCE_IS_ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQ_ID_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (ID_REQUEST CONSTRAINT NK_SEQ_ID_REQUEST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQ_ID_PERSON ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (ID_PERSON CONSTRAINT NK_SEQ_ID_PERSON NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQ_ID_PBANK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (ID_PERSON_BANK CONSTRAINT NK_SEQ_ID_PBANK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQ_KLID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (KL_ID CONSTRAINT NK_SEQ_KLID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQ_KLID_D ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (KL_ID_DATE CONSTRAINT NK_SEQ_KLID_D NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BRANCE_SEQUENCE_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (BRANCH_ID CONSTRAINT NK_BRANCE_SEQUENCE_BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQ_ID_USERS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.BRANCH_SEQUENCE MODIFY (ID_USERS CONSTRAINT NK_SEQ_ID_USERS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BRANCH_SEQUENCE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_BRANCH_SEQUENCE ON FINMON.BRANCH_SEQUENCE (BRANCH_ID, IS_ACTIVE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE SYSTEM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/BRANCH_SEQUENCE.sql =========*** End
PROMPT ===================================================================================== 
