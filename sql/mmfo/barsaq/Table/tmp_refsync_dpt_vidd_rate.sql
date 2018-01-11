

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_DPT_VIDD_RATE.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_REFSYNC_DPT_VIDD_RATE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE 
   (	ID NUMBER(38,0), 
	VIDD NUMBER(38,0), 
	TERM_M NUMBER(10,0), 
	TERM_D NUMBER, 
	LIMIT NUMBER, 
	RATE NUMBER(20,4), 
	DAT DATE, 
	ACTION CHAR(1), 
	CHANGE_DATE DATE, 
	CHANGE_NUMBER NUMBER, 
	SYSTEM_CHANGE_NUMBER NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.VIDD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.TERM_M IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.TERM_D IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.LIMIT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.RATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.DAT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.ACTION IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.CHANGE_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE.SYSTEM_CHANGE_NUMBER IS '';




PROMPT *** Create  constraint SYS_C0010298 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010299 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010300 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE MODIFY (TERM_M NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010301 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE MODIFY (TERM_D NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010302 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE MODIFY (LIMIT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010303 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE MODIFY (RATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010304 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD_RATE MODIFY (DAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REFSYNC_DPT_VIDD_RATE ***
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_DPT_VIDD_RATE to BARS;
grant SELECT                                                                 on TMP_REFSYNC_DPT_VIDD_RATE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_DPT_VIDD_RATE to KLBX;
grant SELECT                                                                 on TMP_REFSYNC_DPT_VIDD_RATE to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_DPT_VIDD_RATE.sql ======
PROMPT ===================================================================================== 
