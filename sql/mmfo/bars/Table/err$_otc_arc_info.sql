

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTC_ARC_INFO.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTC_ARC_INFO ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTC_ARC_INFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTC_ARC_INFO 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NPP VARCHAR2(4000), 
	DAT_OTC VARCHAR2(4000), 
	DAT_SYS VARCHAR2(4000), 
	DAT_BANK VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTC_ARC_INFO ***
 exec bpa.alter_policies('ERR$_OTC_ARC_INFO');


COMMENT ON TABLE BARS.ERR$_OTC_ARC_INFO IS 'DML Error Logging table for "OTC_ARC_INFO"';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.NPP IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.DAT_OTC IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.DAT_SYS IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.DAT_BANK IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_INFO.KF IS '';



PROMPT *** Create  grants  ERR$_OTC_ARC_INFO ***
grant SELECT                                                                 on ERR$_OTC_ARC_INFO to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OTC_ARC_INFO to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTC_ARC_INFO.sql =========*** End
PROMPT ===================================================================================== 
