

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_TARIF_ARC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ACC_TARIF_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ACC_TARIF_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ACC_TARIF_ARC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	KOD VARCHAR2(4000), 
	TAR VARCHAR2(4000), 
	PR VARCHAR2(4000), 
	SMIN VARCHAR2(4000), 
	SMAX VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	USER_ID VARCHAR2(4000), 
	VID VARCHAR2(4000), 
	BDATE VARCHAR2(4000), 
	EDATE VARCHAR2(4000), 
	IDUPD VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	OST_AVG VARCHAR2(4000), 
	NDOK_RKO VARCHAR2(4000), 
	KV_SMIN VARCHAR2(4000), 
	KV_SMAX VARCHAR2(4000), 
	GLOBAL_BDATE VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ACC_TARIF_ARC ***
 exec bpa.alter_policies('ERR$_ACC_TARIF_ARC');


COMMENT ON TABLE BARS.ERR$_ACC_TARIF_ARC IS 'DML Error Logging table for "ACC_TARIF_ARC"';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.TAR IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.PR IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.SMIN IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.SMAX IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.USER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.VID IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.EDATE IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.KF IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.OST_AVG IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.NDOK_RKO IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.KV_SMIN IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.KV_SMAX IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.GLOBAL_BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_TARIF_ARC.EFFECTDATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_TARIF_ARC.sql =========*** En
PROMPT ===================================================================================== 