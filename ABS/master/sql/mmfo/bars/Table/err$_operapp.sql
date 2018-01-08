

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OPERAPP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OPERAPP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OPERAPP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OPERAPP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CODEAPP VARCHAR2(4000), 
	CODEOPER VARCHAR2(4000), 
	HOTKEY VARCHAR2(4000), 
	APPROVE VARCHAR2(4000), 
	ADATE1 VARCHAR2(4000), 
	ADATE2 VARCHAR2(4000), 
	RDATE1 VARCHAR2(4000), 
	RDATE2 VARCHAR2(4000), 
	REVERSE VARCHAR2(4000), 
	REVOKED VARCHAR2(4000), 
	GRANTOR VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OPERAPP ***
 exec bpa.alter_policies('ERR$_OPERAPP');


COMMENT ON TABLE BARS.ERR$_OPERAPP IS 'DML Error Logging table for "OPERAPP"';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.CODEAPP IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.CODEOPER IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.HOTKEY IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.APPROVE IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.ADATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.ADATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.RDATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.RDATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.REVERSE IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.REVOKED IS '';
COMMENT ON COLUMN BARS.ERR$_OPERAPP.GRANTOR IS '';



PROMPT *** Create  grants  ERR$_OPERAPP ***
grant SELECT                                                                 on ERR$_OPERAPP    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OPERAPP    to BARS_DM;
grant SELECT                                                                 on ERR$_OPERAPP    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OPERAPP.sql =========*** End *** 
PROMPT ===================================================================================== 
