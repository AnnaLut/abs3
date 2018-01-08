

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_TRUSTEE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_TRUSTEE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_TRUSTEE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_TRUSTEE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	DPT_ID VARCHAR2(4000), 
	TYP_TR VARCHAR2(4000), 
	RNK_TR VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	ADD_NUM VARCHAR2(4000), 
	ADD_DAT VARCHAR2(4000), 
	FL_ACT VARCHAR2(4000), 
	UNDO_ID VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_TRUSTEE ***
 exec bpa.alter_policies('ERR$_DPT_TRUSTEE');


COMMENT ON TABLE BARS.ERR$_DPT_TRUSTEE IS 'DML Error Logging table for "DPT_TRUSTEE"';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.DPT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.TYP_TR IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.RNK_TR IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.ADD_NUM IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.ADD_DAT IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.FL_ACT IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.UNDO_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_TRUSTEE.BRANCH IS '';



PROMPT *** Create  grants  ERR$_DPT_TRUSTEE ***
grant SELECT                                                                 on ERR$_DPT_TRUSTEE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_TRUSTEE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_TRUSTEE.sql =========*** End 
PROMPT ===================================================================================== 
