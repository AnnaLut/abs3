

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_FM_UPDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FIN_FM_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FIN_FM_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FIN_FM_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	OKPO VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	FM VARCHAR2(4000), 
	DATE_F1 VARCHAR2(4000), 
	DATE_F2 VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	IDUPD VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FIN_FM_UPDATE ***
 exec bpa.alter_policies('ERR$_FIN_FM_UPDATE');


COMMENT ON TABLE BARS.ERR$_FIN_FM_UPDATE IS 'DML Error Logging table for "FIN_FM_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.FM IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.DATE_F1 IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.DATE_F2 IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM_UPDATE.IDUPD IS '';



PROMPT *** Create  grants  ERR$_FIN_FM_UPDATE ***
grant SELECT                                                                 on ERR$_FIN_FM_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_FIN_FM_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_FM_UPDATE.sql =========*** En
PROMPT ===================================================================================== 
