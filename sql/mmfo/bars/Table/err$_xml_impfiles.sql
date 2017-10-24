

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_XML_IMPFILES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_XML_IMPFILES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_XML_IMPFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_XML_IMPFILES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FN VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_XML_IMPFILES ***
 exec bpa.alter_policies('ERR$_XML_IMPFILES');


COMMENT ON TABLE BARS.ERR$_XML_IMPFILES IS 'DML Error Logging table for "XML_IMPFILES"';
COMMENT ON COLUMN BARS.ERR$_XML_IMPFILES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPFILES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPFILES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPFILES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPFILES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPFILES.FN IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPFILES.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPFILES.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPFILES.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_XML_IMPFILES.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_XML_IMPFILES.sql =========*** End
PROMPT ===================================================================================== 
