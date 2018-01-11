

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_ACTION_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_ACTION_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_ACTION_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_ACTION_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_ACTION_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_ACTION_TYPE 
   (	ACTION_TYPE VARCHAR2(40), 
	 CONSTRAINT PK_ASNACTT PRIMARY KEY (ACTION_TYPE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_ACTION_TYPE ***
 exec bpa.alter_policies('ASYNC_ACTION_TYPE');


COMMENT ON TABLE BARS.ASYNC_ACTION_TYPE IS 'Довідник типів дій';
COMMENT ON COLUMN BARS.ASYNC_ACTION_TYPE.ACTION_TYPE IS 'Тип дії';




PROMPT *** Create  constraint PK_ASNACTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_ACTION_TYPE ADD CONSTRAINT PK_ASNACTT PRIMARY KEY (ACTION_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNACTT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNACTT ON BARS.ASYNC_ACTION_TYPE (ACTION_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_ACTION_TYPE ***
grant SELECT                                                                 on ASYNC_ACTION_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_ACTION_TYPE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_ACTION_TYPE.sql =========*** End
PROMPT ===================================================================================== 
