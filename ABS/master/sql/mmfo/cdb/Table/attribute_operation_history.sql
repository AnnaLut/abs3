

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/ATTRIBUTE_OPERATION_HISTORY.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  table ATTRIBUTE_OPERATION_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE CDB.ATTRIBUTE_OPERATION_HISTORY 
   (	OPERATION_ID NUMBER(10,0), 
	ATTRIBUTE_HISTORY_ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.ATTRIBUTE_OPERATION_HISTORY IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_OPERATION_HISTORY.OPERATION_ID IS 'Идентификатор операции';
COMMENT ON COLUMN CDB.ATTRIBUTE_OPERATION_HISTORY.ATTRIBUTE_HISTORY_ID IS '';



PROMPT *** Create  grants  ATTRIBUTE_OPERATION_HISTORY ***
grant SELECT                                                                 on ATTRIBUTE_OPERATION_HISTORY to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/ATTRIBUTE_OPERATION_HISTORY.sql =======
PROMPT ===================================================================================== 
