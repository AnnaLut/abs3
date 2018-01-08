

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_DPT_VIDD.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_REFSYNC_DPT_VIDD ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD 
   (	VIDD NUMBER(38,0), 
	DEPOSIT_COD VARCHAR2(4), 
	TYPE_NAME VARCHAR2(50), 
	BASEY NUMBER(*,0), 
	BASEM NUMBER(*,0), 
	BR_ID NUMBER(38,0), 
	FREQ_N NUMBER(3,0), 
	FREQ_K NUMBER(3,0), 
	BSD CHAR(4), 
	BSN CHAR(4), 
	METR NUMBER(1,0), 
	AMR_METR NUMBER, 
	DURATION NUMBER(10,0), 
	TERM_TYPE NUMBER, 
	MIN_SUMM NUMBER(24,0), 
	COMMENTS VARCHAR2(128), 
	FLAG NUMBER(1,0), 
	TYPE_COD VARCHAR2(4), 
	KV NUMBER(3,0), 
	TT CHAR(3), 
	SHABLON VARCHAR2(15), 
	IDG NUMBER(38,0), 
	IDS NUMBER(38,0), 
	NLS_K VARCHAR2(15), 
	DATN DATE, 
	DATK DATE, 
	BR_ID_L NUMBER(38,0), 
	FL_DUBL NUMBER(1,0), 
	ACC7 NUMBER(38,0), 
	ID_STOP NUMBER(38,0), 
	KODZ NUMBER(38,0), 
	FMT NUMBER(2,0), 
	FL_2620 NUMBER(1,0), 
	COMPROC NUMBER(1,0), 
	LIMIT NUMBER(24,0), 
	TERM_ADD NUMBER(7,2), 
	TERM_DUBL NUMBER(10,0), 
	DURATION_DAYS NUMBER(10,0), 
	EXTENSION_ID NUMBER(38,0), 
	TIP_OST NUMBER(1,0), 
	BR_WD NUMBER(38,0), 
	NLSN_K VARCHAR2(14), 
	BSA CHAR(4), 
	MAX_LIMIT NUMBER(24,0), 
	BR_BONUS NUMBER(38,0), 
	BR_OP NUMBER(38,0), 
	AUTO_ADD NUMBER(1,0), 
	TYPE_ID NUMBER(38,0), 
	ACTION CHAR(1), 
	CHANGE_DATE DATE, 
	CHANGE_NUMBER NUMBER, 
	SYSTEM_CHANGE_NUMBER NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.IDG IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.IDS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.NLS_K IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.DATN IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.DATK IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.BR_ID_L IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.FL_DUBL IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.ACC7 IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.ID_STOP IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.KODZ IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.FMT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.FL_2620 IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.COMPROC IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.LIMIT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.TERM_ADD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.TERM_DUBL IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.DURATION_DAYS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.EXTENSION_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.TIP_OST IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.BR_WD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.NLSN_K IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.BSA IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.MAX_LIMIT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.BR_BONUS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.BR_OP IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.AUTO_ADD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.TYPE_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.ACTION IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.CHANGE_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.SYSTEM_CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.VIDD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.DEPOSIT_COD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.TYPE_NAME IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.BASEY IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.BASEM IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.BR_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.FREQ_N IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.FREQ_K IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.BSD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.BSN IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.METR IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.AMR_METR IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.DURATION IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.TERM_TYPE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.MIN_SUMM IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.COMMENTS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.FLAG IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.TYPE_COD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.KV IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.TT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_DPT_VIDD.SHABLON IS '';




PROMPT *** Create  constraint SYS_C0010457 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010481 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010459 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (BASEY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010460 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (BASEM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010461 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (FREQ_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010462 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (FREQ_K NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010463 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (BSD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010464 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (BSN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010465 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (METR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010466 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (AMR_METR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010467 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (DURATION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010468 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (TERM_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010469 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (FLAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010470 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010471 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (FL_DUBL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010472 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (ID_STOP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010473 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (FL_2620 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010474 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (COMPROC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010475 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (TERM_DUBL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010476 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (DURATION_DAYS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010477 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (TIP_OST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010478 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (BR_BONUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010479 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (BR_OP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010480 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (AUTO_ADD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010458 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_DPT_VIDD MODIFY (TYPE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REFSYNC_DPT_VIDD ***
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_DPT_VIDD to BARS;
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_DPT_VIDD to KLBX;
grant SELECT                                                                 on TMP_REFSYNC_DPT_VIDD to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_DPT_VIDD.sql =========**
PROMPT ===================================================================================== 
