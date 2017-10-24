

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_MAC_REFER_PARAMS.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_MAC_REFER_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_MAC_REFER_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_MAC_REFER_PARAMS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	MAC_ID VARCHAR2(4000), 
	TAB_NAME VARCHAR2(4000), 
	KEY_FIELD VARCHAR2(4000), 
	SEMANTIC_FIELD VARCHAR2(4000), 
	SHOW_FIELDS VARCHAR2(4000), 
	WHERE_CLAUSE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_MAC_REFER_PARAMS ***
 exec bpa.alter_policies('ERR$_WCS_MAC_REFER_PARAMS');


COMMENT ON TABLE BARS.ERR$_WCS_MAC_REFER_PARAMS IS 'DML Error Logging table for "WCS_MAC_REFER_PARAMS"';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.MAC_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.TAB_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.KEY_FIELD IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.SEMANTIC_FIELD IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.SHOW_FIELDS IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_MAC_REFER_PARAMS.WHERE_CLAUSE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_MAC_REFER_PARAMS.sql ========
PROMPT ===================================================================================== 
