

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMER_RISK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CUSTOMER_RISK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CUSTOMER_RISK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CUSTOMER_RISK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	RISK_ID VARCHAR2(4000), 
	DAT_BEGIN VARCHAR2(4000), 
	DAT_END VARCHAR2(4000), 
	USER_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CUSTOMER_RISK ***
 exec bpa.alter_policies('ERR$_CUSTOMER_RISK');


COMMENT ON TABLE BARS.ERR$_CUSTOMER_RISK IS 'DML Error Logging table for "CUSTOMER_RISK"';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RISK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RISK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RISK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RISK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RISK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RISK.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RISK.RISK_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RISK.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RISK.DAT_END IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RISK.USER_ID IS '';



PROMPT *** Create  grants  ERR$_CUSTOMER_RISK ***
grant SELECT                                                                 on ERR$_CUSTOMER_RISK to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMER_RISK.sql =========*** En
PROMPT ===================================================================================== 
