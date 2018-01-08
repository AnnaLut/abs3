

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SH_TARIF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SH_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SH_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SH_TARIF 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDS VARCHAR2(4000), 
	KOD VARCHAR2(4000), 
	TAR VARCHAR2(4000), 
	PR VARCHAR2(4000), 
	SMIN VARCHAR2(4000), 
	SMAX VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	NBS_OB22 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SH_TARIF ***
 exec bpa.alter_policies('ERR$_SH_TARIF');


COMMENT ON TABLE BARS.ERR$_SH_TARIF IS 'DML Error Logging table for "SH_TARIF"';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.IDS IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.TAR IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.PR IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.SMIN IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.SMAX IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.KF IS '';
COMMENT ON COLUMN BARS.ERR$_SH_TARIF.NBS_OB22 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SH_TARIF.sql =========*** End ***
PROMPT ===================================================================================== 
