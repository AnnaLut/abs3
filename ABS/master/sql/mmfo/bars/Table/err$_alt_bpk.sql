

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ALT_BPK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ALT_BPK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ALT_BPK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ALT_BPK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NLSA VARCHAR2(4000), 
	S VARCHAR2(4000), 
	FIO VARCHAR2(4000), 
	NAZN VARCHAR2(4000), 
	NLSB VARCHAR2(4000), 
	SK_ZB VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	ERROR VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ALT_BPK ***
 exec bpa.alter_policies('ERR$_ALT_BPK');


COMMENT ON TABLE BARS.ERR$_ALT_BPK IS 'DML Error Logging table for "ALT_BPK"';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.NLSB IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.SK_ZB IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.REF IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.ERROR IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.KF IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.NLSA IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.S IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.FIO IS '';
COMMENT ON COLUMN BARS.ERR$_ALT_BPK.NAZN IS '';



PROMPT *** Create  grants  ERR$_ALT_BPK ***
grant SELECT                                                                 on ERR$_ALT_BPK    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ALT_BPK    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ALT_BPK.sql =========*** End *** 
PROMPT ===================================================================================== 
