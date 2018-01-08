

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_RNK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FIN_RNK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FIN_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FIN_RNK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	IDF VARCHAR2(4000), 
	KOD VARCHAR2(4000), 
	S VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	SS VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FIN_RNK ***
 exec bpa.alter_policies('ERR$_FIN_RNK');


COMMENT ON TABLE BARS.ERR$_FIN_RNK IS 'DML Error Logging table for "FIN_RNK"';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.IDF IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.S IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_RNK.SS IS '';



PROMPT *** Create  grants  ERR$_FIN_RNK ***
grant SELECT                                                                 on ERR$_FIN_RNK    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_FIN_RNK    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_RNK.sql =========*** End *** 
PROMPT ===================================================================================== 
