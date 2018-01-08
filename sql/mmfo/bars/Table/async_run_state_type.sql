

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_RUN_STATE_TYPE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_RUN_STATE_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_RUN_STATE_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_RUN_STATE_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_RUN_STATE_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_RUN_STATE_TYPE 
   (	STATE_TYPE VARCHAR2(40), 
	DESCRIPTION VARCHAR2(100), 
	 CONSTRAINT PK_ASNRUNSTATET PRIMARY KEY (STATE_TYPE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_RUN_STATE_TYPE ***
 exec bpa.alter_policies('ASYNC_RUN_STATE_TYPE');


COMMENT ON TABLE BARS.ASYNC_RUN_STATE_TYPE IS 'Довідник типів статусів запущених завдань';
COMMENT ON COLUMN BARS.ASYNC_RUN_STATE_TYPE.STATE_TYPE IS 'Статус';
COMMENT ON COLUMN BARS.ASYNC_RUN_STATE_TYPE.DESCRIPTION IS 'Опис';




PROMPT *** Create  constraint PK_ASNRUNSTATET ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN_STATE_TYPE ADD CONSTRAINT PK_ASNRUNSTATET PRIMARY KEY (STATE_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNRUNSTATET ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNRUNSTATET ON BARS.ASYNC_RUN_STATE_TYPE (STATE_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_RUN_STATE_TYPE ***
grant SELECT                                                                 on ASYNC_RUN_STATE_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_RUN_STATE_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ASYNC_RUN_STATE_TYPE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_RUN_STATE_TYPE.sql =========*** 
PROMPT ===================================================================================== 
