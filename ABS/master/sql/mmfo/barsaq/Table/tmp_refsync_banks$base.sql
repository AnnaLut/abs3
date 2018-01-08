

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_BANKS$BASE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_REFSYNC_BANKS$BASE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_REFSYNC_BANKS$BASE 
   (	MFO VARCHAR2(12), 
	SAB CHAR(4), 
	NB VARCHAR2(38), 
	KODG NUMBER(3,0), 
	BLK NUMBER(1,0), 
	MFOU VARCHAR2(12), 
	SSP NUMBER(1,0), 
	NMO CHAR(1), 
	ACTION CHAR(1), 
	CHANGE_DATE DATE, 
	CHANGE_NUMBER NUMBER, 
	SYSTEM_CHANGE_NUMBER NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_REFSYNC_BANKS$BASE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.MFO IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.SAB IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.NB IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.KODG IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.BLK IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.MFOU IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.SSP IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.NMO IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.ACTION IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.CHANGE_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_BANKS$BASE.SYSTEM_CHANGE_NUMBER IS '';




PROMPT *** Create  constraint SYS_C0010268 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BANKS$BASE MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010269 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BANKS$BASE MODIFY (SAB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010270 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_BANKS$BASE MODIFY (NB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REFSYNC_BANKS$BASE ***
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_BANKS$BASE to BARS;
grant SELECT                                                                 on TMP_REFSYNC_BANKS$BASE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_BANKS$BASE to KLBX;
grant SELECT                                                                 on TMP_REFSYNC_BANKS$BASE to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_BANKS$BASE.sql =========
PROMPT ===================================================================================== 
