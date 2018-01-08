

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_F42_HISTORY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTCN_F42_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTCN_F42_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTCN_F42_HISTORY 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	SUM VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	ODAT VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTCN_F42_HISTORY ***
 exec bpa.alter_policies('ERR$_OTCN_F42_HISTORY');


COMMENT ON TABLE BARS.ERR$_OTCN_F42_HISTORY IS 'DML Error Logging table for "OTCN_F42_HISTORY"';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.SUM IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.ODAT IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_HISTORY.KF IS '';



PROMPT *** Create  grants  ERR$_OTCN_F42_HISTORY ***
grant SELECT                                                                 on ERR$_OTCN_F42_HISTORY to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OTCN_F42_HISTORY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_F42_HISTORY.sql =========***
PROMPT ===================================================================================== 
