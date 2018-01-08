

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_ATTORNEY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SKRYNKA_ATTORNEY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SKRYNKA_ATTORNEY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SKRYNKA_ATTORNEY 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	DATE_FROM VARCHAR2(4000), 
	DATE_TO VARCHAR2(4000), 
	CANCEL_DATE VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_SKRYNKA_ATTORNEY ***
 exec bpa.alter_policies('ERR$_SKRYNKA_ATTORNEY');


COMMENT ON TABLE BARS.ERR$_SKRYNKA_ATTORNEY IS 'DML Error Logging table for "SKRYNKA_ATTORNEY"';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.ND IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.DATE_FROM IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.DATE_TO IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.CANCEL_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ATTORNEY.KF IS '';



PROMPT *** Create  grants  ERR$_SKRYNKA_ATTORNEY ***
grant SELECT                                                                 on ERR$_SKRYNKA_ATTORNEY to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SKRYNKA_ATTORNEY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_ATTORNEY.sql =========***
PROMPT ===================================================================================== 
