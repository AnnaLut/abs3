

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_NBU23_REZ.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_NBU23_REZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_NBU23_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_NBU23_REZ 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	NBS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	CC_ID VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	FIN VARCHAR2(4000), 
	OBS VARCHAR2(4000), 
	KAT VARCHAR2(4000), 
	K VARCHAR2(4000), 
	IRR VARCHAR2(4000), 
	ZAL VARCHAR2(4000), 
	BV VARCHAR2(4000), 
	PV VARCHAR2(4000), 
	REZ VARCHAR2(4000), 
	REZQ VARCHAR2(4000), 
	DD VARCHAR2(4000), 
	DDD VARCHAR2(4000), 
	BVQ VARCHAR2(4000), 
	CUSTTYPE VARCHAR2(4000), 
	IDR VARCHAR2(4000), 
	WDATE VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	NMK VARCHAR2(4000), 
	RZ VARCHAR2(4000), 
	PAWN VARCHAR2(4000), 
	ISTVAL VARCHAR2(4000), 
	R013 VARCHAR2(4000), 
	REZN VARCHAR2(4000), 
	REZNQ VARCHAR2(4000), 
	ARJK VARCHAR2(4000), 
	PVZ VARCHAR2(4000), 
	PVZQ VARCHAR2(4000), 
	ZALQ VARCHAR2(4000), 
	ZPR VARCHAR2(4000), 
	ZPRQ VARCHAR2(4000), 
	PVQ VARCHAR2(4000), 
	RU VARCHAR2(4000), 
	INN VARCHAR2(4000), 
	NRC VARCHAR2(4000), 
	SDATE VARCHAR2(4000), 
	IR VARCHAR2(4000), 
	S031 VARCHAR2(4000), 
	K040 VARCHAR2(4000), 
	PROD VARCHAR2(4000), 
	K110 VARCHAR2(4000), 
	K070 VARCHAR2(4000), 
	K051 VARCHAR2(4000), 
	S260 VARCHAR2(4000), 
	R011 VARCHAR2(4000), 
	R012 VARCHAR2(4000), 
	S240 VARCHAR2(4000), 
	S180 VARCHAR2(4000), 
	S580 VARCHAR2(4000), 
	NLS_REZ VARCHAR2(4000), 
	NLS_REZN VARCHAR2(4000), 
	S250 VARCHAR2(4000), 
	ACC_REZ VARCHAR2(4000), 
	FIN_R VARCHAR2(4000), 
	DISKONT VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	OB22 VARCHAR2(4000), 
	TIP VARCHAR2(4000), 
	SPEC VARCHAR2(4000), 
	ZAL_BL VARCHAR2(4000), 
	S280_290 VARCHAR2(4000), 
	ZAL_BLQ VARCHAR2(4000), 
	REZD VARCHAR2(4000), 
	ACC_REZN VARCHAR2(4000), 
	OB22_REZ VARCHAR2(4000), 
	OB22_REZN VARCHAR2(4000), 
	IR0 VARCHAR2(4000), 
	IRR0 VARCHAR2(4000), 
	ND_CP VARCHAR2(4000), 
	SUM_IMP VARCHAR2(4000), 
	SUMQ_IMP VARCHAR2(4000), 
	PV_ZAL VARCHAR2(4000), 
	VKR VARCHAR2(4000), 
	S_L VARCHAR2(4000), 
	SQ_L VARCHAR2(4000), 
	ZAL_SV VARCHAR2(4000), 
	ZAL_SVQ VARCHAR2(4000), 
	GRP VARCHAR2(4000), 
	KOL_SP VARCHAR2(4000), 
	PVP VARCHAR2(4000), 
	BV_30 VARCHAR2(4000), 
	BVQ_30 VARCHAR2(4000), 
	REZ_30 VARCHAR2(4000), 
	REZQ_30 VARCHAR2(4000), 
	NLS_REZ_30 VARCHAR2(4000), 
	ACC_REZ_30 VARCHAR2(4000), 
	BV_0 VARCHAR2(4000), 
	BVQ_0 VARCHAR2(4000), 
	REZ_0 VARCHAR2(4000), 
	REZQ_0 VARCHAR2(4000), 
	NLS_REZ_0 VARCHAR2(4000), 
	ACC_REZ_0 VARCHAR2(4000), 
	REZ39 VARCHAR2(4000), 
	S250_23 VARCHAR2(4000), 
	KAT39 VARCHAR2(4000), 
	REZQ39 VARCHAR2(4000), 
	S250_39 VARCHAR2(4000), 
	REZ23 VARCHAR2(4000), 
	REZQ23 VARCHAR2(4000), 
	KAT23 VARCHAR2(4000), 
	DAT_MI VARCHAR2(4000), 
	OB22_REZ_30 VARCHAR2(4000), 
	OB22_REZ_0 VARCHAR2(4000), 
	TIPA VARCHAR2(4000), 
	BVUQ VARCHAR2(4000), 
	BVU VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_NBU23_REZ ***
 exec bpa.alter_policies('ERR$_NBU23_REZ');


COMMENT ON TABLE BARS.ERR$_NBU23_REZ IS 'DML Error Logging table for "NBU23_REZ"';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.K070 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.K051 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.S260 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.R011 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.R012 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.S240 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.S180 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.S580 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.NLS_REZ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.NLS_REZN IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.S250 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ACC_REZ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.FIN_R IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.DISKONT IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.OB22 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.TIP IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.SPEC IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ZAL_BL IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.S280_290 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ZAL_BLQ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZD IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ACC_REZN IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.OB22_REZ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.OB22_REZN IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.IR0 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.IRR0 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ND_CP IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.SUM_IMP IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.SUMQ_IMP IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.PV_ZAL IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.VKR IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.S_L IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.SQ_L IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ZAL_SV IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ZAL_SVQ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.GRP IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.KOL_SP IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.PVP IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.BV_30 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.BVQ_30 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZ_30 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZQ_30 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.NLS_REZ_30 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ACC_REZ_30 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.BV_0 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.BVQ_0 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZ_0 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZQ_0 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.NLS_REZ_0 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ACC_REZ_0 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZ39 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.S250_23 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.KAT39 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZQ39 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.S250_39 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZ23 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZQ23 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.KAT23 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.DAT_MI IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.OB22_REZ_30 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.OB22_REZ_0 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.TIPA IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.BVUQ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.BVU IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.KF IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ID IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.KV IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ND IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.CC_ID IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.FIN IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.OBS IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.KAT IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.K IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.IRR IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ZAL IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.BV IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.PV IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZQ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.DD IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.DDD IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.BVQ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.IDR IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.WDATE IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.NMK IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.RZ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.PAWN IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ISTVAL IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.R013 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZN IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.REZNQ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ARJK IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.PVZ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.PVZQ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ZALQ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ZPR IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.ZPRQ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.PVQ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.RU IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.INN IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.NRC IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.SDATE IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.IR IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.S031 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.K040 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.PROD IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_REZ.K110 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_NBU23_REZ.sql =========*** End **
PROMPT ===================================================================================== 
