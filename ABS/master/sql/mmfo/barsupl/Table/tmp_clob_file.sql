

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/TMP_CLOB_FILE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_CLOB_FILE ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.TMP_CLOB_FILE 
   (	FILENAME VARCHAR2(100), 
	LOAD_DATE DATE, 
	LEN NUMBER, 
	TEXT CLOB, 
	BIN BLOB, 
	BF BFILE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD 
 LOB (TEXT) STORE AS BASICFILE (
  TABLESPACE BRSUPLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (BIN) STORE AS BASICFILE (
  TABLESPACE BRSUPLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.TMP_CLOB_FILE IS '';
COMMENT ON COLUMN BARSUPL.TMP_CLOB_FILE.FILENAME IS '';
COMMENT ON COLUMN BARSUPL.TMP_CLOB_FILE.LOAD_DATE IS '';
COMMENT ON COLUMN BARSUPL.TMP_CLOB_FILE.LEN IS '';
COMMENT ON COLUMN BARSUPL.TMP_CLOB_FILE.TEXT IS '';
COMMENT ON COLUMN BARSUPL.TMP_CLOB_FILE.BIN IS '';
COMMENT ON COLUMN BARSUPL.TMP_CLOB_FILE.BF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/TMP_CLOB_FILE.sql =========*** End 
PROMPT ===================================================================================== 
