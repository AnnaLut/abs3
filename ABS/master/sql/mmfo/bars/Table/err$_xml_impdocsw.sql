

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_XML_IMPDOCSW.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_XML_IMPDOCSW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_XML_IMPDOCSW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_XML_IMPDOCSW 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IMPREF VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	VALUE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_XML_IMPDOCSW ***
 exec bpa.alter_policies('ERR$_XML_IMPDOCSW');


COMMENT ON TABLE BARS.ERR$_XML_IMPDOCSW IS 'DML Error Logging table for "XML_IMPDOCSW"';
COMMENT ON COLUMN BARS.ERR$_XML_IMPDOCSW.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPDOCSW.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPDOCSW.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPDOCSW.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPDOCSW.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPDOCSW.IMPREF IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPDOCSW.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPDOCSW.VALUE IS '';



PROMPT *** Create  grants  ERR$_XML_IMPDOCSW ***
grant SELECT                                                                 on ERR$_XML_IMPDOCSW to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_XML_IMPDOCSW to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_XML_IMPDOCSW.sql =========*** End
PROMPT ===================================================================================== 
