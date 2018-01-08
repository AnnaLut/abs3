

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_FILE_AGENCY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_FILE_AGENCY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_FILE_AGENCY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_FILE_AGENCY 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	HEADER_ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	AGENCY_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_FILE_AGENCY ***
 exec bpa.alter_policies('ERR$_DPT_FILE_AGENCY');


COMMENT ON TABLE BARS.ERR$_DPT_FILE_AGENCY IS 'DML Error Logging table for "DPT_FILE_AGENCY"';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_AGENCY.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_AGENCY.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_AGENCY.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_AGENCY.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_AGENCY.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_AGENCY.HEADER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_AGENCY.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_AGENCY.AGENCY_ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_FILE_AGENCY.sql =========*** 
PROMPT ===================================================================================== 
