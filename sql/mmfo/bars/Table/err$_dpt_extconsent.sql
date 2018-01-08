

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_EXTCONSENT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_EXTCONSENT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_EXTCONSENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_EXTCONSENT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DPT_ID VARCHAR2(4000), 
	DAT_BEGIN VARCHAR2(4000), 
	DAT_END VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_EXTCONSENT ***
 exec bpa.alter_policies('ERR$_DPT_EXTCONSENT');


COMMENT ON TABLE BARS.ERR$_DPT_EXTCONSENT IS 'DML Error Logging table for "DPT_EXTCONSENT"';
COMMENT ON COLUMN BARS.ERR$_DPT_EXTCONSENT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_EXTCONSENT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_EXTCONSENT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_EXTCONSENT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_EXTCONSENT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_EXTCONSENT.DPT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_EXTCONSENT.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_EXTCONSENT.DAT_END IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_EXTCONSENT.KF IS '';



PROMPT *** Create  grants  ERR$_DPT_EXTCONSENT ***
grant SELECT                                                                 on ERR$_DPT_EXTCONSENT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_EXTCONSENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_EXTCONSENT.sql =========*** E
PROMPT ===================================================================================== 
