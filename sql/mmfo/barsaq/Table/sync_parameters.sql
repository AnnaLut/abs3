

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/SYNC_PARAMETERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table SYNC_PARAMETERS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.SYNC_PARAMETERS 
   (	PARAM_NAME VARCHAR2(30), 
	PARAM_VALUE VARCHAR2(128), 
	PARAM_COMMENT VARCHAR2(128), 
	 CONSTRAINT PK_SYNCPARAMETERS PRIMARY KEY (PARAM_NAME) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.SYNC_PARAMETERS IS 'Параметры модуля синхронизации';
COMMENT ON COLUMN BARSAQ.SYNC_PARAMETERS.PARAM_NAME IS 'Имя параметра';
COMMENT ON COLUMN BARSAQ.SYNC_PARAMETERS.PARAM_VALUE IS 'Значение параметра';
COMMENT ON COLUMN BARSAQ.SYNC_PARAMETERS.PARAM_COMMENT IS 'Назначение параметра';




PROMPT *** Create  constraint CC_SYNCPARAMETERS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_PARAMETERS MODIFY (PARAM_NAME CONSTRAINT CC_SYNCPARAMETERS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SYNCPARAMETERS_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_PARAMETERS MODIFY (PARAM_VALUE CONSTRAINT CC_SYNCPARAMETERS_VALUE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SYNCPARAMETERS_COMMENT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_PARAMETERS MODIFY (PARAM_COMMENT CONSTRAINT CC_SYNCPARAMETERS_COMMENT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SYNCPARAMETERS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_PARAMETERS ADD CONSTRAINT PK_SYNCPARAMETERS PRIMARY KEY (PARAM_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SYNCPARAMETERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_SYNCPARAMETERS ON BARSAQ.SYNC_PARAMETERS (PARAM_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/SYNC_PARAMETERS.sql =========*** End
PROMPT ===================================================================================== 
