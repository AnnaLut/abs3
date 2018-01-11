

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_SQL_PARAM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_SQL_PARAM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_SQL_PARAM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_SQL_PARAM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_SQL_PARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_SQL_PARAM 
   (	SQL_PARAM_ID NUMBER, 
	SQL_ID NUMBER, 
	PARAM_ID NUMBER, 
	PARAM_POS NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_SQL_PARAM ***
 exec bpa.alter_policies('ASYNC_SQL_PARAM');


COMMENT ON TABLE BARS.ASYNC_SQL_PARAM IS 'Довідник параметрів SQL запитів';
COMMENT ON COLUMN BARS.ASYNC_SQL_PARAM.SQL_PARAM_ID IS 'Ідентифікатор параметра запита';
COMMENT ON COLUMN BARS.ASYNC_SQL_PARAM.SQL_ID IS 'Ідентифікатор запита';
COMMENT ON COLUMN BARS.ASYNC_SQL_PARAM.PARAM_ID IS 'Ідентифікатор параметра';
COMMENT ON COLUMN BARS.ASYNC_SQL_PARAM.PARAM_POS IS 'Порядковий номер параметра в запиті';




PROMPT *** Create  constraint PK_ASNSQLPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_SQL_PARAM ADD CONSTRAINT PK_ASNSQLPAR PRIMARY KEY (SQL_PARAM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNSQLPAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNSQLPAR ON BARS.ASYNC_SQL_PARAM (SQL_PARAM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_SQL_PARAM ***
grant SELECT                                                                 on ASYNC_SQL_PARAM to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_SQL_PARAM to BARS_DM;
grant SELECT                                                                 on ASYNC_SQL_PARAM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_SQL_PARAM.sql =========*** End *
PROMPT ===================================================================================== 
