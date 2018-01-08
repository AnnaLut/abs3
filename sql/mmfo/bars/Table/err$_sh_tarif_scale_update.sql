

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SH_TARIF_SCALE_UPDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SH_TARIF_SCALE_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SH_TARIF_SCALE_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SH_TARIF_SCALE_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDUPD VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	GLOBAL_BDATE VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	IDS VARCHAR2(4000), 
	KOD VARCHAR2(4000), 
	SUM_LIMIT VARCHAR2(4000), 
	SUM_TARIF VARCHAR2(4000), 
	PR VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	SMIN VARCHAR2(4000), 
	SMAX VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SH_TARIF_SCALE_UPDATE ***
 exec bpa.alter_policies('ERR$_SH_TARIF_SCALE_UPDATE');


COMMENT ON TABLE BARS.ERR$_SH_TARIF_SCALE_UPDATE IS 'DML Error Logging table for "SH_TARIF_SCALE_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.GLOBAL_BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.IDS IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.SUM_LIMIT IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.SUM_TARIF IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.PR IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.SMIN IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF_SCALE_UPDATE.SMAX IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SH_TARIF_SCALE_UPDATE.sql =======
PROMPT ===================================================================================== 
