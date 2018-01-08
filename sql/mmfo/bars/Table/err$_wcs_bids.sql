

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_BIDS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_BIDS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_BIDS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_BIDS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	SUBPRODUCT_ID VARCHAR2(4000), 
	CRT_DATE VARCHAR2(4000), 
	INN VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	MGR_ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	LAST_DATE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_BIDS ***
 exec bpa.alter_policies('ERR$_WCS_BIDS');


COMMENT ON TABLE BARS.ERR$_WCS_BIDS IS 'DML Error Logging table for "WCS_BIDS"';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.SUBPRODUCT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.CRT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.INN IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.MGR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BIDS.LAST_DATE IS '';



PROMPT *** Create  grants  ERR$_WCS_BIDS ***
grant SELECT                                                                 on ERR$_WCS_BIDS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_BIDS.sql =========*** End ***
PROMPT ===================================================================================== 
