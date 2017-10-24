

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMERW_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CUSTOMERW_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CUSTOMERW_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CUSTOMERW_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	IDUPD VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CUSTOMERW_UPDATE ***
 exec bpa.alter_policies('ERR$_CUSTOMERW_UPDATE');


COMMENT ON TABLE BARS.ERR$_CUSTOMERW_UPDATE IS 'DML Error Logging table for "CUSTOMERW_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW_UPDATE.IDUPD IS '';



PROMPT *** Create  grants  ERR$_CUSTOMERW_UPDATE ***
grant SELECT                                                                 on ERR$_CUSTOMERW_UPDATE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMERW_UPDATE.sql =========***
PROMPT ===================================================================================== 
