

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_REPVP_NOLIMITUSR.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_REPVP_NOLIMITUSR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_REPVP_NOLIMITUSR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_REPVP_NOLIMITUSR 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	USERID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_REPVP_NOLIMITUSR ***
 exec bpa.alter_policies('ERR$_REPVP_NOLIMITUSR');


COMMENT ON TABLE BARS.ERR$_REPVP_NOLIMITUSR IS 'DML Error Logging table for "REPVP_NOLIMITUSR"';
COMMENT ON COLUMN BARS.ERR$_REPVP_NOLIMITUSR.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_REPVP_NOLIMITUSR.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REPVP_NOLIMITUSR.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_REPVP_NOLIMITUSR.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_REPVP_NOLIMITUSR.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REPVP_NOLIMITUSR.USERID IS '';



PROMPT *** Create  grants  ERR$_REPVP_NOLIMITUSR ***
grant SELECT                                                                 on ERR$_REPVP_NOLIMITUSR to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_REPVP_NOLIMITUSR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_REPVP_NOLIMITUSR.sql =========***
PROMPT ===================================================================================== 
