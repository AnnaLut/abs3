

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_SUBPRODUCT_CREDITDATA.sql ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_SUBPRODUCT_CREDITDATA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_SUBPRODUCT_CREDITDATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SUBPRODUCT_ID VARCHAR2(4000), 
	CRDDATA_ID VARCHAR2(4000), 
	QUESTION_ID VARCHAR2(4000), 
	IS_VISIBLE VARCHAR2(4000), 
	IS_CHECKABLE VARCHAR2(4000), 
	CHECK_PROC VARCHAR2(4000), 
	IS_READONLY VARCHAR2(4000), 
	DNSHOW_IF VARCHAR2(4000), 
	GROUP_ID VARCHAR2(4000), 
	ORD VARCHAR2(4000), 
	IS_REQUIRED VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_SUBPRODUCT_CREDITDATA ***
 exec bpa.alter_policies('ERR$_WCS_SUBPRODUCT_CREDITDATA');


COMMENT ON TABLE BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA IS 'DML Error Logging table for "WCS_SUBPRODUCT_CREDITDATA"';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.SUBPRODUCT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.CRDDATA_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.IS_VISIBLE IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.IS_CHECKABLE IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.CHECK_PROC IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.IS_READONLY IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.DNSHOW_IF IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.GROUP_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.ORD IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SUBPRODUCT_CREDITDATA.IS_REQUIRED IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_SUBPRODUCT_CREDITDATA.sql ===
PROMPT ===================================================================================== 
