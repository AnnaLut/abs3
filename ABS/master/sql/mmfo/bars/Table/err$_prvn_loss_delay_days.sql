

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PRVN_LOSS_DELAY_DAYS.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PRVN_LOSS_DELAY_DAYS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PRVN_LOSS_DELAY_DAYS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PRVN_LOSS_DELAY_DAYS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REPORTING_DATE VARCHAR2(4000), 
	REF_AGR VARCHAR2(4000), 
	DAYS VARCHAR2(4000), 
	EVENT_DATE VARCHAR2(4000), 
	OBJECT_TYPE VARCHAR2(4000), 
	DAYS_CORR VARCHAR2(4000), 
	LANCH_MONTHLY VARCHAR2(4000), 
	ZO VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PRVN_LOSS_DELAY_DAYS ***
 exec bpa.alter_policies('ERR$_PRVN_LOSS_DELAY_DAYS');


COMMENT ON TABLE BARS.ERR$_PRVN_LOSS_DELAY_DAYS IS 'DML Error Logging table for "PRVN_LOSS_DELAY_DAYS"';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.REPORTING_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.REF_AGR IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.DAYS IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.EVENT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.OBJECT_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.DAYS_CORR IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.LANCH_MONTHLY IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.ZO IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_LOSS_DELAY_DAYS.KF IS '';



PROMPT *** Create  grants  ERR$_PRVN_LOSS_DELAY_DAYS ***
grant SELECT                                                                 on ERR$_PRVN_LOSS_DELAY_DAYS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_PRVN_LOSS_DELAY_DAYS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PRVN_LOSS_DELAY_DAYS.sql ========
PROMPT ===================================================================================== 
