

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OPERLIST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OPERLIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OPERLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OPERLIST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CODEOPER VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	DLGNAME VARCHAR2(4000), 
	FUNCNAME VARCHAR2(4000), 
	SEMANTIC VARCHAR2(4000), 
	RUNABLE VARCHAR2(4000), 
	PARENTID VARCHAR2(4000), 
	ROLENAME VARCHAR2(4000), 
	FRONTEND VARCHAR2(4000), 
	USEARC VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OPERLIST ***
 exec bpa.alter_policies('ERR$_OPERLIST');


COMMENT ON TABLE BARS.ERR$_OPERLIST IS 'DML Error Logging table for "OPERLIST"';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.CODEOPER IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.DLGNAME IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.FUNCNAME IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.SEMANTIC IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.RUNABLE IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.PARENTID IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.ROLENAME IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.FRONTEND IS '';
COMMENT ON COLUMN BARS.ERR$_OPERLIST.USEARC IS '';



PROMPT *** Create  grants  ERR$_OPERLIST ***
grant SELECT                                                                 on ERR$_OPERLIST   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OPERLIST   to BARS_DM;
grant SELECT                                                                 on ERR$_OPERLIST   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OPERLIST.sql =========*** End ***
PROMPT ===================================================================================== 
