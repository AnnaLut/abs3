

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PRVN_OSAQ.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PRVN_OSAQ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PRVN_OSAQ ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PRVN_OSAQ 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	TIP VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	REZB VARCHAR2(4000), 
	REZ9 VARCHAR2(4000), 
	ID_PROV_TYPE VARCHAR2(4000), 
	IS_DEFAULT VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	FV_ABS VARCHAR2(4000), 
	REZB_R VARCHAR2(4000), 
	REZ9_R VARCHAR2(4000), 
	AIRC_CCY VARCHAR2(4000), 
	VIDD VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PRVN_OSAQ ***
 exec bpa.alter_policies('ERR$_PRVN_OSAQ');


COMMENT ON TABLE BARS.ERR$_PRVN_OSAQ IS 'DML Error Logging table for "PRVN_OSAQ"';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.TIP IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.ND IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.REZB IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.REZ9 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.ID_PROV_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.IS_DEFAULT IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.FV_ABS IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.REZB_R IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.REZ9_R IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.AIRC_CCY IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.VIDD IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.KV IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_OSAQ.KF IS '';



PROMPT *** Create  grants  ERR$_PRVN_OSAQ ***
grant SELECT                                                                 on ERR$_PRVN_OSAQ  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_PRVN_OSAQ  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PRVN_OSAQ.sql =========*** End **
PROMPT ===================================================================================== 
