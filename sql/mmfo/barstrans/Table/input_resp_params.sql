

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_RESP_PARAMS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table INPUT_RESP_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.INPUT_RESP_PARAMS 
   (RESP_ID VARCHAR2(36), 
	PARAM_TYPE VARCHAR2(10), 
	TAG VARCHAR2(30), 
	VALUE VARCHAR2(255)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.INPUT_RESP_PARAMS IS 'Параметри відповіді';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP_PARAMS.RESP_ID IS 'Ід відповіді';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP_PARAMS.PARAM_TYPE IS 'Тип параметрі';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP_PARAMS.TAG IS 'Тег';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP_PARAMS.VALUE IS 'Значення';




PROMPT *** Create  constraint PK_INPUT_RESP_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_RESP_PARAMS ADD CONSTRAINT PK_INPUT_RESP_PARAMS PRIMARY KEY (RESP_ID, PARAM_TYPE, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INPUT_RESP_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_INPUT_RESP_PARAMS ON BARSTRANS.INPUT_RESP_PARAMS (RESP_ID, PARAM_TYPE, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_RESP_PARAMS.sql =========**
PROMPT ===================================================================================== 

