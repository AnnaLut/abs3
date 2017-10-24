

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_APP_REP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_APP_REP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_APP_REP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_APP_REP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CODEAPP VARCHAR2(4000), 
	CODEREP VARCHAR2(4000), 
	APPROVE VARCHAR2(4000), 
	ADATE1 VARCHAR2(4000), 
	ADATE2 VARCHAR2(4000), 
	RDATE1 VARCHAR2(4000), 
	RDATE2 VARCHAR2(4000), 
	REVERSE VARCHAR2(4000), 
	REVOKED VARCHAR2(4000), 
	GRANTOR VARCHAR2(4000), 
	ACODE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_APP_REP ***
 exec bpa.alter_policies('ERR$_APP_REP');


COMMENT ON TABLE BARS.ERR$_APP_REP IS 'DML Error Logging table for "APP_REP"';
COMMENT ON COLUMN BARS.ERR$_APP_REP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.CODEAPP IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.CODEREP IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.APPROVE IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.ADATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.ADATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.RDATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.RDATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.REVERSE IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.REVOKED IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.GRANTOR IS '';
COMMENT ON COLUMN BARS.ERR$_APP_REP.ACODE IS '';



PROMPT *** Create  grants  ERR$_APP_REP ***
grant SELECT                                                                 on ERR$_APP_REP    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_APP_REP.sql =========*** End *** 
PROMPT ===================================================================================== 
