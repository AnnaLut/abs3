

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_REG_XML_FILES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ESCR_REG_XML_FILES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ESCR_REG_XML_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ESCR_REG_XML_FILES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	OPER_DATE VARCHAR2(4000), 
	REG_COUNT VARCHAR2(4000), 
	REG_HEADER_COUNT VARCHAR2(4000), 
	REG_BODY_COUNT VARCHAR2(4000), 
	ERR_TEXT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ESCR_REG_XML_FILES ***
 exec bpa.alter_policies('ERR$_ESCR_REG_XML_FILES');


COMMENT ON TABLE BARS.ERR$_ESCR_REG_XML_FILES IS 'DML Error Logging table for "ESCR_REG_XML_FILES"';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.OPER_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.REG_COUNT IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.REG_HEADER_COUNT IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.REG_BODY_COUNT IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_XML_FILES.ERR_TEXT IS '';



PROMPT *** Create  grants  ERR$_ESCR_REG_XML_FILES ***
grant SELECT                                                                 on ERR$_ESCR_REG_XML_FILES to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ESCR_REG_XML_FILES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_REG_XML_FILES.sql =========*
PROMPT ===================================================================================== 
