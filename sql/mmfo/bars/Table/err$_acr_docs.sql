

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ACR_DOCS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ACR_DOCS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ACR_DOCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ACR_DOCS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	INT_DATE VARCHAR2(4000), 
	INT_REF VARCHAR2(4000), 
	INT_REST VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ACR_DOCS ***
 exec bpa.alter_policies('ERR$_ACR_DOCS');


COMMENT ON TABLE BARS.ERR$_ACR_DOCS IS 'DML Error Logging table for "ACR_DOCS"';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.INT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.INT_REF IS '';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.INT_REST IS '';
COMMENT ON COLUMN BARS.ERR$_ACR_DOCS.KF IS '';



PROMPT *** Create  grants  ERR$_ACR_DOCS ***
grant SELECT                                                                 on ERR$_ACR_DOCS   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ACR_DOCS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ACR_DOCS.sql =========*** End ***
PROMPT ===================================================================================== 
