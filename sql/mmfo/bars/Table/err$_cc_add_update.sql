

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_ADD_UPDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_ADD_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_ADD_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_ADD_UPDATE 
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
	ND VARCHAR2(4000), 
	ADDS VARCHAR2(4000), 
	AIM VARCHAR2(4000), 
	S VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	BDATE VARCHAR2(4000), 
	WDATE VARCHAR2(4000), 
	ACCS VARCHAR2(4000), 
	ACCP VARCHAR2(4000), 
	SOUR VARCHAR2(4000), 
	ACCKRED VARCHAR2(4000), 
	MFOKRED VARCHAR2(4000), 
	FREQ VARCHAR2(4000), 
	PDATE VARCHAR2(4000), 
	REFV VARCHAR2(4000), 
	REFP VARCHAR2(4000), 
	ACCPERC VARCHAR2(4000), 
	MFOPERC VARCHAR2(4000), 
	SWI_BIC VARCHAR2(4000), 
	SWI_ACC VARCHAR2(4000), 
	SWI_REF VARCHAR2(4000), 
	SWO_BIC VARCHAR2(4000), 
	SWO_ACC VARCHAR2(4000), 
	SWO_REF VARCHAR2(4000), 
	INT_AMOUNT VARCHAR2(4000), 
	ALT_PARTYB VARCHAR2(4000), 
	INTERM_B VARCHAR2(4000), 
	INT_PARTYA VARCHAR2(4000), 
	INT_PARTYB VARCHAR2(4000), 
	INT_INTERMA VARCHAR2(4000), 
	INT_INTERMB VARCHAR2(4000), 
	SSUDA VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	OKPOKRED VARCHAR2(4000), 
	NAMKRED VARCHAR2(4000), 
	NAZNKRED VARCHAR2(4000), 
	NLS_1819 VARCHAR2(4000), 
	FIELD_58D VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_ADD_UPDATE ***
 exec bpa.alter_policies('ERR$_CC_ADD_UPDATE');


COMMENT ON TABLE BARS.ERR$_CC_ADD_UPDATE IS 'DML Error Logging table for "CC_ADD_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ADDS IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.AIM IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.S IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.WDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ACCS IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ACCP IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.SOUR IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ACCKRED IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.MFOKRED IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.FREQ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.PDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.REFV IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.REFP IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ACCPERC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.MFOPERC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.SWI_BIC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.SWI_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.SWI_REF IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.SWO_BIC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.SWO_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.SWO_REF IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.INT_AMOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.ALT_PARTYB IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.INTERM_B IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.INT_PARTYA IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.INT_PARTYB IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.INT_INTERMA IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.INT_INTERMB IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.SSUDA IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.OKPOKRED IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.NAMKRED IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.NAZNKRED IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.NLS_1819 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_ADD_UPDATE.FIELD_58D IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_ADD_UPDATE.sql =========*** En
PROMPT ===================================================================================== 
