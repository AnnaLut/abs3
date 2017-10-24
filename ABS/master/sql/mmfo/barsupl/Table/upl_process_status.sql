

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_PROCESS_STATUS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_PROCESS_STATUS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_PROCESS_STATUS 
   (	STATUS_ID NUMBER, 
	STATUS_CODE VARCHAR2(20), 
	DESCRIPT VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_PROCESS_STATUS IS '';
COMMENT ON COLUMN BARSUPL.UPL_PROCESS_STATUS.STATUS_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_PROCESS_STATUS.STATUS_CODE IS '';
COMMENT ON COLUMN BARSUPL.UPL_PROCESS_STATUS.DESCRIPT IS '';




PROMPT *** Create  constraint PK_UPLPROCESSSTATUS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_PROCESS_STATUS ADD CONSTRAINT PK_UPLPROCESSSTATUS PRIMARY KEY (STATUS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLPROCESSSTATUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLPROCESSSTATUS ON BARSUPL.UPL_PROCESS_STATUS (STATUS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_PROCESS_STATUS.sql =========***
PROMPT ===================================================================================== 
