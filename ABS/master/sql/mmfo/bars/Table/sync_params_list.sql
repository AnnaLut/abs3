

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SYNC_PARAMS_LIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SYNC_PARAMS_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SYNC_PARAMS_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SYNC_PARAMS_LIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SYNC_PARAMS_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SYNC_PARAMS_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.SYNC_PARAMS_LIST 
   (	SERVICE_NAME VARCHAR2(32), 
	PARAMS VARCHAR2(32), 
	TYPE VARCHAR2(32), 
	REQUIRED NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SYNC_PARAMS_LIST ***
 exec bpa.alter_policies('SYNC_PARAMS_LIST');


COMMENT ON TABLE BARS.SYNC_PARAMS_LIST IS 'Параметри запитів/функцій WEB-сервісів обміну даними';
COMMENT ON COLUMN BARS.SYNC_PARAMS_LIST.SERVICE_NAME IS 'Назва WEB-сервісу';
COMMENT ON COLUMN BARS.SYNC_PARAMS_LIST.PARAMS IS 'Псевдонім параметру';
COMMENT ON COLUMN BARS.SYNC_PARAMS_LIST.TYPE IS 'Тип параметру: NUM, STR, DATE (формат dd/mm/yyyy), DATETIME (формат dd/mm/yyyy HH24:MI:SS)';
COMMENT ON COLUMN BARS.SYNC_PARAMS_LIST.REQUIRED IS 'Відмітка про обов`язковість заповнення параметру (1 - обов`язковий)';




PROMPT *** Create  constraint CC_SYNCPARAMSLIST_SNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_PARAMS_LIST MODIFY (SERVICE_NAME CONSTRAINT CC_SYNCPARAMSLIST_SNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SYNCPARAMSLIST_PARAMS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_PARAMS_LIST MODIFY (PARAMS CONSTRAINT CC_SYNCPARAMSLIST_PARAMS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SYNCPARAMSLIST_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_PARAMS_LIST MODIFY (TYPE CONSTRAINT CC_SYNCPARAMSLIST_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SYNCPARAMSLIST_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_PARAMS_LIST ADD CONSTRAINT CC_SYNCPARAMSLIST_TYPE CHECK (type in (''NUM'', ''STR'', ''DATE'', ''DATETIME'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SYNCPARAMSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_PARAMS_LIST ADD CONSTRAINT PK_SYNCPARAMSLIST PRIMARY KEY (SERVICE_NAME, PARAMS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SYNCPARAMSLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SYNCPARAMSLIST ON BARS.SYNC_PARAMS_LIST (SERVICE_NAME, PARAMS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SYNC_PARAMS_LIST ***
grant SELECT                                                                 on SYNC_PARAMS_LIST to BARSREADER_ROLE;
grant SELECT                                                                 on SYNC_PARAMS_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SYNC_PARAMS_LIST to BARS_DM;
grant SELECT                                                                 on SYNC_PARAMS_LIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SYNC_PARAMS_LIST.sql =========*** End 
PROMPT ===================================================================================== 
