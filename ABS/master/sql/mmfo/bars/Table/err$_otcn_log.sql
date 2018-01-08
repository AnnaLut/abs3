

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_LOG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTCN_LOG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTCN_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTCN_LOG 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	KODF VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTCN_LOG ***
 exec bpa.alter_policies('ERR$_OTCN_LOG');


COMMENT ON TABLE BARS.ERR$_OTCN_LOG IS 'DML Error Logging table for "OTCN_LOG"';
COMMENT ON COLUMN BARS.ERR$_OTCN_LOG.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_LOG.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_LOG.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_LOG.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_LOG.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_LOG.ID IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_LOG.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_LOG.KODF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_LOG.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_LOG.KF IS '';



PROMPT *** Create  grants  ERR$_OTCN_LOG ***
grant SELECT                                                                 on ERR$_OTCN_LOG   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OTCN_LOG   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_LOG.sql =========*** End ***
PROMPT ===================================================================================== 
