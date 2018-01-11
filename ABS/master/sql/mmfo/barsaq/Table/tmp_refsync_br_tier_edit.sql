

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_BR_TIER_EDIT.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_REFSYNC_BR_TIER_EDIT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_REFSYNC_BR_TIER_EDIT 
   (	BR_ID NUMBER(38,0), 
	BDATE DATE, 
	KV NUMBER(3,0), 
	S NUMBER(24,0), 
	RATE NUMBER(30,8), 
	BRANCH VARCHAR2(30), 
	ACTION CHAR(1), 
	CHANGE_DATE DATE, 
	CHANGE_NUMBER NUMBER, 
	SYSTEM_CHANGE_NUMBER NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_REFSYNC_BR_TIER_EDIT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_TIER_EDIT.BR_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_TIER_EDIT.BDATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_TIER_EDIT.KV IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_TIER_EDIT.S IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_TIER_EDIT.RATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_TIER_EDIT.BRANCH IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_TIER_EDIT.ACTION IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_TIER_EDIT.CHANGE_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_TIER_EDIT.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_TIER_EDIT.SYSTEM_CHANGE_NUMBER IS '';




PROMPT *** Create  constraint SYS_C0010393 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BR_TIER_EDIT MODIFY (BR_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010394 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BR_TIER_EDIT MODIFY (BDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010395 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BR_TIER_EDIT MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010396 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BR_TIER_EDIT MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010397 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BR_TIER_EDIT MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REFSYNC_BR_TIER_EDIT ***
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_BR_TIER_EDIT to BARS;
grant SELECT                                                                 on TMP_REFSYNC_BR_TIER_EDIT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_BR_TIER_EDIT to KLBX;
grant SELECT                                                                 on TMP_REFSYNC_BR_TIER_EDIT to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_BR_TIER_EDIT.sql =======
PROMPT ===================================================================================== 
