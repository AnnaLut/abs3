

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_MWAY_MATCH.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_MWAY_MATCH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_MWAY_MATCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_MWAY_MATCH 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	DATE_TR VARCHAR2(4000), 
	SUM_TR VARCHAR2(4000), 
	LCV_TR VARCHAR2(4000), 
	NLS_TR VARCHAR2(4000), 
	RRN_TR VARCHAR2(4000), 
	DRN_TR VARCHAR2(4000), 
	STATE VARCHAR2(4000), 
	REF_TR VARCHAR2(4000), 
	REF_FEE_TR VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_MWAY_MATCH ***
 exec bpa.alter_policies('ERR$_MWAY_MATCH');


COMMENT ON TABLE BARS.ERR$_MWAY_MATCH IS 'DML Error Logging table for "MWAY_MATCH"';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.ID IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.DATE_TR IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.SUM_TR IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.LCV_TR IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.NLS_TR IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.RRN_TR IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.DRN_TR IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.STATE IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.REF_TR IS '';
COMMENT ON COLUMN BARS.ERR$_MWAY_MATCH.REF_FEE_TR IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_MWAY_MATCH.sql =========*** End *
PROMPT ===================================================================================== 
