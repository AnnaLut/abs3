

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAG_K.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAG_K ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAG_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAG_K 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	FN VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	N VARCHAR2(4000), 
	SDE VARCHAR2(4000), 
	SKR VARCHAR2(4000), 
	DATK VARCHAR2(4000), 
	DAT_2 VARCHAR2(4000), 
	K_ER VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	SIGN RAW(2000), 
	SIGN_KEY VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAG_K ***
 exec bpa.alter_policies('ERR$_ZAG_K');


COMMENT ON TABLE BARS.ERR$_ZAG_K IS 'DML Error Logging table for "ZAG_K"';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.REF IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.KV IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.FN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.N IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.SDE IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.SKR IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.DATK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.DAT_2 IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.K_ER IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.SIGN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.SIGN_KEY IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_K.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAG_K.sql =========*** End *** ==
PROMPT ===================================================================================== 
