

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_ND_BRANCH.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SKRYNKA_ND_BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SKRYNKA_ND_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SKRYNKA_ND_BRANCH 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	O_SK VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	OPEN_DATE VARCHAR2(4000), 
	CLOSE_DATE VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	RENTER_NAME VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SKRYNKA_ND_BRANCH ***
 exec bpa.alter_policies('ERR$_SKRYNKA_ND_BRANCH');


COMMENT ON TABLE BARS.ERR$_SKRYNKA_ND_BRANCH IS 'DML Error Logging table for "SKRYNKA_ND_BRANCH"';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.O_SK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.ND IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.OPEN_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.CLOSE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_BRANCH.RENTER_NAME IS '';



PROMPT *** Create  grants  ERR$_SKRYNKA_ND_BRANCH ***
grant SELECT                                                                 on ERR$_SKRYNKA_ND_BRANCH to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SKRYNKA_ND_BRANCH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_ND_BRANCH.sql =========**
PROMPT ===================================================================================== 
