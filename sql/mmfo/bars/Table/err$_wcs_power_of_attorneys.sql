

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_POWER_OF_ATTORNEYS.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_POWER_OF_ATTORNEYS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_POWER_OF_ATTORNEYS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_POWER_OF_ATTORNEYS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BRANCH VARCHAR2(4000), 
	ORD VARCHAR2(4000), 
	ACTIVE VARCHAR2(4000), 
	FIO VARCHAR2(4000), 
	FIO_R VARCHAR2(4000), 
	POST VARCHAR2(4000), 
	POST_R VARCHAR2(4000), 
	POA_DOC VARCHAR2(4000), 
	POA_DATE VARCHAR2(4000), 
	POA_NOTARY VARCHAR2(4000), 
	POA_NOTARY_NUM VARCHAR2(4000), 
	BRANCH_ADR VARCHAR2(4000), 
	BRANCH_LOC VARCHAR2(4000), 
	BRANCH_NAME VARCHAR2(4000), 
	POA_CERT VARCHAR2(4000), 
	DISTRICT_NAME VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_POWER_OF_ATTORNEYS ***
 exec bpa.alter_policies('ERR$_WCS_POWER_OF_ATTORNEYS');


COMMENT ON TABLE BARS.ERR$_WCS_POWER_OF_ATTORNEYS IS 'DML Error Logging table for "WCS_POWER_OF_ATTORNEYS"';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.ORD IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.ACTIVE IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.FIO IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.FIO_R IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.POST IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.POST_R IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.POA_DOC IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.POA_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.POA_NOTARY IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.POA_NOTARY_NUM IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.BRANCH_ADR IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.BRANCH_LOC IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.BRANCH_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.POA_CERT IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_POWER_OF_ATTORNEYS.DISTRICT_NAME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_POWER_OF_ATTORNEYS.sql ======
PROMPT ===================================================================================== 