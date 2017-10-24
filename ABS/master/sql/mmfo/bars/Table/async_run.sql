

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_RUN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_RUN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_RUN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_RUN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_RUN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_RUN 
   (	RUN_ID NUMBER, 
	ACTION_ID NUMBER, 
	JOB_NAME VARCHAR2(200), 
	JOB_SQL VARCHAR2(4000), 
	START_DATE DATE, 
	END_DATE DATE, 
	DBMSHP_RUNID NUMBER, 
	EXCLMODE_VALUE VARCHAR2(200), 
	STATE VARCHAR2(16) DEFAULT ''NEW'', 
	ERROR_MESSAGE VARCHAR2(4000), 
	USER_ID NUMBER, 
	PROGRESS_BAR NUMBER(3,0), 
	PROGRESS_TEXT VARCHAR2(256)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_RUN ***
 exec bpa.alter_policies('ASYNC_RUN');


COMMENT ON TABLE BARS.ASYNC_RUN IS 'Журнал запусків';
COMMENT ON COLUMN BARS.ASYNC_RUN.RUN_ID IS 'Ідентифікатор запуска';
COMMENT ON COLUMN BARS.ASYNC_RUN.ACTION_ID IS 'Ідентифікатор дії';
COMMENT ON COLUMN BARS.ASYNC_RUN.JOB_NAME IS 'Ім'я Задачі Планувальника';
COMMENT ON COLUMN BARS.ASYNC_RUN.JOB_SQL IS 'SQL-текст запуска';
COMMENT ON COLUMN BARS.ASYNC_RUN.START_DATE IS 'Час початку виконання';
COMMENT ON COLUMN BARS.ASYNC_RUN.END_DATE IS 'Час завершення виконання';
COMMENT ON COLUMN BARS.ASYNC_RUN.DBMSHP_RUNID IS 'Ідентифікатор запуску Ієрархічного Профайлера';
COMMENT ON COLUMN BARS.ASYNC_RUN.EXCLMODE_VALUE IS 'Значення для визначення виключності запуску';
COMMENT ON COLUMN BARS.ASYNC_RUN.STATE IS 'Стан запуску';
COMMENT ON COLUMN BARS.ASYNC_RUN.ERROR_MESSAGE IS 'Повідомлення про помилку';
COMMENT ON COLUMN BARS.ASYNC_RUN.USER_ID IS 'Ідентифікатор користувача, що створив запуск';
COMMENT ON COLUMN BARS.ASYNC_RUN.PROGRESS_BAR IS '';
COMMENT ON COLUMN BARS.ASYNC_RUN.PROGRESS_TEXT IS '';




PROMPT *** Create  constraint PK_ASNRUN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN ADD CONSTRAINT PK_ASNRUN PRIMARY KEY (RUN_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ASNRUN_ACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN ADD CONSTRAINT FK_ASNRUN_ACT FOREIGN KEY (ACTION_ID)
	  REFERENCES BARS.ASYNC_ACTION (ACTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ASNRUN_STATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN MODIFY (STATE CONSTRAINT CC_ASNRUN_STATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNRUN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNRUN ON BARS.ASYNC_RUN (RUN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ASNRUN_JOBNAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_ASNRUN_JOBNAME ON BARS.ASYNC_RUN (JOB_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_RUN ***
grant SELECT                                                                 on ASYNC_RUN       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ASYNC_RUN       to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_RUN.sql =========*** End *** ===
PROMPT ===================================================================================== 
