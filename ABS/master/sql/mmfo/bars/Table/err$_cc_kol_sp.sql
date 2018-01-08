

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_KOL_SP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_KOL_SP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_KOL_SP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_KOL_SP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	SP VARCHAR2(4000), 
	SPN VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	SPO VARCHAR2(4000), 
	ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_KOL_SP ***
 exec bpa.alter_policies('ERR$_CC_KOL_SP');


COMMENT ON TABLE BARS.ERR$_CC_KOL_SP IS 'DML Error Logging table for "CC_KOL_SP"';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.SP IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.SPN IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.SPO IS '';
COMMENT ON COLUMN BARS.ERR$_CC_KOL_SP.ID IS '';



PROMPT *** Create  grants  ERR$_CC_KOL_SP ***
grant SELECT                                                                 on ERR$_CC_KOL_SP  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CC_KOL_SP  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_KOL_SP.sql =========*** End **
PROMPT ===================================================================================== 
