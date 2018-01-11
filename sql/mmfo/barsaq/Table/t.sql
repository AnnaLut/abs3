

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/T.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  table T ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.T 
   (	SCN NUMBER, 
	START_SCN NUMBER, 
	COMMIT_SCN NUMBER, 
	TIMESTAMP DATE, 
	START_TIMESTAMP DATE, 
	COMMIT_TIMESTAMP DATE, 
	XIDUSN NUMBER, 
	XIDSLT NUMBER, 
	XIDSQN NUMBER, 
	XID RAW(8), 
	PXIDUSN NUMBER, 
	PXIDSLT NUMBER, 
	PXIDSQN NUMBER, 
	PXID RAW(8), 
	TX_NAME VARCHAR2(256), 
	OPERATION VARCHAR2(32), 
	OPERATION_CODE NUMBER, 
	ROLLBACK NUMBER, 
	SEG_OWNER VARCHAR2(32), 
	SEG_NAME VARCHAR2(256), 
	TABLE_NAME VARCHAR2(32), 
	SEG_TYPE NUMBER, 
	SEG_TYPE_NAME VARCHAR2(32), 
	TABLE_SPACE VARCHAR2(32), 
	ROW_ID VARCHAR2(18), 
	USERNAME VARCHAR2(30), 
	OS_USERNAME VARCHAR2(4000), 
	MACHINE_NAME VARCHAR2(4000), 
	AUDIT_SESSIONID NUMBER, 
	SESSION# NUMBER, 
	SERIAL# NUMBER, 
	SESSION_INFO VARCHAR2(4000), 
	THREAD# NUMBER, 
	SEQUENCE# NUMBER, 
	RBASQN NUMBER, 
	RBABLK NUMBER, 
	RBABYTE NUMBER, 
	UBAFIL NUMBER, 
	UBABLK NUMBER, 
	UBAREC NUMBER, 
	UBASQN NUMBER, 
	ABS_FILE# NUMBER, 
	REL_FILE# NUMBER, 
	DATA_BLK# NUMBER, 
	DATA_OBJ# NUMBER, 
	DATA_OBJV# NUMBER, 
	DATA_OBJD# NUMBER, 
	SQL_REDO VARCHAR2(4000), 
	SQL_UNDO VARCHAR2(4000), 
	RS_ID VARCHAR2(32), 
	SSN NUMBER, 
	CSF NUMBER, 
	INFO VARCHAR2(32), 
	STATUS NUMBER, 
	REDO_VALUE NUMBER, 
	UNDO_VALUE NUMBER, 
	SAFE_RESUME_SCN NUMBER, 
	CSCN NUMBER, 
	OBJECT_ID RAW(16), 
	EDITION_NAME VARCHAR2(30), 
	CLIENT_ID VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.T IS '';
COMMENT ON COLUMN BARSAQ.T.SCN IS '';
COMMENT ON COLUMN BARSAQ.T.START_SCN IS '';
COMMENT ON COLUMN BARSAQ.T.COMMIT_SCN IS '';
COMMENT ON COLUMN BARSAQ.T.TIMESTAMP IS '';
COMMENT ON COLUMN BARSAQ.T.START_TIMESTAMP IS '';
COMMENT ON COLUMN BARSAQ.T.COMMIT_TIMESTAMP IS '';
COMMENT ON COLUMN BARSAQ.T.XIDUSN IS '';
COMMENT ON COLUMN BARSAQ.T.XIDSLT IS '';
COMMENT ON COLUMN BARSAQ.T.XIDSQN IS '';
COMMENT ON COLUMN BARSAQ.T.XID IS '';
COMMENT ON COLUMN BARSAQ.T.PXIDUSN IS '';
COMMENT ON COLUMN BARSAQ.T.PXIDSLT IS '';
COMMENT ON COLUMN BARSAQ.T.PXIDSQN IS '';
COMMENT ON COLUMN BARSAQ.T.PXID IS '';
COMMENT ON COLUMN BARSAQ.T.TX_NAME IS '';
COMMENT ON COLUMN BARSAQ.T.OPERATION IS '';
COMMENT ON COLUMN BARSAQ.T.OPERATION_CODE IS '';
COMMENT ON COLUMN BARSAQ.T.ROLLBACK IS '';
COMMENT ON COLUMN BARSAQ.T.SEG_OWNER IS '';
COMMENT ON COLUMN BARSAQ.T.SEG_NAME IS '';
COMMENT ON COLUMN BARSAQ.T.TABLE_NAME IS '';
COMMENT ON COLUMN BARSAQ.T.SEG_TYPE IS '';
COMMENT ON COLUMN BARSAQ.T.SEG_TYPE_NAME IS '';
COMMENT ON COLUMN BARSAQ.T.TABLE_SPACE IS '';
COMMENT ON COLUMN BARSAQ.T.ROW_ID IS '';
COMMENT ON COLUMN BARSAQ.T.USERNAME IS '';
COMMENT ON COLUMN BARSAQ.T.OS_USERNAME IS '';
COMMENT ON COLUMN BARSAQ.T.MACHINE_NAME IS '';
COMMENT ON COLUMN BARSAQ.T.AUDIT_SESSIONID IS '';
COMMENT ON COLUMN BARSAQ.T.SESSION# IS '';
COMMENT ON COLUMN BARSAQ.T.SERIAL# IS '';
COMMENT ON COLUMN BARSAQ.T.SESSION_INFO IS '';
COMMENT ON COLUMN BARSAQ.T.THREAD# IS '';
COMMENT ON COLUMN BARSAQ.T.SEQUENCE# IS '';
COMMENT ON COLUMN BARSAQ.T.RBASQN IS '';
COMMENT ON COLUMN BARSAQ.T.RBABLK IS '';
COMMENT ON COLUMN BARSAQ.T.RBABYTE IS '';
COMMENT ON COLUMN BARSAQ.T.UBAFIL IS '';
COMMENT ON COLUMN BARSAQ.T.UBABLK IS '';
COMMENT ON COLUMN BARSAQ.T.UBAREC IS '';
COMMENT ON COLUMN BARSAQ.T.UBASQN IS '';
COMMENT ON COLUMN BARSAQ.T.ABS_FILE# IS '';
COMMENT ON COLUMN BARSAQ.T.REL_FILE# IS '';
COMMENT ON COLUMN BARSAQ.T.DATA_BLK# IS '';
COMMENT ON COLUMN BARSAQ.T.DATA_OBJ# IS '';
COMMENT ON COLUMN BARSAQ.T.DATA_OBJV# IS '';
COMMENT ON COLUMN BARSAQ.T.DATA_OBJD# IS '';
COMMENT ON COLUMN BARSAQ.T.SQL_REDO IS '';
COMMENT ON COLUMN BARSAQ.T.SQL_UNDO IS '';
COMMENT ON COLUMN BARSAQ.T.RS_ID IS '';
COMMENT ON COLUMN BARSAQ.T.SSN IS '';
COMMENT ON COLUMN BARSAQ.T.CSF IS '';
COMMENT ON COLUMN BARSAQ.T.INFO IS '';
COMMENT ON COLUMN BARSAQ.T.STATUS IS '';
COMMENT ON COLUMN BARSAQ.T.REDO_VALUE IS '';
COMMENT ON COLUMN BARSAQ.T.UNDO_VALUE IS '';
COMMENT ON COLUMN BARSAQ.T.SAFE_RESUME_SCN IS '';
COMMENT ON COLUMN BARSAQ.T.CSCN IS '';
COMMENT ON COLUMN BARSAQ.T.OBJECT_ID IS '';
COMMENT ON COLUMN BARSAQ.T.EDITION_NAME IS '';
COMMENT ON COLUMN BARSAQ.T.CLIENT_ID IS '';



PROMPT *** Create  grants  T ***
grant SELECT                                                                 on T               to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/T.sql =========*** End *** =========
PROMPT ===================================================================================== 
