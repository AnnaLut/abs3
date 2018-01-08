

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_ERRORS_TYPES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_ERRORS_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_ERRORS_TYPES 
   (	ID NUMBER, 
	DESCRIPTION VARCHAR2(400)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_ERRORS_TYPES IS '';
COMMENT ON COLUMN BARSAQ.ESCR_ERRORS_TYPES.ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_ERRORS_TYPES.DESCRIPTION IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_ERRORS_TYPES.sql =========*** E
PROMPT ===================================================================================== 
