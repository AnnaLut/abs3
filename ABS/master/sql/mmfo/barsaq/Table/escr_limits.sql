

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_LIMITS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_LIMITS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_LIMITS 
   (	MFO VARCHAR2(6), 
	LIMIT NUMBER, 
	DATE_FROM DATE, 
	DATE_TO DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_LIMITS IS '';
COMMENT ON COLUMN BARSAQ.ESCR_LIMITS.MFO IS '';
COMMENT ON COLUMN BARSAQ.ESCR_LIMITS.LIMIT IS '';
COMMENT ON COLUMN BARSAQ.ESCR_LIMITS.DATE_FROM IS '';
COMMENT ON COLUMN BARSAQ.ESCR_LIMITS.DATE_TO IS '';



PROMPT *** Create  grants  ESCR_LIMITS ***
grant SELECT                                                                 on ESCR_LIMITS     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_LIMITS.sql =========*** End ***
PROMPT ===================================================================================== 
