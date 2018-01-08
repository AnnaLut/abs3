

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_RNK_ND_PORT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_RNK_ND_PORT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_RNK_ND_PORT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_RNK_ND_PORT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TIP VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	S250 VARCHAR2(4000), 
	GRP VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_RNK_ND_PORT ***
 exec bpa.alter_policies('ERR$_RNK_ND_PORT');


COMMENT ON TABLE BARS.ERR$_RNK_ND_PORT IS 'DML Error Logging table for "RNK_ND_PORT"';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.TIP IS '';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.ND IS '';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.S250 IS '';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.GRP IS '';
COMMENT ON COLUMN BARS.ERR$_RNK_ND_PORT.KF IS '';



PROMPT *** Create  grants  ERR$_RNK_ND_PORT ***
grant SELECT                                                                 on ERR$_RNK_ND_PORT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_RNK_ND_PORT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_RNK_ND_PORT.sql =========*** End 
PROMPT ===================================================================================== 
