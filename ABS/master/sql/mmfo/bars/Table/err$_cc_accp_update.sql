

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_ACCP_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_ACCP_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_ACCP_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_ACCP_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDUPD VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	ACCS VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	PR_12 VARCHAR2(4000), 
	IDZ VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	MPAWN VARCHAR2(4000), 
	PAWN VARCHAR2(4000), 
	RNK VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_ACCP_UPDATE ***
 exec bpa.alter_policies('ERR$_CC_ACCP_UPDATE');


COMMENT ON TABLE BARS.ERR$_CC_ACCP_UPDATE IS 'DML Error Logging table for "CC_ACCP_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.ACCS IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.PR_12 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.IDZ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.MPAWN IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.PAWN IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP_UPDATE.RNK IS '';



PROMPT *** Create  grants  ERR$_CC_ACCP_UPDATE ***
grant SELECT                                                                 on ERR$_CC_ACCP_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CC_ACCP_UPDATE to BARS_DM;
grant SELECT                                                                 on ERR$_CC_ACCP_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_ACCP_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
