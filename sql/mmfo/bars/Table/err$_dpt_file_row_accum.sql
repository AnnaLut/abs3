

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_FILE_ROW_ACCUM.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_FILE_ROW_ACCUM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_FILE_ROW_ACCUM ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_FILE_ROW_ACCUM 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FILENAME VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	INFO_LENGTH VARCHAR2(4000), 
	SUM VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	HEADER_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_FILE_ROW_ACCUM ***
 exec bpa.alter_policies('ERR$_DPT_FILE_ROW_ACCUM');


COMMENT ON TABLE BARS.ERR$_DPT_FILE_ROW_ACCUM IS 'DML Error Logging table for "DPT_FILE_ROW_ACCUM"';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.FILENAME IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.INFO_LENGTH IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.SUM IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_ROW_ACCUM.HEADER_ID IS '';



PROMPT *** Create  grants  ERR$_DPT_FILE_ROW_ACCUM ***
grant SELECT                                                                 on ERR$_DPT_FILE_ROW_ACCUM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_FILE_ROW_ACCUM.sql =========*
PROMPT ===================================================================================== 
