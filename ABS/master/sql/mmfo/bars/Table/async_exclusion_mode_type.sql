

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_EXCLUSION_MODE_TYPE.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_EXCLUSION_MODE_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_EXCLUSION_MODE_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_EXCLUSION_MODE_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_EXCLUSION_MODE_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_EXCLUSION_MODE_TYPE 
   (	TYPE VARCHAR2(50), 
	DESCRIPTION VARCHAR2(200), 
	 CONSTRAINT PK_ASNEXCMODE PRIMARY KEY (TYPE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_EXCLUSION_MODE_TYPE ***
 exec bpa.alter_policies('ASYNC_EXCLUSION_MODE_TYPE');


COMMENT ON TABLE BARS.ASYNC_EXCLUSION_MODE_TYPE IS 'Довідник видів запуску завдань';
COMMENT ON COLUMN BARS.ASYNC_EXCLUSION_MODE_TYPE.TYPE IS 'Тип параметра';
COMMENT ON COLUMN BARS.ASYNC_EXCLUSION_MODE_TYPE.DESCRIPTION IS 'Маска форматування';




PROMPT *** Create  constraint PK_ASNEXCMODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_EXCLUSION_MODE_TYPE ADD CONSTRAINT PK_ASNEXCMODE PRIMARY KEY (TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNEXCMODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNEXCMODE ON BARS.ASYNC_EXCLUSION_MODE_TYPE (TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_EXCLUSION_MODE_TYPE ***
grant SELECT                                                                 on ASYNC_EXCLUSION_MODE_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_EXCLUSION_MODE_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ASYNC_EXCLUSION_MODE_TYPE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_EXCLUSION_MODE_TYPE.sql ========
PROMPT ===================================================================================== 
