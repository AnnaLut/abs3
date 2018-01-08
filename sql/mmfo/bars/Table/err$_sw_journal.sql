

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SW_JOURNAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SW_JOURNAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SW_JOURNAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SW_JOURNAL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SWREF VARCHAR2(4000), 
	MT VARCHAR2(4000), 
	TRN VARCHAR2(4000), 
	IO_IND VARCHAR2(4000), 
	CURRENCY VARCHAR2(4000), 
	SENDER VARCHAR2(4000), 
	RECEIVER VARCHAR2(4000), 
	PAYER VARCHAR2(4000), 
	PAYEE VARCHAR2(4000), 
	AMOUNT VARCHAR2(4000), 
	ACCD VARCHAR2(4000), 
	ACCK VARCHAR2(4000), 
	DATE_IN VARCHAR2(4000), 
	DATE_OUT VARCHAR2(4000), 
	DATE_PAY VARCHAR2(4000), 
	DATE_REC VARCHAR2(4000), 
	VDATE VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	PAGE VARCHAR2(4000), 
	TRANSIT VARCHAR2(4000), 
	FLAGS VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	LAU VARCHAR2(4000), 
	LAU_FLAG VARCHAR2(4000), 
	LAU_UID VARCHAR2(4000), 
	LAU_ACT VARCHAR2(4000), 
	IMPORTED VARCHAR2(4000), 
	APP_FLAG VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SW_JOURNAL ***
 exec bpa.alter_policies('ERR$_SW_JOURNAL');


COMMENT ON TABLE BARS.ERR$_SW_JOURNAL IS 'DML Error Logging table for "SW_JOURNAL"';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.SWREF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.MT IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.TRN IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.IO_IND IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.CURRENCY IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.SENDER IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.RECEIVER IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.PAYER IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.PAYEE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.AMOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.ACCD IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.ACCK IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.DATE_IN IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.DATE_OUT IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.DATE_PAY IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.DATE_REC IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.VDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.ID IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.PAGE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.TRANSIT IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.FLAGS IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.LAU IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.LAU_FLAG IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.LAU_UID IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.LAU_ACT IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.IMPORTED IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.APP_FLAG IS '';
COMMENT ON COLUMN BARS.ERR$_SW_JOURNAL.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SW_JOURNAL.sql =========*** End *
PROMPT ===================================================================================== 
