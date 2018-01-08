

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ND_VAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ND_VAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ND_VAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ND_VAL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	TIPA VARCHAR2(4000), 
	KOL VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	FIN VARCHAR2(4000), 
	TIP_FIN VARCHAR2(4000), 
	ISTVAL VARCHAR2(4000), 
	S080 VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ND_VAL ***
 exec bpa.alter_policies('ERR$_ND_VAL');


COMMENT ON TABLE BARS.ERR$_ND_VAL IS 'DML Error Logging table for "ND_VAL"';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.ND IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.TIPA IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.KOL IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.FIN IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.TIP_FIN IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.ISTVAL IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.S080 IS '';
COMMENT ON COLUMN BARS.ERR$_ND_VAL.KF IS '';



PROMPT *** Create  grants  ERR$_ND_VAL ***
grant SELECT                                                                 on ERR$_ND_VAL     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ND_VAL     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ND_VAL.sql =========*** End *** =
PROMPT ===================================================================================== 
