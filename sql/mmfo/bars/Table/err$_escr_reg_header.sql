

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_REG_HEADER.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ESCR_REG_HEADER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ESCR_REG_HEADER ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ESCR_REG_HEADER 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	CUSTOMER_ID VARCHAR2(4000), 
	CUSTOMER_NAME VARCHAR2(4000), 
	CUSTOMER_OKPO VARCHAR2(4000), 
	CUSTOMER_REGION VARCHAR2(4000), 
	CUSTOMER_FULL_ADDRESS VARCHAR2(4000), 
	SUBS_NUMB VARCHAR2(4000), 
	SUBS_DATE VARCHAR2(4000), 
	SUBS_DOC_TYPE VARCHAR2(4000), 
	DEAL_ID VARCHAR2(4000), 
	DEAL_NUMBER VARCHAR2(4000), 
	DEAL_DATE_FROM VARCHAR2(4000), 
	DEAL_DATE_TO VARCHAR2(4000), 
	DEAL_TERM VARCHAR2(4000), 
	DEAL_PRODUCT VARCHAR2(4000), 
	DEAL_STATE VARCHAR2(4000), 
	DEAL_TYPE_NAME VARCHAR2(4000), 
	DEAL_SUM VARCHAR2(4000), 
	GOOD_COST VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	DOC_DATE VARCHAR2(4000), 
	COMP_SUM VARCHAR2(4000), 
	BRANCH_CODE VARCHAR2(4000), 
	BRANCH_NAME VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	USER_ID VARCHAR2(4000), 
	USER_NAME VARCHAR2(4000), 
	NEW_GOOD_COST VARCHAR2(4000), 
	NEW_DEAL_SUM VARCHAR2(4000), 
	NEW_COMP_SUM VARCHAR2(4000), 
	CREDIT_STATUS_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ESCR_REG_HEADER ***
 exec bpa.alter_policies('ERR$_ESCR_REG_HEADER');


COMMENT ON TABLE BARS.ERR$_ESCR_REG_HEADER IS 'DML Error Logging table for "ESCR_REG_HEADER"';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.CUSTOMER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.CUSTOMER_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.CUSTOMER_OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.CUSTOMER_REGION IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.CUSTOMER_FULL_ADDRESS IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.SUBS_NUMB IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.SUBS_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.SUBS_DOC_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.DEAL_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.DEAL_NUMBER IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.DEAL_DATE_FROM IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.DEAL_DATE_TO IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.DEAL_TERM IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.DEAL_PRODUCT IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.DEAL_STATE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.DEAL_TYPE_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.DEAL_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.GOOD_COST IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.DOC_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.COMP_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.BRANCH_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.BRANCH_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.USER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.USER_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.NEW_GOOD_COST IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.NEW_DEAL_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.NEW_COMP_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_HEADER.CREDIT_STATUS_ID IS '';



PROMPT *** Create  grants  ERR$_ESCR_REG_HEADER ***
grant SELECT                                                                 on ERR$_ESCR_REG_HEADER to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ESCR_REG_HEADER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_REG_HEADER.sql =========*** 
PROMPT ===================================================================================== 
