

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_REG_STATUS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ESCR_REG_STATUS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ESCR_REG_STATUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ESCR_REG_STATUS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	CODE VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	LEVEL_TYPE VARCHAR2(4000), 
	PRIORITY VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ESCR_REG_STATUS ***
 exec bpa.alter_policies('ERR$_ESCR_REG_STATUS');


COMMENT ON TABLE BARS.ERR$_ESCR_REG_STATUS IS 'DML Error Logging table for "ESCR_REG_STATUS"';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_STATUS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_STATUS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_STATUS.CODE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_STATUS.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_STATUS.LEVEL_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_STATUS.PRIORITY IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_STATUS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_STATUS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_STATUS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_STATUS.ORA_ERR_OPTYP$ IS '';



PROMPT *** Create  grants  ERR$_ESCR_REG_STATUS ***
grant SELECT                                                                 on ERR$_ESCR_REG_STATUS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ESCR_REG_STATUS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_REG_STATUS.sql =========*** 
PROMPT ===================================================================================== 
