

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPU_DEALW_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPU_DEALW_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPU_DEALW_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPU_DEALW_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDUPD VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	BDATE VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	DPU_ID VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPU_DEALW_UPDATE ***
 exec bpa.alter_policies('ERR$_DPU_DEALW_UPDATE');


COMMENT ON TABLE BARS.ERR$_DPU_DEALW_UPDATE IS 'DML Error Logging table for "DPU_DEALW_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.DPU_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW_UPDATE.KF IS '';



PROMPT *** Create  grants  ERR$_DPU_DEALW_UPDATE ***
grant SELECT                                                                 on ERR$_DPU_DEALW_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPU_DEALW_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPU_DEALW_UPDATE.sql =========***
PROMPT ===================================================================================== 
