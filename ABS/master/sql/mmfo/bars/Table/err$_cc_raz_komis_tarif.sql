

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_RAZ_KOMIS_TARIF.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_RAZ_KOMIS_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_RAZ_KOMIS_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_RAZ_KOMIS_TARIF 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KOD VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	TAR VARCHAR2(4000), 
	PR VARCHAR2(4000), 
	TIP VARCHAR2(4000), 
	SMIN VARCHAR2(4000), 
	SMAX VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_RAZ_KOMIS_TARIF ***
 exec bpa.alter_policies('ERR$_CC_RAZ_KOMIS_TARIF');


COMMENT ON TABLE BARS.ERR$_CC_RAZ_KOMIS_TARIF IS 'DML Error Logging table for "CC_RAZ_KOMIS_TARIF"';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.TAR IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.PR IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.TIP IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.SMIN IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.SMAX IS '';
COMMENT ON COLUMN BARS.ERR$_CC_RAZ_KOMIS_TARIF.KF IS '';



PROMPT *** Create  grants  ERR$_CC_RAZ_KOMIS_TARIF ***
grant SELECT                                                                 on ERR$_CC_RAZ_KOMIS_TARIF to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CC_RAZ_KOMIS_TARIF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_RAZ_KOMIS_TARIF.sql =========*
PROMPT ===================================================================================== 
