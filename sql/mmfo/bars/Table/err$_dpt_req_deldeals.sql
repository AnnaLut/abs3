

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_REQ_DELDEALS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_REQ_DELDEALS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_REQ_DELDEALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_REQ_DELDEALS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REQ_ID VARCHAR2(4000), 
	USER_ID VARCHAR2(4000), 
	USER_BDATE VARCHAR2(4000), 
	USER_DATE VARCHAR2(4000), 
	USER_STATE VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_REQ_DELDEALS ***
 exec bpa.alter_policies('ERR$_DPT_REQ_DELDEALS');


COMMENT ON TABLE BARS.ERR$_DPT_REQ_DELDEALS IS 'DML Error Logging table for "DPT_REQ_DELDEALS"';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.REQ_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.USER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.USER_BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.USER_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.USER_STATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.KF IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_DELDEALS.BRANCH IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_REQ_DELDEALS.sql =========***
PROMPT ===================================================================================== 
