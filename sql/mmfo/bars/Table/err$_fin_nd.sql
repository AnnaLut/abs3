

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_ND.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FIN_ND ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FIN_ND ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FIN_ND 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	IDF VARCHAR2(4000), 
	KOD VARCHAR2(4000), 
	S VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	VAL_DATE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FIN_ND ***
 exec bpa.alter_policies('ERR$_FIN_ND');


COMMENT ON TABLE BARS.ERR$_FIN_ND IS 'DML Error Logging table for "FIN_ND"';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.IDF IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.S IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.ND IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.VAL_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.KF IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND.ORA_ERR_TAG$ IS '';



PROMPT *** Create  grants  ERR$_FIN_ND ***
grant SELECT                                                                 on ERR$_FIN_ND     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_FIN_ND     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_ND.sql =========*** End *** =
PROMPT ===================================================================================== 
