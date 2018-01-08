

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_KL_F13_ZBSK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_KL_F13_ZBSK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_KL_F13_ZBSK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_KL_F13_ZBSK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NBSD VARCHAR2(4000), 
	NBSK VARCHAR2(4000), 
	SK_ZB VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_KL_F13_ZBSK ***
 exec bpa.alter_policies('ERR$_KL_F13_ZBSK');


COMMENT ON TABLE BARS.ERR$_KL_F13_ZBSK IS 'DML Error Logging table for "KL_F13_ZBSK"';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.NBSD IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.NBSK IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.SK_ZB IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.TT IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F13_ZBSK.KF IS '';



PROMPT *** Create  grants  ERR$_KL_F13_ZBSK ***
grant SELECT                                                                 on ERR$_KL_F13_ZBSK to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_KL_F13_ZBSK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_KL_F13_ZBSK.sql =========*** End 
PROMPT ===================================================================================== 
