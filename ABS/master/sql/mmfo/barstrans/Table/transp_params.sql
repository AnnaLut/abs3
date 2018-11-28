

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_PARAMS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_PARAMS 
   (	PARAM_NAME VARCHAR2(50), 
	PARAM_VALUE VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_PARAMS IS 'Парамітри доступу до веб сервісу';
COMMENT ON COLUMN BARSTRANS.TRANSP_PARAMS.PARAM_VALUE IS 'Значення';
COMMENT ON COLUMN BARSTRANS.TRANSP_PARAMS.PARAM_NAME IS 'Тег';




PROMPT *** Create  constraint PK_TRANSP_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_PARAMS ADD CONSTRAINT PK_TRANSP_PARAMS PRIMARY KEY (PARAM_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_PARAMS ON BARSTRANS.TRANSP_PARAMS (PARAM_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_PARAMS.sql =========*** En
PROMPT ===================================================================================== 

