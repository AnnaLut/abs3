

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PFU_CA_FILES_TRACKING.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PFU_CA_FILES_TRACKING ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PFU_CA_FILES_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PFU_CA_FILES_TRACKING 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	FILE_ID VARCHAR2(4000), 
	STATE VARCHAR2(4000), 
	MESSAGE VARCHAR2(4000), 
	SYS_TIME VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PFU_CA_FILES_TRACKING ***
 exec bpa.alter_policies('ERR$_PFU_CA_FILES_TRACKING');


COMMENT ON TABLE BARS.ERR$_PFU_CA_FILES_TRACKING IS 'DML Error Logging table for "PFU_CA_FILES_TRACKING"';
COMMENT ON COLUMN BARS.ERR$_PFU_CA_FILES_TRACKING.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_CA_FILES_TRACKING.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_CA_FILES_TRACKING.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_CA_FILES_TRACKING.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_CA_FILES_TRACKING.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_CA_FILES_TRACKING.ID IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_CA_FILES_TRACKING.FILE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_CA_FILES_TRACKING.STATE IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_CA_FILES_TRACKING.MESSAGE IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_CA_FILES_TRACKING.SYS_TIME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PFU_CA_FILES_TRACKING.sql =======
PROMPT ===================================================================================== 
