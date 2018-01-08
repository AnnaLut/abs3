

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OPER_VISA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OPER_VISA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OPER_VISA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OPER_VISA 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	GROUPID VARCHAR2(4000), 
	STATUS VARCHAR2(4000), 
	SQNC VARCHAR2(4000), 
	PASSIVE VARCHAR2(4000), 
	KEYID VARCHAR2(4000), 
	SIGN RAW(2000), 
	USERNAME VARCHAR2(4000), 
	USERTABN VARCHAR2(4000), 
	GROUPNAME VARCHAR2(4000), 
	F_IN_CHARGE VARCHAR2(4000), 
	CHECK_TS VARCHAR2(4000), 
	CHECK_CODE VARCHAR2(4000), 
	CHECK_MSG VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	PASSIVE_REASONID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OPER_VISA ***
 exec bpa.alter_policies('ERR$_OPER_VISA');


COMMENT ON TABLE BARS.ERR$_OPER_VISA IS 'DML Error Logging table for "OPER_VISA"';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.GROUPID IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.SQNC IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.PASSIVE IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.KEYID IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.SIGN IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.USERNAME IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.USERTABN IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.GROUPNAME IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.F_IN_CHARGE IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.CHECK_TS IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.CHECK_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.CHECK_MSG IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.KF IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.PASSIVE_REASONID IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_VISA.REF IS '';



PROMPT *** Create  grants  ERR$_OPER_VISA ***
grant SELECT                                                                 on ERR$_OPER_VISA  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OPER_VISA  to BARS_DM;
grant SELECT                                                                 on ERR$_OPER_VISA  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OPER_VISA.sql =========*** End **
PROMPT ===================================================================================== 
