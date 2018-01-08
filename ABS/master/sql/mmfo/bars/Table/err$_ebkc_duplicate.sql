

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_EBKC_DUPLICATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_EBKC_DUPLICATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_EBKC_DUPLICATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_EBKC_DUPLICATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KF VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	DUP_KF VARCHAR2(4000), 
	DUP_RNK VARCHAR2(4000), 
	CUST_TYPE VARCHAR2(4000), 
	INSDATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_EBKC_DUPLICATE ***
 exec bpa.alter_policies('ERR$_EBKC_DUPLICATE');


COMMENT ON TABLE BARS.ERR$_EBKC_DUPLICATE IS 'DML Error Logging table for "EBKC_DUPLICATE"';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.DUP_KF IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.DUP_RNK IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.CUST_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_DUPLICATE.INSDATE IS '';



PROMPT *** Create  grants  ERR$_EBKC_DUPLICATE ***
grant SELECT                                                                 on ERR$_EBKC_DUPLICATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_EBKC_DUPLICATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_EBKC_DUPLICATE.sql =========*** E
PROMPT ===================================================================================== 
