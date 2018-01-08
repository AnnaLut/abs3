

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_F13_ZBSK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTCN_F13_ZBSK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTCN_F13_ZBSK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTCN_F13_ZBSK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	ACCD VARCHAR2(4000), 
	NLSD VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	ACCK VARCHAR2(4000), 
	NLSK VARCHAR2(4000), 
	S VARCHAR2(4000), 
	SQ VARCHAR2(4000), 
	NAZN VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	SK_ZB VARCHAR2(4000), 
	RECID VARCHAR2(4000), 
	KO VARCHAR2(4000), 
	TOBO VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTCN_F13_ZBSK ***
 exec bpa.alter_policies('ERR$_OTCN_F13_ZBSK');


COMMENT ON TABLE BARS.ERR$_OTCN_F13_ZBSK IS 'DML Error Logging table for "OTCN_F13_ZBSK"';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.REF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.TT IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.ACCD IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.NLSD IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.KV IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.ACCK IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.NLSK IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.S IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.SQ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.NAZN IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.SK_ZB IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.RECID IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.KO IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.TOBO IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F13_ZBSK.KF IS '';



PROMPT *** Create  grants  ERR$_OTCN_F13_ZBSK ***
grant SELECT                                                                 on ERR$_OTCN_F13_ZBSK to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OTCN_F13_ZBSK to BARS_DM;
grant SELECT                                                                 on ERR$_OTCN_F13_ZBSK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_F13_ZBSK.sql =========*** En
PROMPT ===================================================================================== 
