

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FX_DEAL_ACC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FX_DEAL_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FX_DEAL_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FX_DEAL_ACC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	FX_TYPE VARCHAR2(4000), 
	KV_TYPE VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	ACC9 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FX_DEAL_ACC ***
 exec bpa.alter_policies('ERR$_FX_DEAL_ACC');


COMMENT ON TABLE BARS.ERR$_FX_DEAL_ACC IS 'DML Error Logging table for "FX_DEAL_ACC"';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.ID IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.FX_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.KV_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.KV IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_ACC.ACC9 IS '';



PROMPT *** Create  grants  ERR$_FX_DEAL_ACC ***
grant SELECT                                                                 on ERR$_FX_DEAL_ACC to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_FX_DEAL_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FX_DEAL_ACC.sql =========*** End 
PROMPT ===================================================================================== 
