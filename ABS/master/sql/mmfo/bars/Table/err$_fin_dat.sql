

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_DAT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FIN_DAT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FIN_DAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FIN_DAT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	FDAT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FIN_DAT ***
 exec bpa.alter_policies('ERR$_FIN_DAT');


COMMENT ON TABLE BARS.ERR$_FIN_DAT IS 'DML Error Logging table for "FIN_DAT"';
COMMENT ON COLUMN BARS.ERR$_FIN_DAT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_DAT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_DAT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_DAT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_DAT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_DAT.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_DAT.ND IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_DAT.FDAT IS '';



PROMPT *** Create  grants  ERR$_FIN_DAT ***
grant SELECT                                                                 on ERR$_FIN_DAT    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_FIN_DAT    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_DAT.sql =========*** End *** 
PROMPT ===================================================================================== 
