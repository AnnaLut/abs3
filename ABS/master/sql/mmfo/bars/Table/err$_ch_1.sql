

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CH_1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CH_1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CH_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CH_1 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	S VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	IDS VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	BIC_E VARCHAR2(4000), 
	FIO VARCHAR2(4000), 
	KOL VARCHAR2(4000), 
	NOM VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	TOBO VARCHAR2(4000), 
	REF1 VARCHAR2(4000), 
	REF2 VARCHAR2(4000), 
	REF3 VARCHAR2(4000), 
	REF4 VARCHAR2(4000), 
	REF5 VARCHAR2(4000), 
	REF6 VARCHAR2(4000), 
	MFOA VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CH_1 ***
 exec bpa.alter_policies('ERR$_CH_1');


COMMENT ON TABLE BARS.ERR$_CH_1 IS 'DML Error Logging table for "CH_1"';
COMMENT ON COLUMN BARS.ERR$_CH_1.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.S IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.IDS IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.BIC_E IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.FIO IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.KOL IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.NOM IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.TOBO IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.REF1 IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.REF2 IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.REF3 IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.REF4 IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.REF5 IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.REF6 IS '';
COMMENT ON COLUMN BARS.ERR$_CH_1.MFOA IS '';



PROMPT *** Create  grants  ERR$_CH_1 ***
grant SELECT                                                                 on ERR$_CH_1       to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CH_1       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CH_1.sql =========*** End *** ===
PROMPT ===================================================================================== 
