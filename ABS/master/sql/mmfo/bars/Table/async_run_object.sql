

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_RUN_OBJECT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_RUN_OBJECT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_RUN_OBJECT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_RUN_OBJECT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_RUN_OBJECT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_RUN_OBJECT 
   (	OBJECT_ID NUMBER, 
	OBJ_TYPE_ID NUMBER, 
	ACTION_ID NUMBER, 
	PRE_ACTION_ID NUMBER, 
	POST_ACTION_ID NUMBER, 
	SCHEDULER_ID NUMBER, 
	TRACE_LEVEL_ID NUMBER, 
	USER_MESSAGE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_RUN_OBJECT ***
 exec bpa.alter_policies('ASYNC_RUN_OBJECT');


COMMENT ON TABLE BARS.ASYNC_RUN_OBJECT IS 'Довідник запусканих об'єктів';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJECT.OBJECT_ID IS 'Ідентифікатор об'єкта';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJECT.OBJ_TYPE_ID IS 'Ідентифікатор типа об'єкта';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJECT.ACTION_ID IS 'Ідентифікатор дії';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJECT.PRE_ACTION_ID IS 'Ідентифікатор попередньої дії';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJECT.POST_ACTION_ID IS 'Ідентифікатор завершальної дії';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJECT.SCHEDULER_ID IS 'Ідентифікатор розкладу';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJECT.TRACE_LEVEL_ID IS 'Рівень трасування';
COMMENT ON COLUMN BARS.ASYNC_RUN_OBJECT.USER_MESSAGE IS 'Повідомлення користувача';




PROMPT *** Create  constraint PK_ASNROBJ ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN_OBJECT ADD CONSTRAINT PK_ASNROBJ PRIMARY KEY (OBJECT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNROBJ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNROBJ ON BARS.ASYNC_RUN_OBJECT (OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_RUN_OBJECT ***
grant SELECT                                                                 on ASYNC_RUN_OBJECT to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_RUN_OBJECT to BARS_DM;
grant SELECT                                                                 on ASYNC_RUN_OBJECT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_RUN_OBJECT.sql =========*** End 
PROMPT ===================================================================================== 
