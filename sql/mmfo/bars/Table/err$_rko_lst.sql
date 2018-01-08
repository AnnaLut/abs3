

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_RKO_LST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_RKO_LST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_RKO_LST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_RKO_LST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	ACCD VARCHAR2(4000), 
	DAT0A VARCHAR2(4000), 
	DAT0B VARCHAR2(4000), 
	S0 VARCHAR2(4000), 
	DAT1A VARCHAR2(4000), 
	DAT1B VARCHAR2(4000), 
	ACC1 VARCHAR2(4000), 
	DAT2A VARCHAR2(4000), 
	DAT2B VARCHAR2(4000), 
	ACC2 VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	KOLDOK VARCHAR2(4000), 
	SUMDOK VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	CC_ID VARCHAR2(4000), 
	SDATE VARCHAR2(4000), 
	SOS VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_RKO_LST ***
 exec bpa.alter_policies('ERR$_RKO_LST');


COMMENT ON TABLE BARS.ERR$_RKO_LST IS 'DML Error Logging table for "RKO_LST"';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.ACCD IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.DAT0A IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.DAT0B IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.S0 IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.DAT1A IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.DAT1B IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.ACC1 IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.DAT2A IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.DAT2B IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.ACC2 IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.KF IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.KOLDOK IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.SUMDOK IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.ND IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.CC_ID IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.SDATE IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RKO_LST.ACC IS '';



PROMPT *** Create  grants  ERR$_RKO_LST ***
grant SELECT                                                                 on ERR$_RKO_LST    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_RKO_LST    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_RKO_LST.sql =========*** End *** 
PROMPT ===================================================================================== 
