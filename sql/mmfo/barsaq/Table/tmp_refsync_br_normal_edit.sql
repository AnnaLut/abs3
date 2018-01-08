

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_BR_NORMAL_EDIT.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_REFSYNC_BR_NORMAL_EDIT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT 
   (	BR_ID NUMBER(38,0), 
	BDATE DATE, 
	KV NUMBER(3,0), 
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


COMMENT ON TABLE BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT.BR_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT.BDATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT.KV IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT.RATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT.BRANCH IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT.ACTION IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT.CHANGE_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT.SYSTEM_CHANGE_NUMBER IS '';




PROMPT *** Create  constraint SYS_C0010433 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT MODIFY (BR_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010436 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010435 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010434 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BR_NORMAL_EDIT MODIFY (BDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REFSYNC_BR_NORMAL_EDIT ***
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_BR_NORMAL_EDIT to BARS;
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_BR_NORMAL_EDIT to KLBX;
grant SELECT                                                                 on TMP_REFSYNC_BR_NORMAL_EDIT to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_BR_NORMAL_EDIT.sql =====
PROMPT ===================================================================================== 
