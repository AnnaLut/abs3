

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_KL_POV_A.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_KL_POV_A ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_KL_POV_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_KL_POV_A 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KB VARCHAR2(4000), 
	RN_POV_A VARCHAR2(4000), 
	ADR_POV_A VARCHAR2(4000), 
	OKPO_A VARCHAR2(4000), 
	NAM_A VARCHAR2(4000), 
	ADR_A VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	KO VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_KL_POV_A ***
 exec bpa.alter_policies('ERR$_KL_POV_A');


COMMENT ON TABLE BARS.ERR$_KL_POV_A IS 'DML Error Logging table for "KL_POV_A"';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.KB IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.RN_POV_A IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.ADR_POV_A IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.OKPO_A IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.NAM_A IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.ADR_A IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.KV IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.KO IS '';
COMMENT ON COLUMN BARS.ERR$_KL_POV_A.KF IS '';



PROMPT *** Create  grants  ERR$_KL_POV_A ***
grant SELECT                                                                 on ERR$_KL_POV_A   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_KL_POV_A   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_KL_POV_A.sql =========*** End ***
PROMPT ===================================================================================== 
