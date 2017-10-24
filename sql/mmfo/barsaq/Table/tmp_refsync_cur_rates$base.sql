

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_CUR_RATES$BASE.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_REFSYNC_CUR_RATES$BASE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_REFSYNC_CUR_RATES$BASE 
   (	KV NUMBER(3,0), 
	VDATE DATE, 
	BSUM NUMBER(9,4), 
	RATE_O NUMBER(9,4), 
	RATE_B NUMBER(9,4), 
	RATE_S NUMBER(9,4), 
	RATE_SPOT NUMBER(9,4), 
	RATE_FORWARD NUMBER(9,4), 
	LIM_POS NUMBER(24,0), 
	BRANCH VARCHAR2(30), 
	OTM VARCHAR2(1), 
	ACTION CHAR(1), 
	CHANGE_DATE DATE, 
	CHANGE_NUMBER NUMBER, 
	SYSTEM_CHANGE_NUMBER NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_REFSYNC_CUR_RATES$BASE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.KV IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.VDATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.BSUM IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.RATE_O IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.RATE_B IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.RATE_S IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.RATE_SPOT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.RATE_FORWARD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.LIM_POS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.BRANCH IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.OTM IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.ACTION IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.CHANGE_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_CUR_RATES$BASE.SYSTEM_CHANGE_NUMBER IS '';



PROMPT *** Create  grants  TMP_REFSYNC_CUR_RATES$BASE ***
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_CUR_RATES$BASE to BARS;
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_CUR_RATES$BASE to KLBX;
grant SELECT                                                                 on TMP_REFSYNC_CUR_RATES$BASE to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_CUR_RATES$BASE.sql =====
PROMPT ===================================================================================== 
