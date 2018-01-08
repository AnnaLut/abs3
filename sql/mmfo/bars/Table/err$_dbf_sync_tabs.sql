

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DBF_SYNC_TABS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DBF_SYNC_TABS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DBF_SYNC_TABS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DBF_SYNC_TABS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TABID VARCHAR2(4000), 
	S_SELECT VARCHAR2(4000), 
	S_INSERT VARCHAR2(4000), 
	S_UPDATE VARCHAR2(4000), 
	S_DELETE VARCHAR2(4000), 
	FILE_DATE VARCHAR2(4000), 
	SYNC_FLAG VARCHAR2(4000), 
	ENCODE VARCHAR2(4000), 
	FILE_NAME VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DBF_SYNC_TABS ***
 exec bpa.alter_policies('ERR$_DBF_SYNC_TABS');


COMMENT ON TABLE BARS.ERR$_DBF_SYNC_TABS IS 'DML Error Logging table for "DBF_SYNC_TABS"';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.TABID IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.S_SELECT IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.S_INSERT IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.S_UPDATE IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.S_DELETE IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.FILE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.SYNC_FLAG IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.ENCODE IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.FILE_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DBF_SYNC_TABS.ORA_ERR_MESG$ IS '';



PROMPT *** Create  grants  ERR$_DBF_SYNC_TABS ***
grant SELECT                                                                 on ERR$_DBF_SYNC_TABS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DBF_SYNC_TABS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DBF_SYNC_TABS.sql =========*** En
PROMPT ===================================================================================== 
