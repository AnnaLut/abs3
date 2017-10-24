

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_REG_BODY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ESCR_REG_BODY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ESCR_REG_BODY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ESCR_REG_BODY 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	DEAL_ID VARCHAR2(4000), 
	DEAL_ADR_ID VARCHAR2(4000), 
	DEAL_REGION VARCHAR2(4000), 
	DEAL_FULL_ADDRESS VARCHAR2(4000), 
	DEAL_BUILD_ID VARCHAR2(4000), 
	DEAL_EVENT_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ESCR_REG_BODY ***
 exec bpa.alter_policies('ERR$_ESCR_REG_BODY');


COMMENT ON TABLE BARS.ERR$_ESCR_REG_BODY IS 'DML Error Logging table for "ESCR_REG_BODY"';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.DEAL_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.DEAL_ADR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.DEAL_REGION IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.DEAL_FULL_ADDRESS IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.DEAL_BUILD_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ESCR_REG_BODY.DEAL_EVENT_ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ESCR_REG_BODY.sql =========*** En
PROMPT ===================================================================================== 
