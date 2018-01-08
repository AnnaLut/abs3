

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_BRATES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_REFSYNC_BRATES ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_REFSYNC_BRATES 
   (	BR_ID NUMBER(38,0), 
	BR_TYPE NUMBER(38,0), 
	NAME VARCHAR2(35), 
	FORMULA VARCHAR2(250), 
	ACTION CHAR(1), 
	CHANGE_DATE DATE, 
	CHANGE_NUMBER NUMBER, 
	SYSTEM_CHANGE_NUMBER NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_REFSYNC_BRATES IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BRATES.BR_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BRATES.BR_TYPE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BRATES.NAME IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BRATES.FORMULA IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BRATES.ACTION IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BRATES.CHANGE_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BRATES.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BRATES.SYSTEM_CHANGE_NUMBER IS '';




PROMPT *** Create  constraint SYS_C0010290 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BRATES MODIFY (BR_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010291 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BRATES MODIFY (BR_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010292 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BRATES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REFSYNC_BRATES ***
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_BRATES to BARS;
grant SELECT                                                                 on TMP_REFSYNC_BRATES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_BRATES to KLBX;
grant SELECT                                                                 on TMP_REFSYNC_BRATES to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_BRATES.sql =========*** 
PROMPT ===================================================================================== 
