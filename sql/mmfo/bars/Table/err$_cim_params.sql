

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_PARAMS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_PARAMS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	PAR_NAME VARCHAR2(4000), 
	PAR_VALUE VARCHAR2(4000), 
	PAR_COMMENT VARCHAR2(4000), 
	GLOBAL VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_PARAMS ***
 exec bpa.alter_policies('ERR$_CIM_PARAMS');


COMMENT ON TABLE BARS.ERR$_CIM_PARAMS IS 'DML Error Logging table for "CIM_PARAMS"';
COMMENT ON COLUMN BARS.ERR$_CIM_PARAMS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_PARAMS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_PARAMS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_PARAMS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_PARAMS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_PARAMS.PAR_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_PARAMS.PAR_VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_PARAMS.PAR_COMMENT IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_PARAMS.GLOBAL IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_PARAMS.KF IS '';



PROMPT *** Create  grants  ERR$_CIM_PARAMS ***
grant SELECT                                                                 on ERR$_CIM_PARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIM_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_PARAMS.sql =========*** End *
PROMPT ===================================================================================== 
