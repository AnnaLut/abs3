

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_OVERDUE_DATES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_OVERDUE_DATES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_OVERDUE_DATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_OVERDUE_DATES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	NDTYPE VARCHAR2(4000), 
	OVERDUE_TYPE VARCHAR2(4000), 
	OVERDUE_METHOD VARCHAR2(4000), 
	REPORT_DATE VARCHAR2(4000), 
	OVERDUE_DATE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_OVERDUE_DATES ***
 exec bpa.alter_policies('ERR$_CC_OVERDUE_DATES');


COMMENT ON TABLE BARS.ERR$_CC_OVERDUE_DATES IS 'DML Error Logging table for "CC_OVERDUE_DATES"';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.NDTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.OVERDUE_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.OVERDUE_METHOD IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.REPORT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.OVERDUE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_OVERDUE_DATES.KF IS '';



PROMPT *** Create  grants  ERR$_CC_OVERDUE_DATES ***
grant SELECT                                                                 on ERR$_CC_OVERDUE_DATES to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CC_OVERDUE_DATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_OVERDUE_DATES.sql =========***
PROMPT ===================================================================================== 
