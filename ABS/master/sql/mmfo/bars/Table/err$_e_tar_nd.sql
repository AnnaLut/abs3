

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_E_TAR_ND.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_E_TAR_ND ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_E_TAR_ND ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_E_TAR_ND 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	DAT_BEG VARCHAR2(4000), 
	DAT_END VARCHAR2(4000), 
	DAT_OPL VARCHAR2(4000), 
	SUMT VARCHAR2(4000), 
	SUMT1 VARCHAR2(4000), 
	DAT_LB VARCHAR2(4000), 
	DAT_LE VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	S_PROGN VARCHAR2(4000), 
	DAT_PROGN VARCHAR2(4000), 
	S_POROG VARCHAR2(4000), 
	S_TAR_POR1 VARCHAR2(4000), 
	S_TAR_POR2 VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_E_TAR_ND ***
 exec bpa.alter_policies('ERR$_E_TAR_ND');


COMMENT ON TABLE BARS.ERR$_E_TAR_ND IS 'DML Error Logging table for "E_TAR_ND"';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.ND IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.ID IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.DAT_BEG IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.DAT_END IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.DAT_OPL IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.SUMT IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.SUMT1 IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.DAT_LB IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.DAT_LE IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.KF IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.S_PROGN IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.DAT_PROGN IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.S_POROG IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.S_TAR_POR1 IS '';
COMMENT ON COLUMN BARS.ERR$_E_TAR_ND.S_TAR_POR2 IS '';



PROMPT *** Create  grants  ERR$_E_TAR_ND ***
grant SELECT                                                                 on ERR$_E_TAR_ND   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_E_TAR_ND   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_E_TAR_ND.sql =========*** End ***
PROMPT ===================================================================================== 
