

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_REG_MAPPING.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ESCR_REG_MAPPING ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ESCR_REG_MAPPING ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ESCR_REG_MAPPING 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	IN_DOC_ID VARCHAR2(4000), 
	IN_DOC_TYPE VARCHAR2(4000), 
	OPER_DATE VARCHAR2(4000), 
	OUT_DOC_ID VARCHAR2(4000), 
	OUT_DOC_TYPE VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	OPER_TYPE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ESCR_REG_MAPPING ***
 exec bpa.alter_policies('ERR$_ESCR_REG_MAPPING');


COMMENT ON TABLE BARS.ERR$_ESCR_REG_MAPPING IS 'DML Error Logging table for "ESCR_REG_MAPPING"';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.IN_DOC_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.IN_DOC_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.OPER_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.OUT_DOC_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.OUT_DOC_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_MAPPING.OPER_TYPE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_REG_MAPPING.sql =========***
PROMPT ===================================================================================== 
