

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_REPLACEMENT_REQUEST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_REPLACEMENT_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_REPLACEMENT_REQUEST 
   (	ID NUMBER(10,0), 
	PFU_REPLACEMENT_XML CLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (PFU_REPLACEMENT_XML) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_REPLACEMENT_REQUEST IS 'Запит на відправку повідомлення про зміну рахунку';
COMMENT ON COLUMN PFU.PFU_REPLACEMENT_REQUEST.ID IS '';
COMMENT ON COLUMN PFU.PFU_REPLACEMENT_REQUEST.PFU_REPLACEMENT_XML IS 'Повідомлення';



PROMPT *** Create  grants  PFU_REPLACEMENT_REQUEST ***
grant SELECT                                                                 on PFU_REPLACEMENT_REQUEST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_REPLACEMENT_REQUEST.sql =========**
PROMPT ===================================================================================== 
