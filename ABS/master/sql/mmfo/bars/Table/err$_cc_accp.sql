

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_ACCP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_ACCP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_ACCP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_ACCP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
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




PROMPT *** ALTER_POLICIES to ERR$_CC_ACCP ***
 exec bpa.alter_policies('ERR$_CC_ACCP');


COMMENT ON TABLE BARS.ERR$_CC_ACCP IS 'DML Error Logging table for "CC_ACCP"';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.ACCS IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.PR_12 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.IDZ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.KF IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.MPAWN IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.PAWN IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ACCP.RNK IS '';



PROMPT *** Create  grants  ERR$_CC_ACCP ***
grant SELECT                                                                 on ERR$_CC_ACCP    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CC_ACCP    to BARS_DM;
grant SELECT                                                                 on ERR$_CC_ACCP    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_ACCP.sql =========*** End *** 
PROMPT ===================================================================================== 
