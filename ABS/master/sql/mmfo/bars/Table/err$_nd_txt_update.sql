

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ND_TXT_UPDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ND_TXT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ND_TXT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ND_TXT_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	IDUPD VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000), 
	GLOBAL_BDATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ND_TXT_UPDATE ***
 exec bpa.alter_policies('ERR$_ND_TXT_UPDATE');


COMMENT ON TABLE BARS.ERR$_ND_TXT_UPDATE IS 'DML Error Logging table for "ND_TXT_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT_UPDATE.GLOBAL_BDATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ND_TXT_UPDATE.sql =========*** En
PROMPT ===================================================================================== 
