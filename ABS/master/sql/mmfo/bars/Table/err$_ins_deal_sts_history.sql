

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_INS_DEAL_STS_HISTORY.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_INS_DEAL_STS_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_INS_DEAL_STS_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_INS_DEAL_STS_HISTORY 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	DEAL_ID VARCHAR2(4000), 
	STATUS_ID VARCHAR2(4000), 
	SET_DATE VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	STAFF_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_INS_DEAL_STS_HISTORY ***
 exec bpa.alter_policies('ERR$_INS_DEAL_STS_HISTORY');


COMMENT ON TABLE BARS.ERR$_INS_DEAL_STS_HISTORY IS 'DML Error Logging table for "INS_DEAL_STS_HISTORY"';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.STAFF_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.DEAL_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.STATUS_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.SET_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_INS_DEAL_STS_HISTORY.COMM IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_INS_DEAL_STS_HISTORY.sql ========
PROMPT ===================================================================================== 
