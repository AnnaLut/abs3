

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SW_BANKS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SW_BANKS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SW_BANKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SW_BANKS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BIC VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	OFFICE VARCHAR2(4000), 
	CITY VARCHAR2(4000), 
	COUNTRY VARCHAR2(4000), 
	CHRSET VARCHAR2(4000), 
	TRANSBACK VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SW_BANKS ***
 exec bpa.alter_policies('ERR$_SW_BANKS');


COMMENT ON TABLE BARS.ERR$_SW_BANKS IS 'DML Error Logging table for "SW_BANKS"';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.BIC IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.OFFICE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.CITY IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.COUNTRY IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.CHRSET IS '';
COMMENT ON COLUMN BARS.ERR$_SW_BANKS.TRANSBACK IS '';



PROMPT *** Create  grants  ERR$_SW_BANKS ***
grant SELECT                                                                 on ERR$_SW_BANKS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SW_BANKS.sql =========*** End ***
PROMPT ===================================================================================== 
