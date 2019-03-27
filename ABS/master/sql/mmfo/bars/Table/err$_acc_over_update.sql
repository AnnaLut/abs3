

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_OVER_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ACC_OVER_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ACC_OVER_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ACC_OVER_UPDATE 
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
	ACC VARCHAR2(4000), 
	ACCO VARCHAR2(4000), 
	TIPO VARCHAR2(4000), 
	FLAG VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	DAY VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	DATD VARCHAR2(4000), 
	SD VARCHAR2(4000), 
	NDOC VARCHAR2(4000), 
	VIDD VARCHAR2(4000), 
	DATD2 VARCHAR2(4000), 
	KRL VARCHAR2(4000), 
	USEOSTF VARCHAR2(4000), 
	USELIM VARCHAR2(4000), 
	ACC_9129 VARCHAR2(4000), 
	ACC_8000 VARCHAR2(4000), 
	OBS VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	DELETED VARCHAR2(4000), 
	PR_2600A VARCHAR2(4000), 
	PR_KOMIS VARCHAR2(4000), 
	PR_9129 VARCHAR2(4000), 
	PR_2069 VARCHAR2(4000), 
	ACC_2067 VARCHAR2(4000), 
	ACC_2069 VARCHAR2(4000), 
	ACC_2096 VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	ACC_3739 VARCHAR2(4000), 
	KAT23 VARCHAR2(4000), 
	FIN23 VARCHAR2(4000), 
	OBS23 VARCHAR2(4000), 
	K23 VARCHAR2(4000), 
	FIN VARCHAR2(4000), 
	ACC_3600 VARCHAR2(4000), 
	S_3600 VARCHAR2(4000), 
	FLAG_3600 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ACC_OVER_UPDATE ***
 exec bpa.alter_policies('ERR$_ACC_OVER_UPDATE');


COMMENT ON TABLE BARS.ERR$_ACC_OVER_UPDATE IS 'DML Error Logging table for "ACC_OVER_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.KRL IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.USEOSTF IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.USELIM IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ACC_9129 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ACC_8000 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.OBS IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.DELETED IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.PR_2600A IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.PR_KOMIS IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.PR_9129 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.PR_2069 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ACC_2067 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ACC_2069 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ACC_2096 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ACC_3739 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.KAT23 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.FIN23 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.OBS23 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.K23 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.FIN IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ACC_3600 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.S_3600 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.FLAG_3600 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ACCO IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.TIPO IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.FLAG IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.DAY IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.DATD IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.SD IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.NDOC IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.VIDD IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_UPDATE.DATD2 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_OVER_UPDATE.sql =========*** 
PROMPT ===================================================================================== 