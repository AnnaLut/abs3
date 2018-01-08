

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OW_COMIS_MASK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OW_COMIS_MASK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OW_COMIS_MASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OW_COMIS_MASK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SYNTHCODE VARCHAR2(4000), 
	NLS_MASK VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OW_COMIS_MASK ***
 exec bpa.alter_policies('ERR$_OW_COMIS_MASK');


COMMENT ON TABLE BARS.ERR$_OW_COMIS_MASK IS 'DML Error Logging table for "OW_COMIS_MASK"';
COMMENT ON COLUMN BARS.ERR$_OW_COMIS_MASK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_COMIS_MASK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_COMIS_MASK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_COMIS_MASK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_COMIS_MASK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_COMIS_MASK.SYNTHCODE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_COMIS_MASK.NLS_MASK IS '';
COMMENT ON COLUMN BARS.ERR$_OW_COMIS_MASK.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_OW_COMIS_MASK.KF IS '';



PROMPT *** Create  grants  ERR$_OW_COMIS_MASK ***
grant SELECT                                                                 on ERR$_OW_COMIS_MASK to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OW_COMIS_MASK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OW_COMIS_MASK.sql =========*** En
PROMPT ===================================================================================== 
