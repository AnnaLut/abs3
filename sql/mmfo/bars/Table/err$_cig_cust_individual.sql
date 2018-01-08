

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIG_CUST_INDIVIDUAL.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIG_CUST_INDIVIDUAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIG_CUST_INDIVIDUAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIG_CUST_INDIVIDUAL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CUST_ID VARCHAR2(4000), 
	ROLE_ID VARCHAR2(4000), 
	FIRST_NAME VARCHAR2(4000), 
	SURNAME VARCHAR2(4000), 
	FATHERS_NAME VARCHAR2(4000), 
	GENDER VARCHAR2(4000), 
	CLASSIFICATION VARCHAR2(4000), 
	BIRTH_SURNAME VARCHAR2(4000), 
	DATE_BIRTH VARCHAR2(4000), 
	PLACE_BIRTH VARCHAR2(4000), 
	RESIDENCY VARCHAR2(4000), 
	CITIZENSHIP VARCHAR2(4000), 
	NEG_STATUS VARCHAR2(4000), 
	EDUCATION VARCHAR2(4000), 
	MARITAL_STATUS VARCHAR2(4000), 
	POSITION VARCHAR2(4000), 
	CUST_KEY VARCHAR2(4000), 
	PASSP_SER VARCHAR2(4000), 
	PASSP_NUM VARCHAR2(4000), 
	PASSP_ISS_DATE VARCHAR2(4000), 
	PASSP_EXP_DATE VARCHAR2(4000), 
	PASSP_ORGAN VARCHAR2(4000), 
	PHONE_OFFICE VARCHAR2(4000), 
	PHONE_MOBILE VARCHAR2(4000), 
	PHONE_FAX VARCHAR2(4000), 
	EMAIL VARCHAR2(4000), 
	WEBSITE VARCHAR2(4000), 
	FACT_TERRITORY_ID VARCHAR2(4000), 
	FACT_STREET_BUILDNUM VARCHAR2(4000), 
	FACT_POST_INDEX VARCHAR2(4000), 
	REG_TERRITORY_ID VARCHAR2(4000), 
	REG_STREET_BUILDNUM VARCHAR2(4000), 
	REG_POST_INDEX VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIG_CUST_INDIVIDUAL ***
 exec bpa.alter_policies('ERR$_CIG_CUST_INDIVIDUAL');


COMMENT ON TABLE BARS.ERR$_CIG_CUST_INDIVIDUAL IS 'DML Error Logging table for "CIG_CUST_INDIVIDUAL"';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.CUST_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.ROLE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.FIRST_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.SURNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.FATHERS_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.GENDER IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.CLASSIFICATION IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.BIRTH_SURNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.DATE_BIRTH IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.PLACE_BIRTH IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.RESIDENCY IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.CITIZENSHIP IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.NEG_STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.EDUCATION IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.MARITAL_STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.POSITION IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.CUST_KEY IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.PASSP_SER IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.PASSP_NUM IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.PASSP_ISS_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.PASSP_EXP_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.PASSP_ORGAN IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.PHONE_OFFICE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.PHONE_MOBILE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.PHONE_FAX IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.EMAIL IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.WEBSITE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.FACT_TERRITORY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.FACT_STREET_BUILDNUM IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.FACT_POST_INDEX IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.REG_TERRITORY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.REG_STREET_BUILDNUM IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.REG_POST_INDEX IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_CUST_INDIVIDUAL.BRANCH IS '';



PROMPT *** Create  grants  ERR$_CIG_CUST_INDIVIDUAL ***
grant SELECT                                                                 on ERR$_CIG_CUST_INDIVIDUAL to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIG_CUST_INDIVIDUAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIG_CUST_INDIVIDUAL.sql =========
PROMPT ===================================================================================== 
