

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_KL_F8B.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_KL_F8B ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_KL_F8B ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_KL_F8B 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DATF VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	NMK VARCHAR2(4000), 
	NNNN VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_KL_F8B ***
 exec bpa.alter_policies('ERR$_KL_F8B');


COMMENT ON TABLE BARS.ERR$_KL_F8B IS 'DML Error Logging table for "KL_F8B"';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.NMK IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.NNNN IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F8B.KF IS '';



PROMPT *** Create  grants  ERR$_KL_F8B ***
grant SELECT                                                                 on ERR$_KL_F8B     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_KL_F8B     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_KL_F8B.sql =========*** End *** =
PROMPT ===================================================================================== 
