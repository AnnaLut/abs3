

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_LINES_CA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_LINES_CA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_LINES_CA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_LINES_CA 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FN VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	N VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	NB VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	VID VARCHAR2(4000), 
	NUM_TVO VARCHAR2(4000), 
	NAME_BLOK VARCHAR2(4000), 
	DAOS VARCHAR2(4000), 
	FIO_BLOK VARCHAR2(4000), 
	FIO_ISP VARCHAR2(4000), 
	INF_ISP VARCHAR2(4000), 
	ID_O VARCHAR2(4000), 
	SIGN RAW(2000), 
	ERR VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_LINES_CA ***
 exec bpa.alter_policies('ERR$_LINES_CA');


COMMENT ON TABLE BARS.ERR$_LINES_CA IS 'DML Error Logging table for "LINES_CA"';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.FN IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.N IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.NB IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.VID IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.NUM_TVO IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.NAME_BLOK IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.DAOS IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.FIO_BLOK IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.FIO_ISP IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.INF_ISP IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.ID_O IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.SIGN IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.ERR IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_CA.KF IS '';



PROMPT *** Create  grants  ERR$_LINES_CA ***
grant SELECT                                                                 on ERR$_LINES_CA   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_LINES_CA.sql =========*** End ***
PROMPT ===================================================================================== 
