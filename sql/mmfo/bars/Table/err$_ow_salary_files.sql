

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OW_SALARY_FILES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OW_SALARY_FILES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OW_SALARY_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OW_SALARY_FILES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	FILE_NAME VARCHAR2(4000), 
	FILE_DATE VARCHAR2(4000), 
	CARD_CODE VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	PROECT_ID VARCHAR2(4000), 
	FILE_N VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OW_SALARY_FILES ***
 exec bpa.alter_policies('ERR$_OW_SALARY_FILES');


COMMENT ON TABLE BARS.ERR$_OW_SALARY_FILES IS 'DML Error Logging table for "OW_SALARY_FILES"';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.ID IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.FILE_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.FILE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.CARD_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.PROECT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.FILE_N IS '';
COMMENT ON COLUMN BARS.ERR$_OW_SALARY_FILES.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OW_SALARY_FILES.sql =========*** 
PROMPT ===================================================================================== 
