

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_NLK_REF_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_NLK_REF_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_NLK_REF_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_NLK_REF_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF1 VARCHAR2(4000), 
	REF2 VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	REF2_STATE VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	IDUPD VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_NLK_REF_UPDATE ***
 exec bpa.alter_policies('ERR$_NLK_REF_UPDATE');


COMMENT ON TABLE BARS.ERR$_NLK_REF_UPDATE IS 'DML Error Logging table for "NLK_REF_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.REF1 IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.REF2 IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.REF2_STATE IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_NLK_REF_UPDATE.IDUPD IS '';



PROMPT *** Create  grants  ERR$_NLK_REF_UPDATE ***
grant SELECT                                                                 on ERR$_NLK_REF_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_NLK_REF_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_NLK_REF_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
