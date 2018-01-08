

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DEB_HOZ.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DEB_HOZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DEB_HOZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DEB_HOZ 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NBS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	KAT VARCHAR2(4000), 
	BV VARCHAR2(4000), 
	BVQ VARCHAR2(4000), 
	REZ VARCHAR2(4000), 
	REZQ VARCHAR2(4000), 
	REZF VARCHAR2(4000), 
	REZQF VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DEB_HOZ ***
 exec bpa.alter_policies('ERR$_DEB_HOZ');


COMMENT ON TABLE BARS.ERR$_DEB_HOZ IS 'DML Error Logging table for "DEB_HOZ"';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.KV IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.KAT IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.BV IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.BVQ IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.REZ IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.REZQ IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.REZF IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.REZQF IS '';
COMMENT ON COLUMN BARS.ERR$_DEB_HOZ.KF IS '';



PROMPT *** Create  grants  ERR$_DEB_HOZ ***
grant SELECT                                                                 on ERR$_DEB_HOZ    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DEB_HOZ    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DEB_HOZ.sql =========*** End *** 
PROMPT ===================================================================================== 
