

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_REQ_CHGINTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_REQ_CHGINTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_REQ_CHGINTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_REQ_CHGINTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REQ_ID VARCHAR2(4000), 
	REQC_TYPE VARCHAR2(4000), 
	REQC_BEGDATE VARCHAR2(4000), 
	REQC_EXPDATE VARCHAR2(4000), 
	REQC_OLDINT VARCHAR2(4000), 
	REQC_NEWINT VARCHAR2(4000), 
	REQC_NEWBR VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_DPT_REQ_CHGINTS ***
 exec bpa.alter_policies('ERR$_DPT_REQ_CHGINTS');


COMMENT ON TABLE BARS.ERR$_DPT_REQ_CHGINTS IS 'DML Error Logging table for "DPT_REQ_CHGINTS"';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.REQ_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.REQC_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.REQC_BEGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.REQC_EXPDATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.REQC_OLDINT IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.REQC_NEWINT IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.REQC_NEWBR IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.KF IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQ_CHGINTS.BRANCH IS '';



PROMPT *** Create  grants  ERR$_DPT_REQ_CHGINTS ***
grant SELECT                                                                 on ERR$_DPT_REQ_CHGINTS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_REQ_CHGINTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_REQ_CHGINTS.sql =========*** 
PROMPT ===================================================================================== 
