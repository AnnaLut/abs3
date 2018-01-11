

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_MATCHING_REQUEST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_MATCHING_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_MATCHING_REQUEST 
   (	ID NUMBER(10,0), 
	PFU_MATCHING_XML CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (PFU_MATCHING_XML) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_MATCHING_REQUEST IS 'Запит на відправку квітанцій';
COMMENT ON COLUMN PFU.PFU_MATCHING_REQUEST.ID IS '';
COMMENT ON COLUMN PFU.PFU_MATCHING_REQUEST.PFU_MATCHING_XML IS 'Китованция';



PROMPT *** Create  grants  PFU_MATCHING_REQUEST ***
grant SELECT                                                                 on PFU_MATCHING_REQUEST to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_MATCHING_REQUEST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_MATCHING_REQUEST.sql =========*** E
PROMPT ===================================================================================== 
