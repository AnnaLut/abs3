

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_FANTOM_PAYMENTS.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_FANTOM_PAYMENTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_FANTOM_PAYMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_FANTOM_PAYMENTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FANTOM_ID VARCHAR2(4000), 
	DIRECT VARCHAR2(4000), 
	PAYMENT_TYPE VARCHAR2(4000), 
	OPER_TYPE VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	BENEF_ID VARCHAR2(4000), 
	BANK_DATE VARCHAR2(4000), 
	VAL_DATE VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	S VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	DETAILS VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_FANTOM_PAYMENTS ***
 exec bpa.alter_policies('ERR$_CIM_FANTOM_PAYMENTS');


COMMENT ON TABLE BARS.ERR$_CIM_FANTOM_PAYMENTS IS 'DML Error Logging table for "CIM_FANTOM_PAYMENTS"';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.FANTOM_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.DIRECT IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.PAYMENT_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.OPER_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.BENEF_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.BANK_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.VAL_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.S IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_FANTOM_PAYMENTS.DETAILS IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_FANTOM_PAYMENTS.sql =========
PROMPT ===================================================================================== 