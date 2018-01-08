

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_TASK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_TASK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_TASK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMS_TASK'', ''FILIAL'' , null, null, ''E'', ''E'');
               bpa.alter_policy_info(''TMS_TASK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_TASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_TASK 
   (	ID NUMBER(38,0), 
	TASK_CODE VARCHAR2(255 CHAR), 
	TASK_TYPE_ID NUMBER(5,0), 
	TASK_GROUP_ID NUMBER(5,0), 
	SEQUENCE_NUMBER NUMBER(5,0), 
	TASK_NAME VARCHAR2(300 CHAR), 
	TASK_DESCRIPTION VARCHAR2(4000), 
	BRANCH_PROCESSING_MODE NUMBER(5,0), 
	ACTION_ON_FAILURE NUMBER(5,0), 
	TASK_STATEMENT VARCHAR2(4000), 
	STATE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_TASK ***
 exec bpa.alter_policies('TMS_TASK');


COMMENT ON TABLE BARS.TMS_TASK IS 'Опис процедур, що виконуються списком (Старт/Фініш)';
COMMENT ON COLUMN BARS.TMS_TASK.ID IS 'Числовий код';
COMMENT ON COLUMN BARS.TMS_TASK.TASK_CODE IS 'унікальний Символьний код';
COMMENT ON COLUMN BARS.TMS_TASK.TASK_TYPE_ID IS '???';
COMMENT ON COLUMN BARS.TMS_TASK.TASK_GROUP_ID IS 'контекст банк-дати : 1 - фініш, 2 - старт, 3 - не встановлюється контекст дати';
COMMENT ON COLUMN BARS.TMS_TASK.SEQUENCE_NUMBER IS 'порядковий номер виконання завдання (може дублюватися)';
COMMENT ON COLUMN BARS.TMS_TASK.TASK_NAME IS 'назва завдання';
COMMENT ON COLUMN BARS.TMS_TASK.TASK_DESCRIPTION IS 'додатковий текстовий опис завдання';
COMMENT ON COLUMN BARS.TMS_TASK.BRANCH_PROCESSING_MODE IS 'режим представлення РУ: 1 - виконувати процедуру на "/", 2 - кожна РУ обробляється по черзі, 3 - всі РУ обробляються паралельно';
COMMENT ON COLUMN BARS.TMS_TASK.ACTION_ON_FAILURE IS 'порядок дій у разі виникнення помилки: 1 - продовжити, 2 - зупинити';
COMMENT ON COLUMN BARS.TMS_TASK.TASK_STATEMENT IS 'PL/SQL-блок, що виконується для даного завдання';
COMMENT ON COLUMN BARS.TMS_TASK.STATE_ID IS '';




PROMPT *** Create  constraint SYS_C0035436 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035437 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK MODIFY (TASK_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035438 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK MODIFY (TASK_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035439 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK MODIFY (TASK_GROUP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035440 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK MODIFY (TASK_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035441 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK MODIFY (BRANCH_PROCESSING_MODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035442 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK MODIFY (ACTION_ON_FAILURE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035443 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK MODIFY (TASK_STATEMENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035444 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMS_TASK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK ADD CONSTRAINT PK_TMS_TASK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_TMS_TASK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK ADD CONSTRAINT UK_TMS_TASK UNIQUE (TASK_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_TMS_TASK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_TMS_TASK ON BARS.TMS_TASK (TASK_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMS_TASK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMS_TASK ON BARS.TMS_TASK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMS_TASK ***
grant SELECT                                                                 on TMS_TASK        to BARSREADER_ROLE;
grant SELECT                                                                 on TMS_TASK        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_TASK.sql =========*** End *** ====
PROMPT ===================================================================================== 
