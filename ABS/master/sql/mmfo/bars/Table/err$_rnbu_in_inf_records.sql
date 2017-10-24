

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_RNBU_IN_INF_RECORDS.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_RNBU_IN_INF_RECORDS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_RNBU_IN_INF_RECORDS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_RNBU_IN_INF_RECORDS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RECORD_ID VARCHAR2(4000), 
	FILE_ID VARCHAR2(4000), 
	ISRESIDENT VARCHAR2(4000), 
	NBUCODE VARCHAR2(4000), 
	PARAMETER VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_RNBU_IN_INF_RECORDS ***
 exec bpa.alter_policies('ERR$_RNBU_IN_INF_RECORDS');


COMMENT ON TABLE BARS.ERR$_RNBU_IN_INF_RECORDS IS 'DML Error Logging table for "RNBU_IN_INF_RECORDS"';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.RECORD_ID IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.FILE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.ISRESIDENT IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.NBUCODE IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.PARAMETER IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_IN_INF_RECORDS.KF IS '';



PROMPT *** Create  grants  ERR$_RNBU_IN_INF_RECORDS ***
grant SELECT                                                                 on ERR$_RNBU_IN_INF_RECORDS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_RNBU_IN_INF_RECORDS.sql =========
PROMPT ===================================================================================== 
