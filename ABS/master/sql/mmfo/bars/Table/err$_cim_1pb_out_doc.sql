

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_1PB_OUT_DOC.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_1PB_OUT_DOC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_1PB_OUT_DOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_1PB_OUT_DOC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF_CA VARCHAR2(4000), 
	VDAT VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	S VARCHAR2(4000), 
	MFOA VARCHAR2(4000), 
	MFOB VARCHAR2(4000), 
	NLSA VARCHAR2(4000), 
	NLSB VARCHAR2(4000), 
	KOD_N_CA VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_1PB_OUT_DOC ***
 exec bpa.alter_policies('ERR$_CIM_1PB_OUT_DOC');


COMMENT ON TABLE BARS.ERR$_CIM_1PB_OUT_DOC IS 'DML Error Logging table for "CIM_1PB_OUT_DOC"';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.REF_CA IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.VDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.S IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.MFOA IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.MFOB IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.NLSA IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.NLSB IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_1PB_OUT_DOC.KOD_N_CA IS '';



PROMPT *** Create  grants  ERR$_CIM_1PB_OUT_DOC ***
grant SELECT                                                                 on ERR$_CIM_1PB_OUT_DOC to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIM_1PB_OUT_DOC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_1PB_OUT_DOC.sql =========*** 
PROMPT ===================================================================================== 
