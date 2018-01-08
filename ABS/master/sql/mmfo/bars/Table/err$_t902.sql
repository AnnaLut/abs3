

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_T902.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_T902 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_T902 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_T902 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	REC VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	REC_O VARCHAR2(4000), 
	S VARCHAR2(4000), 
	STMP VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	BLK VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_T902 ***
 exec bpa.alter_policies('ERR$_T902');


COMMENT ON TABLE BARS.ERR$_T902 IS 'DML Error Logging table for "T902"';
COMMENT ON COLUMN BARS.ERR$_T902.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_T902.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_T902.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_T902.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_T902.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_T902.REF IS '';
COMMENT ON COLUMN BARS.ERR$_T902.REC IS '';
COMMENT ON COLUMN BARS.ERR$_T902.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_T902.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_T902.REC_O IS '';
COMMENT ON COLUMN BARS.ERR$_T902.S IS '';
COMMENT ON COLUMN BARS.ERR$_T902.STMP IS '';
COMMENT ON COLUMN BARS.ERR$_T902.KF IS '';
COMMENT ON COLUMN BARS.ERR$_T902.BLK IS '';



PROMPT *** Create  grants  ERR$_T902 ***
grant SELECT                                                                 on ERR$_T902       to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_T902       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_T902.sql =========*** End *** ===
PROMPT ===================================================================================== 
