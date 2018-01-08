

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_INSTALL_LOG.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_INSTALL_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_INSTALL_LOG 
   (	INS_DATE DATE DEFAULT SYSDATE, 
	INSTALL_PACK_ID VARCHAR2(400), 
	BVER_PACKAGE VARCHAR2(4000), 
	COUNT_OF_ERR NUMBER, 
	INVALID_ESCR NUMBER, 
	COMMENTS VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_INSTALL_LOG IS '';
COMMENT ON COLUMN BARSAQ.ESCR_INSTALL_LOG.INS_DATE IS '';
COMMENT ON COLUMN BARSAQ.ESCR_INSTALL_LOG.INSTALL_PACK_ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_INSTALL_LOG.BVER_PACKAGE IS '';
COMMENT ON COLUMN BARSAQ.ESCR_INSTALL_LOG.COUNT_OF_ERR IS '';
COMMENT ON COLUMN BARSAQ.ESCR_INSTALL_LOG.INVALID_ESCR IS '';
COMMENT ON COLUMN BARSAQ.ESCR_INSTALL_LOG.COMMENTS IS '';



PROMPT *** Create  grants  ESCR_INSTALL_LOG ***
grant SELECT                                                                 on ESCR_INSTALL_LOG to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_INSTALL_LOG.sql =========*** En
PROMPT ===================================================================================== 
