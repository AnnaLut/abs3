

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_APE_LINK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_APE_LINK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_APE_LINK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_APE_LINK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	PAYMENT_ID VARCHAR2(4000), 
	FANTOM_ID VARCHAR2(4000), 
	SERVICE_CODE VARCHAR2(4000), 
	APE_ID VARCHAR2(4000), 
	S VARCHAR2(4000), 
	DELETE_DATE VARCHAR2(4000), 
	DELETE_UID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_APE_LINK ***
 exec bpa.alter_policies('ERR$_CIM_APE_LINK');


COMMENT ON TABLE BARS.ERR$_CIM_APE_LINK IS 'DML Error Logging table for "CIM_APE_LINK"';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.PAYMENT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.FANTOM_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.SERVICE_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.APE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.S IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.DELETE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_APE_LINK.DELETE_UID IS '';



PROMPT *** Create  grants  ERR$_CIM_APE_LINK ***
grant SELECT                                                                 on ERR$_CIM_APE_LINK to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIM_APE_LINK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_APE_LINK.sql =========*** End
PROMPT ===================================================================================== 
