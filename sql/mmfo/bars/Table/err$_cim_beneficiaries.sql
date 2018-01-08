

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_BENEFICIARIES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_BENEFICIARIES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_BENEFICIARIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_BENEFICIARIES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BENEF_ID VARCHAR2(4000), 
	BENEF_NAME VARCHAR2(4000), 
	COUNTRY_ID VARCHAR2(4000), 
	BENEF_ADR VARCHAR2(4000), 
	COMMENTS VARCHAR2(4000), 
	DELETE_DATE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_BENEFICIARIES ***
 exec bpa.alter_policies('ERR$_CIM_BENEFICIARIES');


COMMENT ON TABLE BARS.ERR$_CIM_BENEFICIARIES IS 'DML Error Logging table for "CIM_BENEFICIARIES"';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.BENEF_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.BENEF_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.COUNTRY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.BENEF_ADR IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.COMMENTS IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BENEFICIARIES.DELETE_DATE IS '';



PROMPT *** Create  grants  ERR$_CIM_BENEFICIARIES ***
grant SELECT                                                                 on ERR$_CIM_BENEFICIARIES to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIM_BENEFICIARIES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_BENEFICIARIES.sql =========**
PROMPT ===================================================================================== 
