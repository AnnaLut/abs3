

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CLV_CORPS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CLV_CORPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CLV_CORPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CLV_CORPS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	NMKU VARCHAR2(4000), 
	RUK VARCHAR2(4000), 
	TELR VARCHAR2(4000), 
	BUH VARCHAR2(4000), 
	TELB VARCHAR2(4000), 
	TEL_FAX VARCHAR2(4000), 
	E_MAIL VARCHAR2(4000), 
	SEAL_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CLV_CORPS ***
 exec bpa.alter_policies('ERR$_CLV_CORPS');


COMMENT ON TABLE BARS.ERR$_CLV_CORPS IS 'DML Error Logging table for "CLV_CORPS"';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.NMKU IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.RUK IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.TELR IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.BUH IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.TELB IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.TEL_FAX IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.E_MAIL IS '';
COMMENT ON COLUMN BARS.ERR$_CLV_CORPS.SEAL_ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CLV_CORPS.sql =========*** End **
PROMPT ===================================================================================== 
