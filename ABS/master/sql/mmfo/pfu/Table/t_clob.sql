

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/T_CLOB.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  table T_CLOB ***
begin 
  execute immediate '
  CREATE TABLE PFU.T_CLOB 
   (	ID NUMBER, 
	DATA1 CLOB, 
	DATA2 CLOB, 
	DATA3 CLOB, 
	DATA4 CLOB, 
	DATAB1 BLOB, 
	DATAB2 BLOB, 
	SYS_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (DATA1) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (DATA2) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (DATA3) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (DATA4) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (DATAB1) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (DATAB2) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.T_CLOB IS '';
COMMENT ON COLUMN PFU.T_CLOB.ID IS '';
COMMENT ON COLUMN PFU.T_CLOB.DATA1 IS '';
COMMENT ON COLUMN PFU.T_CLOB.DATA2 IS '';
COMMENT ON COLUMN PFU.T_CLOB.DATA3 IS '';
COMMENT ON COLUMN PFU.T_CLOB.DATA4 IS '';
COMMENT ON COLUMN PFU.T_CLOB.DATAB1 IS '';
COMMENT ON COLUMN PFU.T_CLOB.DATAB2 IS '';
COMMENT ON COLUMN PFU.T_CLOB.SYS_TIME IS '';



PROMPT *** Create  grants  T_CLOB ***
grant INSERT,SELECT                                                          on T_CLOB          to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/T_CLOB.sql =========*** End *** =======
PROMPT ===================================================================================== 
