

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_MANY_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_MANY_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_MANY_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_MANY_UPDATE 
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
	REF VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	SS1 VARCHAR2(4000), 
	SDP VARCHAR2(4000), 
	SN2 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_MANY_UPDATE ***
 exec bpa.alter_policies('ERR$_CP_MANY_UPDATE');


COMMENT ON TABLE BARS.ERR$_CP_MANY_UPDATE IS 'DML Error Logging table for "CP_MANY_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.REF IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.SS1 IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.SDP IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPDATE.SN2 IS '';



PROMPT *** Create  grants  ERR$_CP_MANY_UPDATE ***
grant SELECT                                                                 on ERR$_CP_MANY_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CP_MANY_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_MANY_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
