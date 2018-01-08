

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DOC_ATTR.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DOC_ATTR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DOC_ATTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DOC_ATTR 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	FIELD VARCHAR2(4000), 
	SSQL VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DOC_ATTR ***
 exec bpa.alter_policies('ERR$_DOC_ATTR');


COMMENT ON TABLE BARS.ERR$_DOC_ATTR IS 'DML Error Logging table for "DOC_ATTR"';
COMMENT ON COLUMN BARS.ERR$_DOC_ATTR.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DOC_ATTR.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DOC_ATTR.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DOC_ATTR.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DOC_ATTR.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DOC_ATTR.ID IS '';
COMMENT ON COLUMN BARS.ERR$_DOC_ATTR.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_DOC_ATTR.FIELD IS '';
COMMENT ON COLUMN BARS.ERR$_DOC_ATTR.SSQL IS '';



PROMPT *** Create  grants  ERR$_DOC_ATTR ***
grant SELECT                                                                 on ERR$_DOC_ATTR   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DOC_ATTR   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DOC_ATTR.sql =========*** End ***
PROMPT ===================================================================================== 
