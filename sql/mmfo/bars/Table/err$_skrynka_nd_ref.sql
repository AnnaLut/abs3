

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_ND_REF.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SKRYNKA_ND_REF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SKRYNKA_ND_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SKRYNKA_ND_REF 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	BDATE VARCHAR2(4000), 
	RENT VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_SKRYNKA_ND_REF ***
 exec bpa.alter_policies('ERR$_SKRYNKA_ND_REF');


COMMENT ON TABLE BARS.ERR$_SKRYNKA_ND_REF IS 'DML Error Logging table for "SKRYNKA_ND_REF"';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.ND IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.REF IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.RENT IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_REF.KF IS '';



PROMPT *** Create  grants  ERR$_SKRYNKA_ND_REF ***
grant SELECT                                                                 on ERR$_SKRYNKA_ND_REF to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SKRYNKA_ND_REF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_ND_REF.sql =========*** E
PROMPT ===================================================================================== 
