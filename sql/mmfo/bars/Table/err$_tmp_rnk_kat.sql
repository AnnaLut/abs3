

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_RNK_KAT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TMP_RNK_KAT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TMP_RNK_KAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TMP_RNK_KAT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	KAT VARCHAR2(4000), 
	ISTVAL VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TMP_RNK_KAT ***
 exec bpa.alter_policies('ERR$_TMP_RNK_KAT');


COMMENT ON TABLE BARS.ERR$_TMP_RNK_KAT IS 'DML Error Logging table for "TMP_RNK_KAT"';
COMMENT ON COLUMN BARS.ERR$_TMP_RNK_KAT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_RNK_KAT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_RNK_KAT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_RNK_KAT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_RNK_KAT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_RNK_KAT.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_RNK_KAT.KAT IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_RNK_KAT.ISTVAL IS '';



PROMPT *** Create  grants  ERR$_TMP_RNK_KAT ***
grant SELECT                                                                 on ERR$_TMP_RNK_KAT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_TMP_RNK_KAT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_RNK_KAT.sql =========*** End 
PROMPT ===================================================================================== 
