

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_GROUP_LOG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_GROUP_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_GROUP_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_GROUP_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_GROUP_LOG 
   (	ID_GROUP_LOG NUMBER(*,0), 
	ID_GROUP NUMBER(*,0), 
	BANK_DATE DATE, 
	START_DATE TIMESTAMP (3) DEFAULT SYSTIMESTAMP(3), 
	DURATION INTERVAL DAY (2) TO SECOND (6), 
	STATUS_GROUP VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_GROUP_LOG ***
 exec bpa.alter_policies('TMS_GROUP_LOG');


COMMENT ON TABLE BARS.TMS_GROUP_LOG IS '';
COMMENT ON COLUMN BARS.TMS_GROUP_LOG.ID_GROUP_LOG IS '';
COMMENT ON COLUMN BARS.TMS_GROUP_LOG.ID_GROUP IS '';
COMMENT ON COLUMN BARS.TMS_GROUP_LOG.BANK_DATE IS '';
COMMENT ON COLUMN BARS.TMS_GROUP_LOG.START_DATE IS '';
COMMENT ON COLUMN BARS.TMS_GROUP_LOG.DURATION IS '';
COMMENT ON COLUMN BARS.TMS_GROUP_LOG.STATUS_GROUP IS '';




PROMPT *** Create  constraint PK_ID_GROUP_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_GROUP_LOG ADD CONSTRAINT PK_ID_GROUP_LOG PRIMARY KEY (ID_GROUP_LOG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GROUPLOG_ID_GROUP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_GROUP_LOG ADD CONSTRAINT FK_GROUPLOG_ID_GROUP FOREIGN KEY (ID_GROUP)
	  REFERENCES BARS.TMS_TASK_GROUPS (ID_GROUP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ID_GROUP_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ID_GROUP_LOG ON BARS.TMS_GROUP_LOG (ID_GROUP_LOG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMS_GROUP_LOG ***
grant SELECT                                                                 on TMS_GROUP_LOG   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_GROUP_LOG.sql =========*** End ***
PROMPT ===================================================================================== 
