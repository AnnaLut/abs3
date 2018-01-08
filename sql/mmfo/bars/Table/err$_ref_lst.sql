

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_REF_LST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_REF_LST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_REF_LST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_REF_LST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DATD VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	MFOA VARCHAR2(4000), 
	NLSA VARCHAR2(4000), 
	MFOB VARCHAR2(4000), 
	NLSB VARCHAR2(4000), 
	S VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	REC VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_REF_LST ***
 exec bpa.alter_policies('ERR$_REF_LST');


COMMENT ON TABLE BARS.ERR$_REF_LST IS 'DML Error Logging table for "REF_LST"';
COMMENT ON COLUMN BARS.ERR$_REF_LST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.DATD IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.ND IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.MFOA IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.NLSA IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.MFOB IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.NLSB IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.S IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.REF IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.REC IS '';
COMMENT ON COLUMN BARS.ERR$_REF_LST.KF IS '';



PROMPT *** Create  grants  ERR$_REF_LST ***
grant SELECT                                                                 on ERR$_REF_LST    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_REF_LST    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_REF_LST.sql =========*** End *** 
PROMPT ===================================================================================== 
