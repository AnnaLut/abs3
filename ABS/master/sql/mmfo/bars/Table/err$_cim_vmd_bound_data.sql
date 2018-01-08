

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_VMD_BOUND_DATA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_VMD_BOUND_DATA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_VMD_BOUND_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_VMD_BOUND_DATA 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BOUND_ID VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	BENEF_ID VARCHAR2(4000), 
	C_NUM VARCHAR2(4000), 
	C_DATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_VMD_BOUND_DATA ***
 exec bpa.alter_policies('ERR$_CIM_VMD_BOUND_DATA');


COMMENT ON TABLE BARS.ERR$_CIM_VMD_BOUND_DATA IS 'DML Error Logging table for "CIM_VMD_BOUND_DATA"';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND_DATA.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND_DATA.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND_DATA.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND_DATA.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND_DATA.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND_DATA.BOUND_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND_DATA.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND_DATA.BENEF_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND_DATA.C_NUM IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND_DATA.C_DATE IS '';



PROMPT *** Create  grants  ERR$_CIM_VMD_BOUND_DATA ***
grant SELECT                                                                 on ERR$_CIM_VMD_BOUND_DATA to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIM_VMD_BOUND_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_VMD_BOUND_DATA.sql =========*
PROMPT ===================================================================================== 
