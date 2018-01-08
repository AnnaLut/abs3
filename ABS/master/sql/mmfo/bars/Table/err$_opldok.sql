

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OPLDOK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OPLDOK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OPLDOK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OPLDOK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	DK VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	S VARCHAR2(4000), 
	SQ VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	STMT VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	ID VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OPLDOK ***
 exec bpa.alter_policies('ERR$_OPLDOK');


COMMENT ON TABLE BARS.ERR$_OPLDOK IS 'DML Error Logging table for "OPLDOK"';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.REF IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.TT IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.DK IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.S IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.SQ IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.STMT IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.KF IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_OPLDOK.ID IS '';



PROMPT *** Create  grants  ERR$_OPLDOK ***
grant SELECT                                                                 on ERR$_OPLDOK     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OPLDOK     to BARS_DM;
grant SELECT                                                                 on ERR$_OPLDOK     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OPLDOK.sql =========*** End *** =
PROMPT ===================================================================================== 
