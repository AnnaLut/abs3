

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PRVN_FLOW_DEALS_VAR.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PRVN_FLOW_DEALS_VAR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PRVN_FLOW_DEALS_VAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PRVN_FLOW_DEALS_VAR 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	ZDAT VARCHAR2(4000), 
	K VARCHAR2(4000), 
	OST VARCHAR2(4000), 
	OST8 VARCHAR2(4000), 
	OSTQ VARCHAR2(4000), 
	OST8Q VARCHAR2(4000), 
	IR VARCHAR2(4000), 
	IRR0 VARCHAR2(4000), 
	PV VARCHAR2(4000), 
	PV0 VARCHAR2(4000), 
	WDATE VARCHAR2(4000), 
	SN VARCHAR2(4000), 
	CR9 VARCHAR2(4000), 
	SPN VARCHAR2(4000), 
	SNO VARCHAR2(4000), 
	SN8 VARCHAR2(4000), 
	SK0 VARCHAR2(4000), 
	SK9 VARCHAR2(4000), 
	SDI VARCHAR2(4000), 
	S36 VARCHAR2(4000), 
	SP VARCHAR2(4000), 
	K1 VARCHAR2(4000), 
	VIDD VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	I_CR9 VARCHAR2(4000), 
	PR_TR VARCHAR2(4000), 
	BV VARCHAR2(4000), 
	S36U VARCHAR2(4000), 
	ZO VARCHAR2(4000), 
	FV_REZB VARCHAR2(4000), 
	FV_REZ9 VARCHAR2(4000), 
	SNA VARCHAR2(4000), 
	SD1 VARCHAR2(4000), 
	SD2 VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PRVN_FLOW_DEALS_VAR ***
 exec bpa.alter_policies('ERR$_PRVN_FLOW_DEALS_VAR');


COMMENT ON TABLE BARS.ERR$_PRVN_FLOW_DEALS_VAR IS 'DML Error Logging table for "PRVN_FLOW_DEALS_VAR"';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.ID IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.ZDAT IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.K IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.OST IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.OST8 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.OSTQ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.OST8Q IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.IR IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.IRR0 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.PV IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.PV0 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.WDATE IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SN IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.CR9 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SPN IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SNO IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SN8 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SK0 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SK9 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SDI IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.S36 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SP IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.K1 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.VIDD IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.I_CR9 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.PR_TR IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.BV IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.S36U IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.ZO IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.FV_REZB IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.FV_REZ9 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SNA IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SD1 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.SD2 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.KF IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FLOW_DEALS_VAR.ORA_ERR_MESG$ IS '';



PROMPT *** Create  grants  ERR$_PRVN_FLOW_DEALS_VAR ***
grant SELECT                                                                 on ERR$_PRVN_FLOW_DEALS_VAR to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_PRVN_FLOW_DEALS_VAR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PRVN_FLOW_DEALS_VAR.sql =========
PROMPT ===================================================================================== 
