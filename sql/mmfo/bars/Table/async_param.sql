

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_PARAM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_PARAM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_PARAM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_PARAM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_PARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_PARAM 
   (	PARAM_ID NUMBER, 
	PARAM_NAME VARCHAR2(40), 
	PARAM_TYPE VARCHAR2(40), 
	DEFAULT_VALUE VARCHAR2(500), 
	USER_PROMPT VARCHAR2(500), 
	MIN VARCHAR2(50), 
	MAX VARCHAR2(50), 
	UI_TYPE VARCHAR2(50), 
	DIRECTORY VARCHAR2(50)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_PARAM ***
 exec bpa.alter_policies('ASYNC_PARAM');


COMMENT ON TABLE BARS.ASYNC_PARAM IS 'Довідник параметрів';
COMMENT ON COLUMN BARS.ASYNC_PARAM.PARAM_ID IS 'Ідентифікатор параметра';
COMMENT ON COLUMN BARS.ASYNC_PARAM.PARAM_NAME IS 'Ім'я параметра';
COMMENT ON COLUMN BARS.ASYNC_PARAM.PARAM_TYPE IS 'Тип параметра';
COMMENT ON COLUMN BARS.ASYNC_PARAM.DEFAULT_VALUE IS 'Значення за умовчанням';
COMMENT ON COLUMN BARS.ASYNC_PARAM.USER_PROMPT IS 'Запрошення користувача';
COMMENT ON COLUMN BARS.ASYNC_PARAM.MIN IS 'мінімальне значення';
COMMENT ON COLUMN BARS.ASYNC_PARAM.MAX IS 'максимальне значення';
COMMENT ON COLUMN BARS.ASYNC_PARAM.UI_TYPE IS 'тип юі відображення';
COMMENT ON COLUMN BARS.ASYNC_PARAM.DIRECTORY IS 'довідник';




PROMPT *** Create  constraint PK_ASNPARAM ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_PARAM ADD CONSTRAINT PK_ASNPARAM PRIMARY KEY (PARAM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNPARAM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNPARAM ON BARS.ASYNC_PARAM (PARAM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_PARAM ***
grant SELECT                                                                 on ASYNC_PARAM     to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_PARAM     to BARS_DM;
grant SELECT                                                                 on ASYNC_PARAM     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_PARAM.sql =========*** End *** =
PROMPT ===================================================================================== 
