

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_ACTION.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_ACTION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_ACTION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_ACTION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_ACTION ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_ACTION 
   (	ACTION_ID NUMBER, 
	ACTION_CODE VARCHAR2(40), 
	ACTION_TYPE VARCHAR2(40), 
	SQL_ID NUMBER, 
	WEBUI_ID NUMBER, 
	BARS_LOGIN CHAR(1) DEFAULT ''Y'', 
	MAX_RUN_SECS NUMBER, 
	NAME VARCHAR2(200), 
	DESCRIPTION VARCHAR2(4000), 
	EXCLUSION_MODE VARCHAR2(8) DEFAULT ''NONE''
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_ACTION ***
 exec bpa.alter_policies('ASYNC_ACTION');


COMMENT ON TABLE BARS.ASYNC_ACTION IS 'Довідник дій';
COMMENT ON COLUMN BARS.ASYNC_ACTION.ACTION_ID IS 'Ідентифікатор дії';
COMMENT ON COLUMN BARS.ASYNC_ACTION.ACTION_CODE IS 'Код дії';
COMMENT ON COLUMN BARS.ASYNC_ACTION.ACTION_TYPE IS 'Тип дії';
COMMENT ON COLUMN BARS.ASYNC_ACTION.SQL_ID IS 'Ідентифікатор SQL-запиту';
COMMENT ON COLUMN BARS.ASYNC_ACTION.WEBUI_ID IS 'Ідентифікатор веб-сервісу';
COMMENT ON COLUMN BARS.ASYNC_ACTION.BARS_LOGIN IS '';
COMMENT ON COLUMN BARS.ASYNC_ACTION.MAX_RUN_SECS IS 'Максимальний час виконання в секундах';
COMMENT ON COLUMN BARS.ASYNC_ACTION.NAME IS '';
COMMENT ON COLUMN BARS.ASYNC_ACTION.DESCRIPTION IS 'Опис дії';
COMMENT ON COLUMN BARS.ASYNC_ACTION.EXCLUSION_MODE IS 'Режим виключності запуску';




PROMPT *** Create  constraint PK_ASNACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_ACTION ADD CONSTRAINT PK_ASNACT PRIMARY KEY (ACTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ASNACT_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_ACTION ADD CONSTRAINT UK_ASNACT_CODE UNIQUE (ACTION_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ASNACT_EXCLMD_CHK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_ACTION ADD CONSTRAINT CC_ASNACT_EXCLMD_CHK CHECK (exclusion_mode in (''NONE'', ''USER'', ''BRANCH'', ''FILIAL'', ''WHOLE'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ASNACT_EXCLMD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_ACTION MODIFY (EXCLUSION_MODE CONSTRAINT CC_ASNACT_EXCLMD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNACT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNACT ON BARS.ASYNC_ACTION (ACTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ASNACT_CODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ASNACT_CODE ON BARS.ASYNC_ACTION (ACTION_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_ACTION ***
grant SELECT                                                                 on ASYNC_ACTION    to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_ACTION    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ASYNC_ACTION    to BARS_DM;
grant SELECT                                                                 on ASYNC_ACTION    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_ACTION.sql =========*** End *** 
PROMPT ===================================================================================== 
