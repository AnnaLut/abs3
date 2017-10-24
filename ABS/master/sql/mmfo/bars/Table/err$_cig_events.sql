

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIG_EVENTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIG_EVENTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIG_EVENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIG_EVENTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	EVT_ID VARCHAR2(4000), 
	EVT_DATE VARCHAR2(4000), 
	EVT_UNAME VARCHAR2(4000), 
	EVT_STATE_ID VARCHAR2(4000), 
	EVT_MESSAGE VARCHAR2(4000), 
	EVT_ORAERR VARCHAR2(4000), 
	EVT_ND VARCHAR2(4000), 
	EVT_RNK VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	EVT_DTYPE VARCHAR2(4000), 
	EVT_CUSTTYPE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIG_EVENTS ***
 exec bpa.alter_policies('ERR$_CIG_EVENTS');


COMMENT ON TABLE BARS.ERR$_CIG_EVENTS IS 'DML Error Logging table for "CIG_EVENTS"';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.EVT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.EVT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.EVT_UNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.EVT_STATE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.EVT_MESSAGE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.EVT_ORAERR IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.EVT_ND IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.EVT_RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.EVT_DTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_EVENTS.EVT_CUSTTYPE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIG_EVENTS.sql =========*** End *
PROMPT ===================================================================================== 
