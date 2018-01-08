

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_OBJ_STATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_REG_OBJ_STATE ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_REG_OBJ_STATE 
   (	ID NUMBER, 
	OBJ_ID NUMBER, 
	OBJ_TYPE NUMBER, 
	STATUS_ID NUMBER, 
	STATUS_COMMENT VARCHAR2(4000), 
	USER_ID NUMBER, 
	USER_NAME VARCHAR2(400), 
	SET_DATE DATE DEFAULT sysdate
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_REG_OBJ_STATE IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_OBJ_STATE.ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_OBJ_STATE.OBJ_ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_OBJ_STATE.OBJ_TYPE IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_OBJ_STATE.STATUS_ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_OBJ_STATE.STATUS_COMMENT IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_OBJ_STATE.USER_ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_OBJ_STATE.USER_NAME IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_OBJ_STATE.SET_DATE IS '';




PROMPT *** Create  constraint PK_REG_STATUS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_OBJ_STATE ADD CONSTRAINT PK_REG_STATUS_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_OBJ_STATE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_OBJ_STATE ADD CONSTRAINT CC_ESCR_REG_OBJ_STATE_ID CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REG_STATUS_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_REG_STATUS_ID ON BARSAQ.ESCR_REG_OBJ_STATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_OBJ_STATE.sql =========*** 
PROMPT ===================================================================================== 
