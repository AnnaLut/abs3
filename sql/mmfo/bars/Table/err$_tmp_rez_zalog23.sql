

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_REZ_ZALOG23.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TMP_REZ_ZALOG23 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TMP_REZ_ZALOG23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TMP_REZ_ZALOG23 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DAT VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	ACCS VARCHAR2(4000), 
	ACCZ VARCHAR2(4000), 
	PAWN VARCHAR2(4000), 
	S VARCHAR2(4000), 
	PROC VARCHAR2(4000), 
	SALL VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	DAY_IMP VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	GRP VARCHAR2(4000), 
	ZPR VARCHAR2(4000), 
	ZPRQ VARCHAR2(4000), 
	S031 VARCHAR2(4000), 
	PVZ VARCHAR2(4000), 
	PVZQ VARCHAR2(4000), 
	SQ VARCHAR2(4000), 
	SALLQ VARCHAR2(4000), 
	DAT_P VARCHAR2(4000), 
	IRR0 VARCHAR2(4000), 
	S_L VARCHAR2(4000), 
	SQ_L VARCHAR2(4000), 
	SUM_IMP VARCHAR2(4000), 
	SUMQ_IMP VARCHAR2(4000), 
	PV VARCHAR2(4000), 
	K VARCHAR2(4000), 
	PR_IMP VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TMP_REZ_ZALOG23 ***
 exec bpa.alter_policies('ERR$_TMP_REZ_ZALOG23');


COMMENT ON TABLE BARS.ERR$_TMP_REZ_ZALOG23 IS 'DML Error Logging table for "TMP_REZ_ZALOG23"';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.ACCS IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.ACCZ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.PAWN IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.S IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.PROC IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.SALL IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.ND IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.DAY_IMP IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.KV IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.GRP IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.ZPR IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.ZPRQ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.S031 IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.PVZ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.PVZQ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.SQ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.SALLQ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.DAT_P IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.IRR0 IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.S_L IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.SQ_L IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.SUM_IMP IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.SUMQ_IMP IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.PV IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.K IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.PR_IMP IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_REZ_ZALOG23.KF IS '';



PROMPT *** Create  grants  ERR$_TMP_REZ_ZALOG23 ***
grant SELECT                                                                 on ERR$_TMP_REZ_ZALOG23 to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_TMP_REZ_ZALOG23 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_REZ_ZALOG23.sql =========*** 
PROMPT ===================================================================================== 
