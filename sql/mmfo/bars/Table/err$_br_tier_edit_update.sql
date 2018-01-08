

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BR_TIER_EDIT_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BR_TIER_EDIT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BR_TIER_EDIT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BR_TIER_EDIT_UPDATE 
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
	BR_ID VARCHAR2(4000), 
	BDATE VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	S VARCHAR2(4000), 
	RATE VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BR_TIER_EDIT_UPDATE ***
 exec bpa.alter_policies('ERR$_BR_TIER_EDIT_UPDATE');


COMMENT ON TABLE BARS.ERR$_BR_TIER_EDIT_UPDATE IS 'DML Error Logging table for "BR_TIER_EDIT_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.BR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.KV IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.S IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.RATE IS '';
COMMENT ON COLUMN BARS.ERR$_BR_TIER_EDIT_UPDATE.BRANCH IS '';



PROMPT *** Create  grants  ERR$_BR_TIER_EDIT_UPDATE ***
grant SELECT                                                                 on ERR$_BR_TIER_EDIT_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_BR_TIER_EDIT_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BR_TIER_EDIT_UPDATE.sql =========
PROMPT ===================================================================================== 
