

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_STATUS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_REG_STATUS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_REG_STATUS 
   (	ID NUMBER, 
	CODE VARCHAR2(100), 
	NAME VARCHAR2(250), 
	LEVEL_TYPE VARCHAR2(100), 
	PRIORITY NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_REG_STATUS IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_STATUS.ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_STATUS.CODE IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_STATUS.NAME IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_STATUS.LEVEL_TYPE IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_STATUS.PRIORITY IS '';




PROMPT *** Create  constraint PK_REG_ST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_STATUS ADD CONSTRAINT PK_REG_ST_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_STATUS_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_STATUS ADD CONSTRAINT CC_ESCR_REG_STATUS_CODE CHECK (CODE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REG_ST_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_REG_ST_ID ON BARSAQ.ESCR_REG_STATUS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_REG_STATUS ***
grant SELECT                                                                 on ESCR_REG_STATUS to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_STATUS.sql =========*** End
PROMPT ===================================================================================== 
