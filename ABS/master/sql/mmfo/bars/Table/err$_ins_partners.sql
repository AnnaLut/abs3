

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_INS_PARTNERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_INS_PARTNERS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_INS_PARTNERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_INS_PARTNERS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	AGR_NO VARCHAR2(4000), 
	AGR_SDATE VARCHAR2(4000), 
	AGR_EDATE VARCHAR2(4000), 
	TARIFF_ID VARCHAR2(4000), 
	FEE_ID VARCHAR2(4000), 
	LIMIT_ID VARCHAR2(4000), 
	ACTIVE VARCHAR2(4000), 
	CUSTTYPE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_INS_PARTNERS ***
 exec bpa.alter_policies('ERR$_INS_PARTNERS');


COMMENT ON TABLE BARS.ERR$_INS_PARTNERS IS 'DML Error Logging table for "INS_PARTNERS"';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.AGR_NO IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.AGR_SDATE IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.AGR_EDATE IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.TARIFF_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.FEE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.LIMIT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.ACTIVE IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNERS.CUSTTYPE IS '';



PROMPT *** Create  grants  ERR$_INS_PARTNERS ***
grant SELECT                                                                 on ERR$_INS_PARTNERS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_INS_PARTNERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_INS_PARTNERS.sql =========*** End
PROMPT ===================================================================================== 
