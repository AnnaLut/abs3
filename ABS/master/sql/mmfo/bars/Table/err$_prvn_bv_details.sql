

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PRVN_BV_DETAILS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PRVN_BV_DETAILS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PRVN_BV_DETAILS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PRVN_BV_DETAILS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	MDAT VARCHAR2(4000), 
	CDAT VARCHAR2(4000), 
	SS VARCHAR2(4000), 
	SP VARCHAR2(4000), 
	SN VARCHAR2(4000), 
	SPI VARCHAR2(4000), 
	SPN VARCHAR2(4000), 
	SDI VARCHAR2(4000), 
	SNO VARCHAR2(4000), 
	SNA VARCHAR2(4000), 
	REZ VARCHAR2(4000), 
	BV VARCHAR2(4000), 
	IR VARCHAR2(4000), 
	EPS1 VARCHAR2(4000), 
	NR VARCHAR2(4000), 
	NOM1 VARCHAR2(4000), 
	AR VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	VIDD VARCHAR2(4000), 
	SE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PRVN_BV_DETAILS ***
 exec bpa.alter_policies('ERR$_PRVN_BV_DETAILS');


COMMENT ON TABLE BARS.ERR$_PRVN_BV_DETAILS IS 'DML Error Logging table for "PRVN_BV_DETAILS"';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.ND IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.MDAT IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.CDAT IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.SS IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.SP IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.SN IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.SPI IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.SPN IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.SDI IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.SNO IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.SNA IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.REZ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.BV IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.IR IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.EPS1 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.NR IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.NOM1 IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.AR IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.KV IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.VIDD IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.SE IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_BV_DETAILS.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PRVN_BV_DETAILS.sql =========*** 
PROMPT ===================================================================================== 
