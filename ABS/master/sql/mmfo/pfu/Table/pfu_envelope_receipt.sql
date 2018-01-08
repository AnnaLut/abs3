

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_ENVELOPE_RECEIPT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_ENVELOPE_RECEIPT ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_ENVELOPE_RECEIPT 
   (	ID NUMBER, 
	PFU_ENVELOPE_ID NUMBER(10,0), 
	RECEIPT_TYPE NUMBER(2,0), 
	STATE NUMBER(2,0), 
	SYS_TIME DATE, 
	RECEIPT_DATA CLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (RECEIPT_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_ENVELOPE_RECEIPT IS '';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_RECEIPT.ID IS '';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_RECEIPT.PFU_ENVELOPE_ID IS '';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_RECEIPT.RECEIPT_TYPE IS '';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_RECEIPT.STATE IS '';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_RECEIPT.SYS_TIME IS '';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_RECEIPT.RECEIPT_DATA IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_ENVELOPE_RECEIPT.sql =========*** E
PROMPT ===================================================================================== 
