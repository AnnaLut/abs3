

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MGR_TBL_QUEUE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MGR_TBL_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MGR_TBL_QUEUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MGR_TBL_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MGR_TBL_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.MGR_TBL_QUEUE 
   (	ID NUMBER, 
	OWNER VARCHAR2(30 CHAR), 
	TABLE_NAME VARCHAR2(30 CHAR), 
	MODULE VARCHAR2(30 CHAR), 
	DESC_TBL VARCHAR2(255 CHAR), 
	COMMENT_MGR VARCHAR2(4000), 
	CLEAN VARCHAR2(1 CHAR), 
	CLEAN_PROC VARCHAR2(4000), 
	CLEAN_ORD NUMBER(30,0), 
	MIGRATION VARCHAR2(1 CHAR), 
	MIGRATION_PROC VARCHAR2(4000), 
	MIGRATION_ORD NUMBER(30,0), 
	MIGR_NSUP_COL_TYPE VARCHAR2(1 CHAR), 
	ROW_COUNT NUMBER, 
	SQNC_RESET VARCHAR2(1 CHAR), 
	SQNC_NAME VARCHAR2(30 CHAR), 
	SQNC_COLUMN VARCHAR2(30 CHAR), 
	KF VARCHAR2(1 CHAR), 
	BRANCH VARCHAR2(1 CHAR), 
	POLICY_MMFO VARCHAR2(1 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MGR_TBL_QUEUE ***
 exec bpa.alter_policies('MGR_TBL_QUEUE');


COMMENT ON TABLE BARS.MGR_TBL_QUEUE IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.ID IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.OWNER IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.MODULE IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.DESC_TBL IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.COMMENT_MGR IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.CLEAN IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.CLEAN_PROC IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.CLEAN_ORD IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.MIGRATION IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.MIGRATION_PROC IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.MIGRATION_ORD IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.MIGR_NSUP_COL_TYPE IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.ROW_COUNT IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.SQNC_RESET IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.SQNC_NAME IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.SQNC_COLUMN IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.KF IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.BRANCH IS '';
COMMENT ON COLUMN BARS.MGR_TBL_QUEUE.POLICY_MMFO IS '';




PROMPT *** Create  constraint MGR_TBL_QUEUE_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.MGR_TBL_QUEUE ADD CONSTRAINT MGR_TBL_QUEUE_PK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index MGR_TBL_QUEUE_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.MGR_TBL_QUEUE_PK ON BARS.MGR_TBL_QUEUE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MGR_TBL_QUEUE ***
grant SELECT                                                                 on MGR_TBL_QUEUE   to BARSREADER_ROLE;
grant SELECT                                                                 on MGR_TBL_QUEUE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MGR_TBL_QUEUE.sql =========*** End ***
PROMPT ===================================================================================== 
