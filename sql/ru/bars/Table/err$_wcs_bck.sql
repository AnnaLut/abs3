

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_BCK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_BCK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_BCK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_BCK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BCK_ID VARCHAR2(4000), 
	BCK_NAME VARCHAR2(4000), 
	SERVICE_METHOD VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_BCK ***
 exec bpa.alter_policies('ERR$_WCS_BCK');


COMMENT ON TABLE BARS.ERR$_WCS_BCK IS 'DML Error Logging table for "WCS_BCK"';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK.BCK_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK.BCK_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK.SERVICE_METHOD IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_BCK.sql =========*** End *** 
PROMPT ===================================================================================== 
