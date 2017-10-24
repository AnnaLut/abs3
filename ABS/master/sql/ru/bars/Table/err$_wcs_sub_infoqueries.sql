

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_SUB_INFOQUERIES.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_SUB_INFOQUERIES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_SUB_INFOQUERIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_SUB_INFOQUERIES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SUBPRODUCT_ID VARCHAR2(4000), 
	IQUERY_ID VARCHAR2(4000), 
	ACT_LEVEL VARCHAR2(4000), 
	SERVICE_ID VARCHAR2(4000), 
	IS_REQUIRED VARCHAR2(4000), 
	ORD VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_SUB_INFOQUERIES ***
 exec bpa.alter_policies('ERR$_WCS_SUB_INFOQUERIES');


COMMENT ON TABLE BARS.ERR$_WCS_SUB_INFOQUERIES IS 'DML Error Logging table for "WCS_SUBPRODUCT_INFOQUERIES"';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.SUBPRODUCT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.IQUERY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.ACT_LEVEL IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.SERVICE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.IS_REQUIRED IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUB_INFOQUERIES.ORD IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_SUB_INFOQUERIES.sql =========
PROMPT ===================================================================================== 
