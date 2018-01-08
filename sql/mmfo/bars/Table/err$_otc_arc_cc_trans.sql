

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTC_ARC_CC_TRANS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTC_ARC_CC_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTC_ARC_CC_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTC_ARC_CC_TRANS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DAT_OTC VARCHAR2(4000), 
	NPP VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	SV VARCHAR2(4000), 
	SZ VARCHAR2(4000), 
	D_PLAN VARCHAR2(4000), 
	D_FAKT VARCHAR2(4000), 
	DAPP VARCHAR2(4000), 
	REFP VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTC_ARC_CC_TRANS ***
 exec bpa.alter_policies('ERR$_OTC_ARC_CC_TRANS');


COMMENT ON TABLE BARS.ERR$_OTC_ARC_CC_TRANS IS 'DML Error Logging table for "OTC_ARC_CC_TRANS"';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.DAT_OTC IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.NPP IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.REF IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.SV IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.SZ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.D_PLAN IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.D_FAKT IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.DAPP IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.REFP IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_TRANS.KF IS '';



PROMPT *** Create  grants  ERR$_OTC_ARC_CC_TRANS ***
grant SELECT                                                                 on ERR$_OTC_ARC_CC_TRANS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OTC_ARC_CC_TRANS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTC_ARC_CC_TRANS.sql =========***
PROMPT ===================================================================================== 
