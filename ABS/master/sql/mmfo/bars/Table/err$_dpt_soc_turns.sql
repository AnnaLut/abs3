

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_SOC_TURNS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_SOC_TURNS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_SOC_TURNS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_SOC_TURNS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	DATE1 VARCHAR2(4000), 
	DATE2 VARCHAR2(4000), 
	OST_REAL VARCHAR2(4000), 
	DOS_REAL VARCHAR2(4000), 
	KOS_REAL VARCHAR2(4000), 
	DOS_SOCIAL VARCHAR2(4000), 
	KOS_SOCIAL VARCHAR2(4000), 
	OST_SOCIAL VARCHAR2(4000), 
	REFS VARCHAR2(4000), 
	OST_FOR_TAX VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_SOC_TURNS ***
 exec bpa.alter_policies('ERR$_DPT_SOC_TURNS');


COMMENT ON TABLE BARS.ERR$_DPT_SOC_TURNS IS 'DML Error Logging table for "DPT_SOC_TURNS"';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.DATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.DATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.OST_REAL IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.DOS_REAL IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.KOS_REAL IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.DOS_SOCIAL IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.KOS_SOCIAL IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.OST_SOCIAL IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.REFS IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_SOC_TURNS.OST_FOR_TAX IS '';



PROMPT *** Create  grants  ERR$_DPT_SOC_TURNS ***
grant SELECT                                                                 on ERR$_DPT_SOC_TURNS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_SOC_TURNS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_SOC_TURNS.sql =========*** En
PROMPT ===================================================================================== 
