

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIG_DOG_SYNC_PARAMS.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIG_DOG_SYNC_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIG_DOG_SYNC_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIG_DOG_SYNC_PARAMS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	DATA_TYPE VARCHAR2(4000), 
	SYNC_TYPE VARCHAR2(4000), 
	IS_SYNC VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIG_DOG_SYNC_PARAMS ***
 exec bpa.alter_policies('ERR$_CIG_DOG_SYNC_PARAMS');


COMMENT ON TABLE BARS.ERR$_CIG_DOG_SYNC_PARAMS IS 'DML Error Logging table for "CIG_DOG_SYNC_PARAMS"';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_SYNC_PARAMS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_SYNC_PARAMS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_SYNC_PARAMS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_SYNC_PARAMS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_SYNC_PARAMS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_SYNC_PARAMS.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_SYNC_PARAMS.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_SYNC_PARAMS.DATA_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_SYNC_PARAMS.SYNC_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_SYNC_PARAMS.IS_SYNC IS '';



PROMPT *** Create  grants  ERR$_CIG_DOG_SYNC_PARAMS ***
grant SELECT                                                                 on ERR$_CIG_DOG_SYNC_PARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIG_DOG_SYNC_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIG_DOG_SYNC_PARAMS.sql =========
PROMPT ===================================================================================== 
