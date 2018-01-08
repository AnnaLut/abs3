

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_ERRORS_LOG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_ERRORS_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_ERRORS_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_ERRORS_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_ERRORS_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_ERRORS_LOG 
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




PROMPT *** ALTER_POLICIES to ESCR_ERRORS_LOG ***
 exec bpa.alter_policies('ESCR_ERRORS_LOG');


COMMENT ON TABLE BARS.ESCR_ERRORS_LOG IS 'Журнал помилок, виявлених при перевірці КД';
COMMENT ON COLUMN BARS.ESCR_ERRORS_LOG.ID IS '';
COMMENT ON COLUMN BARS.ESCR_ERRORS_LOG.DEAL_ID IS '';
COMMENT ON COLUMN BARS.ESCR_ERRORS_LOG.ERROR_ID IS '';
COMMENT ON COLUMN BARS.ESCR_ERRORS_LOG.ACTIVE_FLAG IS '';
COMMENT ON COLUMN BARS.ESCR_ERRORS_LOG.OPER_DATE IS '';



PROMPT *** Create  grants  ESCR_ERRORS_LOG ***
grant SELECT                                                                 on ESCR_ERRORS_LOG to BARSREADER_ROLE;
grant SELECT                                                                 on ESCR_ERRORS_LOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_ERRORS_LOG.sql =========*** End *
PROMPT ===================================================================================== 
