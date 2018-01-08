

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CM_SALARY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CM_SALARY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CM_SALARY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CM_SALARY 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	OKPO_N VARCHAR2(4000), 
	ORG_NAME VARCHAR2(4000), 
	PRODUCT_CODE VARCHAR2(4000), 
	CHG_DATE VARCHAR2(4000), 
	CHG_USER VARCHAR2(4000), 
	ORG_MFO VARCHAR2(4000), 
	ORG_NLS VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CM_SALARY ***
 exec bpa.alter_policies('ERR$_CM_SALARY');


COMMENT ON TABLE BARS.ERR$_CM_SALARY IS 'DML Error Logging table for "CM_SALARY"';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.OKPO_N IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.ORG_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.PRODUCT_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.CHG_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.CHG_USER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.ORG_MFO IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.ORG_NLS IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY.KF IS '';



PROMPT *** Create  grants  ERR$_CM_SALARY ***
grant SELECT                                                                 on ERR$_CM_SALARY  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CM_SALARY  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CM_SALARY.sql =========*** End **
PROMPT ===================================================================================== 
