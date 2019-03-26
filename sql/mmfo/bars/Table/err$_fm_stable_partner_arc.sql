

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FM_STABLE_PARTNER_ARC.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FM_STABLE_PARTNER_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FM_STABLE_PARTNER_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FM_STABLE_PARTNER_ARC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DAT VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	PARTNER_LIST VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FM_STABLE_PARTNER_ARC ***
 exec bpa.alter_policies('ERR$_FM_STABLE_PARTNER_ARC');


COMMENT ON TABLE BARS.ERR$_FM_STABLE_PARTNER_ARC IS 'DML Error Logging table for "FM_STABLE_PARTNER_ARC"';
COMMENT ON COLUMN BARS.ERR$_FM_STABLE_PARTNER_ARC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FM_STABLE_PARTNER_ARC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FM_STABLE_PARTNER_ARC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FM_STABLE_PARTNER_ARC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FM_STABLE_PARTNER_ARC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FM_STABLE_PARTNER_ARC.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_FM_STABLE_PARTNER_ARC.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_FM_STABLE_PARTNER_ARC.PARTNER_LIST IS '';
COMMENT ON COLUMN BARS.ERR$_FM_STABLE_PARTNER_ARC.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FM_STABLE_PARTNER_ARC.sql =======
PROMPT ===================================================================================== 