

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_OPLDOK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_REFSYNC_OPLDOK ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_REFSYNC_OPLDOK 
   (	REF NUMBER(38,0), 
	TT CHAR(3), 
	DK NUMBER(1,0), 
	ACC NUMBER(38,0), 
	FDAT DATE, 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	TXT VARCHAR2(70), 
	STMT NUMBER(38,0), 
	SOS NUMBER(1,0), 
	ID NUMBER(38,0), 
	KF VARCHAR2(6), 
	OTM NUMBER(*,0), 
	ACTION CHAR(1), 
	CHANGE_DATE DATE, 
	CHANGE_NUMBER NUMBER, 
	SYSTEM_CHANGE_NUMBER NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_REFSYNC_OPLDOK IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.REF IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.TT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.DK IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.ACC IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.FDAT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.S IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.SQ IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.TXT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.STMT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.SOS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.KF IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.OTM IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.ACTION IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.CHANGE_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_OPLDOK.SYSTEM_CHANGE_NUMBER IS '';



PROMPT *** Create  grants  TMP_REFSYNC_OPLDOK ***
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_OPLDOK to BARS;
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_OPLDOK to KLBX;
grant SELECT                                                                 on TMP_REFSYNC_OPLDOK to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_OPLDOK.sql =========*** 
PROMPT ===================================================================================== 
