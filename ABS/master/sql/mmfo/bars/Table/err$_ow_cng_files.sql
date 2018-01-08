

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OW_CNG_FILES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OW_CNG_FILES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OW_CNG_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OW_CNG_FILES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	FILE_NAME VARCHAR2(4000), 
	FILE_DATE VARCHAR2(4000), 
	STATUS VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OW_CNG_FILES ***
 exec bpa.alter_policies('ERR$_OW_CNG_FILES');


COMMENT ON TABLE BARS.ERR$_OW_CNG_FILES IS 'DML Error Logging table for "OW_CNG_FILES"';
COMMENT ON COLUMN BARS.ERR$_OW_CNG_FILES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CNG_FILES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CNG_FILES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CNG_FILES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CNG_FILES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CNG_FILES.ID IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CNG_FILES.FILE_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CNG_FILES.FILE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CNG_FILES.STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CNG_FILES.KF IS '';



PROMPT *** Create  grants  ERR$_OW_CNG_FILES ***
grant SELECT                                                                 on ERR$_OW_CNG_FILES to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OW_CNG_FILES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OW_CNG_FILES.sql =========*** End
PROMPT ===================================================================================== 
