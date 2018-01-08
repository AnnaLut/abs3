

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_DAT_UPDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_DAT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_DAT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_DAT_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NPP VARCHAR2(4000), 
	DOK VARCHAR2(4000), 
	KUP VARCHAR2(4000), 
	CHG_DATE VARCHAR2(4000), 
	ACTION VARCHAR2(4000), 
	NOM VARCHAR2(4000), 
	IDUPD VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000), 
	EXPIRY_DATE VARCHAR2(4000), 
	IR VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_DAT_UPDATE ***
 exec bpa.alter_policies('ERR$_CP_DAT_UPDATE');


COMMENT ON TABLE BARS.ERR$_CP_DAT_UPDATE IS 'DML Error Logging table for "CP_DAT_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.NPP IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.DOK IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.KUP IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.CHG_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.ACTION IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.NOM IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.EXPIRY_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CP_DAT_UPDATE.IR IS '';



PROMPT *** Create  grants  ERR$_CP_DAT_UPDATE ***
grant SELECT                                                                 on ERR$_CP_DAT_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CP_DAT_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_DAT_UPDATE.sql =========*** En
PROMPT ===================================================================================== 
