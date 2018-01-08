

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_VISIT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SKRYNKA_VISIT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SKRYNKA_VISIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SKRYNKA_VISIT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	DATIN VARCHAR2(4000), 
	DATOUT VARCHAR2(4000), 
	DATSYS VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_SKRYNKA_VISIT ***
 exec bpa.alter_policies('ERR$_SKRYNKA_VISIT');


COMMENT ON TABLE BARS.ERR$_SKRYNKA_VISIT IS 'DML Error Logging table for "SKRYNKA_VISIT"';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.ND IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.DATIN IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.DATOUT IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.DATSYS IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_VISIT.KF IS '';



PROMPT *** Create  grants  ERR$_SKRYNKA_VISIT ***
grant SELECT                                                                 on ERR$_SKRYNKA_VISIT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SKRYNKA_VISIT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_VISIT.sql =========*** En
PROMPT ===================================================================================== 
