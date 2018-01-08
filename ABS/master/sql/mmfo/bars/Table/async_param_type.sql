

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_PARAM_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_PARAM_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_PARAM_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_PARAM_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_PARAM_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_PARAM_TYPE 
   (	PARAM_TYPE VARCHAR2(40), 
	NAME VARCHAR2(100), 
	FORMAT_MASK VARCHAR2(80), 
	 CONSTRAINT PK_ASNPARAMT PRIMARY KEY (PARAM_TYPE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_PARAM_TYPE ***
 exec bpa.alter_policies('ASYNC_PARAM_TYPE');


COMMENT ON TABLE BARS.ASYNC_PARAM_TYPE IS 'Довідник типів параметрів';
COMMENT ON COLUMN BARS.ASYNC_PARAM_TYPE.PARAM_TYPE IS 'Тип параметра';
COMMENT ON COLUMN BARS.ASYNC_PARAM_TYPE.NAME IS 'Назва';
COMMENT ON COLUMN BARS.ASYNC_PARAM_TYPE.FORMAT_MASK IS 'Маска форматування';




PROMPT *** Create  constraint PK_ASNPARAMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_PARAM_TYPE ADD CONSTRAINT PK_ASNPARAMT PRIMARY KEY (PARAM_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNPARAMT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNPARAMT ON BARS.ASYNC_PARAM_TYPE (PARAM_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_PARAM_TYPE ***
grant SELECT                                                                 on ASYNC_PARAM_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_PARAM_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ASYNC_PARAM_TYPE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_PARAM_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
