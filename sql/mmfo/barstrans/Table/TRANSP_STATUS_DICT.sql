PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_STATUS_DICT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_STATUS_DICT ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_STATUS_DICT 
   (	ID NUMBER, 
	STATUS_NAME VARCHAR2(255), 
	DESCRIPTION VARCHAR2(255)
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_STATUS_DICT IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_STATUS_DICT.ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_STATUS_DICT.STATUS_NAME IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_STATUS_DICT.DESCRIPTION IS '';




PROMPT *** Create  constraint PK_TRANSP_STATUS_DICT ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_STATUS_DICT ADD CONSTRAINT PK_TRANSP_STATUS_DICT PRIMARY KEY (ID)
  USING INDEX TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_STATUS_DICT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_STATUS_DICT ON BARSTRANS.TRANSP_STATUS_DICT (ID) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_STATUS_DICT.sql =========*
PROMPT ===================================================================================== 