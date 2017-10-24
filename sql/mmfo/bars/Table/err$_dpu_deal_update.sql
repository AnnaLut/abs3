

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPU_DEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPU_DEAL_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPU_DEAL_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPU_DEAL_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDU VARCHAR2(4000), 
	USERU VARCHAR2(4000), 
	DATEU VARCHAR2(4000), 
	TYPEU VARCHAR2(4000), 
	DPU_ID VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	VIDD VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	USER_ID VARCHAR2(4000), 
	FREQV VARCHAR2(4000), 
	SUM VARCHAR2(4000), 
	DAT_BEGIN VARCHAR2(4000), 
	DAT_END VARCHAR2(4000), 
	DATZ VARCHAR2(4000), 
	DATV VARCHAR2(4000), 
	MFO_D VARCHAR2(4000), 
	NLS_D VARCHAR2(4000), 
	NMS_D VARCHAR2(4000), 
	MFO_P VARCHAR2(4000), 
	NLS_P VARCHAR2(4000), 
	NMS_P VARCHAR2(4000), 
	COMMENTS VARCHAR2(4000), 
	CLOSED VARCHAR2(4000), 
	COMPROC VARCHAR2(4000), 
	DPU_GEN VARCHAR2(4000), 
	DPU_ADD VARCHAR2(4000), 
	MIN_SUM VARCHAR2(4000), 
	ID_STOP VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	TRUSTEE_ID VARCHAR2(4000), 
	ACC2 VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	BDATE VARCHAR2(4000), 
	CNT_DUBL VARCHAR2(4000), 
	OKPO_P VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPU_DEAL_UPDATE ***
 exec bpa.alter_policies('ERR$_DPU_DEAL_UPDATE');


COMMENT ON TABLE BARS.ERR$_DPU_DEAL_UPDATE IS 'DML Error Logging table for "DPU_DEAL_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.IDU IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.USERU IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.DATEU IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.TYPEU IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.DPU_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.VIDD IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.USER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.FREQV IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.SUM IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.DAT_END IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.DATZ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.DATV IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.MFO_D IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.NLS_D IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.NMS_D IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.MFO_P IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.NLS_P IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.NMS_P IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.COMMENTS IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.CLOSED IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.COMPROC IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.DPU_GEN IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.DPU_ADD IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.MIN_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.ID_STOP IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.TRUSTEE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.ACC2 IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.CNT_DUBL IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.OKPO_P IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEAL_UPDATE.EFFECTDATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPU_DEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
