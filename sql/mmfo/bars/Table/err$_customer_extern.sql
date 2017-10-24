

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMER_EXTERN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CUSTOMER_EXTERN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CUSTOMER_EXTERN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CUSTOMER_EXTERN 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	DOC_TYPE VARCHAR2(4000), 
	DOC_SERIAL VARCHAR2(4000), 
	DOC_NUMBER VARCHAR2(4000), 
	DOC_DATE VARCHAR2(4000), 
	DOC_ISSUER VARCHAR2(4000), 
	BIRTHDAY VARCHAR2(4000), 
	BIRTHPLACE VARCHAR2(4000), 
	SEX VARCHAR2(4000), 
	ADR VARCHAR2(4000), 
	TEL VARCHAR2(4000), 
	EMAIL VARCHAR2(4000), 
	CUSTTYPE VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	COUNTRY VARCHAR2(4000), 
	REGION VARCHAR2(4000), 
	FS VARCHAR2(4000), 
	VED VARCHAR2(4000), 
	SED VARCHAR2(4000), 
	ISE VARCHAR2(4000), 
	NOTES VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	DETRNK VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CUSTOMER_EXTERN ***
 exec bpa.alter_policies('ERR$_CUSTOMER_EXTERN');


COMMENT ON TABLE BARS.ERR$_CUSTOMER_EXTERN IS 'DML Error Logging table for "CUSTOMER_EXTERN"';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.DOC_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.DOC_SERIAL IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.DOC_NUMBER IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.DOC_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.DOC_ISSUER IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.BIRTHDAY IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.BIRTHPLACE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.SEX IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.ADR IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.TEL IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.EMAIL IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.COUNTRY IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.REGION IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.FS IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.VED IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.SED IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.ISE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.NOTES IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.DETRNK IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_EXTERN.ID IS '';



PROMPT *** Create  grants  ERR$_CUSTOMER_EXTERN ***
grant SELECT                                                                 on ERR$_CUSTOMER_EXTERN to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMER_EXTERN.sql =========*** 
PROMPT ===================================================================================== 
