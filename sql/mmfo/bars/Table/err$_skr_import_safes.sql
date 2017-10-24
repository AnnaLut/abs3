

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SKR_IMPORT_SAFES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SKR_IMPORT_SAFES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SKR_IMPORT_SAFES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SKR_IMPORT_SAFES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SNUM VARCHAR2(4000), 
	O_SK VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	ERROR VARCHAR2(4000), 
	IMPORTED VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SKR_IMPORT_SAFES ***
 exec bpa.alter_policies('ERR$_SKR_IMPORT_SAFES');


COMMENT ON TABLE BARS.ERR$_SKR_IMPORT_SAFES IS 'DML Error Logging table for "SKR_IMPORT_SAFES"';
COMMENT ON COLUMN BARS.ERR$_SKR_IMPORT_SAFES.ERROR IS '';
COMMENT ON COLUMN BARS.ERR$_SKR_IMPORT_SAFES.IMPORTED IS '';
COMMENT ON COLUMN BARS.ERR$_SKR_IMPORT_SAFES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKR_IMPORT_SAFES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKR_IMPORT_SAFES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKR_IMPORT_SAFES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKR_IMPORT_SAFES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKR_IMPORT_SAFES.SNUM IS '';
COMMENT ON COLUMN BARS.ERR$_SKR_IMPORT_SAFES.O_SK IS '';
COMMENT ON COLUMN BARS.ERR$_SKR_IMPORT_SAFES.BRANCH IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SKR_IMPORT_SAFES.sql =========***
PROMPT ===================================================================================== 
