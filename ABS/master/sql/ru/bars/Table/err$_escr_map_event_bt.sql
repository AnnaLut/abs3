

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_MAP_EVENT_BT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ESCR_MAP_EVENT_BT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ESCR_MAP_EVENT_BT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ESCR_MAP_EVENT_BT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	EVENT_ID VARCHAR2(4000), 
	BUILD_TYPE_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ESCR_MAP_EVENT_BT ***
 exec bpa.alter_policies('ERR$_ESCR_MAP_EVENT_BT');


COMMENT ON TABLE BARS.ERR$_ESCR_MAP_EVENT_BT IS 'DML Error Logging table for "ESCR_MAP_EVENT_TO_BUILD_TYPE"';
COMMENT ON COLUMN BARS.ERR$_ESCR_MAP_EVENT_BT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_MAP_EVENT_BT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_MAP_EVENT_BT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_MAP_EVENT_BT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_MAP_EVENT_BT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_MAP_EVENT_BT.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_MAP_EVENT_BT.EVENT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_MAP_EVENT_BT.BUILD_TYPE_ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_MAP_EVENT_BT.sql =========**
PROMPT ===================================================================================== 
