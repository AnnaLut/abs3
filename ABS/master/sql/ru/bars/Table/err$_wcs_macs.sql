

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_MACS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_MACS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_MACS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_MACS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	TYPE_ID VARCHAR2(4000), 
	APPLY_LEVEL VARCHAR2(4000), 
	MANDATORY VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_MACS ***
 exec bpa.alter_policies('ERR$_WCS_MACS');


COMMENT ON TABLE BARS.ERR$_WCS_MACS IS 'DML Error Logging table for "WCS_MACS"';
COMMENT ON COLUMN BARS.ERR$_WCS_MACS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MACS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MACS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MACS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MACS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MACS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MACS.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MACS.TYPE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MACS.APPLY_LEVEL IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MACS.MANDATORY IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_MACS.sql =========*** End ***
PROMPT ===================================================================================== 
