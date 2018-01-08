

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_RUN_PARAM_VAL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_RUN_PARAM_VAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_RUN_PARAM_VAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_RUN_PARAM_VAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_RUN_PARAM_VAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_RUN_PARAM_VAL 
   (	PARAM_VAL_ID NUMBER, 
	RUN_ID NUMBER, 
	PARAM_ID NUMBER, 
	PARAM_VAL VARCHAR2(2000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_RUN_PARAM_VAL ***
 exec bpa.alter_policies('ASYNC_RUN_PARAM_VAL');


COMMENT ON TABLE BARS.ASYNC_RUN_PARAM_VAL IS 'Журнал значень параметрів';
COMMENT ON COLUMN BARS.ASYNC_RUN_PARAM_VAL.PARAM_VAL_ID IS 'Ідентифікатор значення параметра';
COMMENT ON COLUMN BARS.ASYNC_RUN_PARAM_VAL.RUN_ID IS 'Ідентифікатор запуску';
COMMENT ON COLUMN BARS.ASYNC_RUN_PARAM_VAL.PARAM_ID IS 'Ідентифікатор запуску';
COMMENT ON COLUMN BARS.ASYNC_RUN_PARAM_VAL.PARAM_VAL IS 'Значення параметру';




PROMPT *** Create  constraint PK_ASNPRVL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN_PARAM_VAL ADD CONSTRAINT PK_ASNPRVL PRIMARY KEY (PARAM_VAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNPRVL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNPRVL ON BARS.ASYNC_RUN_PARAM_VAL (PARAM_VAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_RUN_PARAM_VAL ***
grant SELECT                                                                 on ASYNC_RUN_PARAM_VAL to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_RUN_PARAM_VAL to BARS_DM;
grant SELECT                                                                 on ASYNC_RUN_PARAM_VAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_RUN_PARAM_VAL.sql =========*** E
PROMPT ===================================================================================== 
