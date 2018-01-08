

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIG_CUSTOMERS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIG_CUSTOMERS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIG_CUSTOMERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIG_CUSTOMERS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CUST_ID VARCHAR2(4000), 
	CUST_TYPE VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	UPD_DATE VARCHAR2(4000), 
	SYNC_DATE VARCHAR2(4000), 
	CUST_NAME VARCHAR2(4000), 
	CUST_CODE VARCHAR2(4000), 
	LAST_ERR VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIG_CUSTOMERS ***
 exec bpa.alter_policies('ERR$_CIG_CUSTOMERS');


COMMENT ON TABLE BARS.ERR$_CIG_CUSTOMERS IS 'DML Error Logging table for "CIG_CUSTOMERS"';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.CUST_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.CUST_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.UPD_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.SYNC_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.CUST_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.CUST_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.LAST_ERR IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUSTOMERS.BRANCH IS '';



PROMPT *** Create  grants  ERR$_CIG_CUSTOMERS ***
grant SELECT                                                                 on ERR$_CIG_CUSTOMERS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIG_CUSTOMERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIG_CUSTOMERS.sql =========*** En
PROMPT ===================================================================================== 
