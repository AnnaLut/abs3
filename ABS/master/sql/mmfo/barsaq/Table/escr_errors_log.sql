

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_ERRORS_LOG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_ERRORS_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_ERRORS_LOG 
   (	ID NUMBER, 
	DEAL_ID NUMBER, 
	ERROR_ID NUMBER, 
	ACTIVE_FLAG NUMBER, 
	OPER_DATE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_ERRORS_LOG IS '';
COMMENT ON COLUMN BARSAQ.ESCR_ERRORS_LOG.ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_ERRORS_LOG.DEAL_ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_ERRORS_LOG.ERROR_ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_ERRORS_LOG.ACTIVE_FLAG IS '';
COMMENT ON COLUMN BARSAQ.ESCR_ERRORS_LOG.OPER_DATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_ERRORS_LOG.sql =========*** End
PROMPT ===================================================================================== 
