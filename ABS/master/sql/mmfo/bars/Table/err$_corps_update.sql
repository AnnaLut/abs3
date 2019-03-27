

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CORPS_UPDATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CORPS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CORPS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CORPS_UPDATE 
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
	RNK VARCHAR2(4000), 
	NMKU VARCHAR2(4000), 
	RUK VARCHAR2(4000), 
	TELR VARCHAR2(4000), 
	BUH VARCHAR2(4000), 
	TELB VARCHAR2(4000), 
	DOV VARCHAR2(4000), 
	BDOV VARCHAR2(4000), 
	EDOV VARCHAR2(4000), 
	NLSNEW VARCHAR2(4000), 
	MAINNLS VARCHAR2(4000), 
	MAINMFO VARCHAR2(4000), 
	MFONEW VARCHAR2(4000), 
	TEL_FAX VARCHAR2(4000), 
	E_MAIL VARCHAR2(4000), 
	SEAL_ID VARCHAR2(4000), 
	NMK VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CORPS_UPDATE ***
 exec bpa.alter_policies('ERR$_CORPS_UPDATE');


COMMENT ON TABLE BARS.ERR$_CORPS_UPDATE IS 'DML Error Logging table for "CORPS_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.NMKU IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.RUK IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.TELR IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.BUH IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.TELB IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.DOV IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.BDOV IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.EDOV IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.NLSNEW IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.MAINNLS IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.MAINMFO IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.MFONEW IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.TEL_FAX IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.E_MAIL IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.SEAL_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_UPDATE.NMK IS '';



PROMPT *** Create  grants  ERR$_CORPS_UPDATE ***
grant SELECT                                                                 on ERR$_CORPS_UPDATE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CORPS_UPDATE.sql =========*** End
PROMPT ===================================================================================== 