

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PB_1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PB_1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PB_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PB_1 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	LN VARCHAR2(4000), 
	DEN VARCHAR2(4000), 
	MEC VARCHAR2(4000), 
	GOD VARCHAR2(4000), 
	BAKOD VARCHAR2(4000), 
	COUNKOD VARCHAR2(4000), 
	PARTN VARCHAR2(4000), 
	VALKOD VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KOR VARCHAR2(4000), 
	KRE VARCHAR2(4000), 
	DEB VARCHAR2(4000), 
	COUN VARCHAR2(4000), 
	KOD VARCHAR2(4000), 
	PODK VARCHAR2(4000), 
	OPER VARCHAR2(4000), 
	NAL VARCHAR2(4000), 
	BANK VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	REFC VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PB_1 ***
 exec bpa.alter_policies('ERR$_PB_1');


COMMENT ON TABLE BARS.ERR$_PB_1 IS 'DML Error Logging table for "PB_1"';
COMMENT ON COLUMN BARS.ERR$_PB_1.PODK IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.OPER IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.NAL IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.BANK IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.TT IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.REFC IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.KF IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.LN IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.DEN IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.MEC IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.GOD IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.BAKOD IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.COUNKOD IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.PARTN IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.VALKOD IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.KOR IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.KRE IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.DEB IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.COUN IS '';
COMMENT ON COLUMN BARS.ERR$_PB_1.KOD IS '';



PROMPT *** Create  grants  ERR$_PB_1 ***
grant SELECT                                                                 on ERR$_PB_1       to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_PB_1       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PB_1.sql =========*** End *** ===
PROMPT ===================================================================================== 
