

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/OPER_NOTES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table OPER_NOTES ***
begin 
  execute immediate '
  CREATE TABLE FINMON.OPER_NOTES 
   (	OPER_ID VARCHAR2(15), 
	NOTES VARCHAR2(1024), 
	HOLD_REF_NUM VARCHAR2(20), 
	HOLD_REF_DATE DATE, 
	HOLD_REF_BODY VARCHAR2(4000), 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.OPER_NOTES IS 'Дополнительная информация о сообщении';
COMMENT ON COLUMN FINMON.OPER_NOTES.OPER_ID IS 'Идентификатор операции';
COMMENT ON COLUMN FINMON.OPER_NOTES.NOTES IS 'Примечания';
COMMENT ON COLUMN FINMON.OPER_NOTES.HOLD_REF_NUM IS 'Номер справки-обоснования неотправки';
COMMENT ON COLUMN FINMON.OPER_NOTES.HOLD_REF_DATE IS 'Дата справки-обоснования неотправки';
COMMENT ON COLUMN FINMON.OPER_NOTES.HOLD_REF_BODY IS 'Текст справки-обоснования неотправки';
COMMENT ON COLUMN FINMON.OPER_NOTES.BRANCH_ID IS '';




PROMPT *** Create  constraint XPK_OPER_NOTES ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER_NOTES ADD CONSTRAINT XPK_OPER_NOTES PRIMARY KEY (OPER_ID, BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE SYSTEM  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPERNOTES_OPER ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER_NOTES ADD CONSTRAINT R_OPERNOTES_OPER FOREIGN KEY (OPER_ID, BRANCH_ID)
	  REFERENCES FINMON.OPER (ID, BRANCH_ID) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPERNOTES_BANK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER_NOTES ADD CONSTRAINT R_OPERNOTES_BANK FOREIGN KEY (BRANCH_ID)
	  REFERENCES FINMON.BANK (ID) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_NOTES_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER_NOTES ADD CONSTRAINT NK_OPER_NOTES_BRANCH_ID CHECK (BRANCH_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OPER_NOTES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_OPER_NOTES ON FINMON.OPER_NOTES (OPER_ID, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE SYSTEM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/OPER_NOTES.sql =========*** End *** 
PROMPT ===================================================================================== 
