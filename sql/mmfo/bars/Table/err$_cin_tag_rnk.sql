

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIN_TAG_RNK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIN_TAG_RNK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIN_TAG_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIN_TAG_RNK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	PR_A1 VARCHAR2(4000), 
	SK_A1 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIN_TAG_RNK ***
 exec bpa.alter_policies('ERR$_CIN_TAG_RNK');


COMMENT ON TABLE BARS.ERR$_CIN_TAG_RNK IS 'DML Error Logging table for "CIN_TAG_RNK"';
COMMENT ON COLUMN BARS.ERR$_CIN_TAG_RNK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TAG_RNK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TAG_RNK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TAG_RNK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TAG_RNK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TAG_RNK.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TAG_RNK.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TAG_RNK.PR_A1 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TAG_RNK.SK_A1 IS '';



PROMPT *** Create  grants  ERR$_CIN_TAG_RNK ***
grant SELECT                                                                 on ERR$_CIN_TAG_RNK to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIN_TAG_RNK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIN_TAG_RNK.sql =========*** End 
PROMPT ===================================================================================== 
