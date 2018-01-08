

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_TECHACCOUNTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_TECHACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_TECHACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_TECHACCOUNTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DPT_ID VARCHAR2(4000), 
	TECH_ACC VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	DPT_ACC VARCHAR2(4000), 
	DPT_DATBEGIN VARCHAR2(4000), 
	DPT_DATEND VARCHAR2(4000), 
	TECH_DATEND VARCHAR2(4000), 
	DPT_IDUPD VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_TECHACCOUNTS ***
 exec bpa.alter_policies('ERR$_DPT_TECHACCOUNTS');


COMMENT ON TABLE BARS.ERR$_DPT_TECHACCOUNTS IS 'DML Error Logging table for "DPT_TECHACCOUNTS"';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.DPT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.TECH_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.DPT_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.DPT_DATBEGIN IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.DPT_DATEND IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.TECH_DATEND IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.DPT_IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.KF IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TECHACCOUNTS.BRANCH IS '';



PROMPT *** Create  grants  ERR$_DPT_TECHACCOUNTS ***
grant SELECT                                                                 on ERR$_DPT_TECHACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_TECHACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_TECHACCOUNTS.sql =========***
PROMPT ===================================================================================== 
