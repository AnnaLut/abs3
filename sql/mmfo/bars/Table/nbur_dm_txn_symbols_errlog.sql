

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_TXN_SYMBOLS_ERRLOG.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_TXN_SYMBOLS_ERRLOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_TXN_SYMBOLS_ERRLOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_TXN_SYMBOLS_ERRLOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REPORT_DATE VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	STMT VARCHAR2(4000), 
	SYMB_TP VARCHAR2(4000), 
	SYMB_VAL VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DM_TXN_SYMBOLS_ERRLOG ***
 exec bpa.alter_policies('NBUR_DM_TXN_SYMBOLS_ERRLOG');


COMMENT ON TABLE BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG IS 'DML Error Logging table for "NBUR_DM_TXN_SYMBOLS"';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.REPORT_DATE IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.KF IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.REF IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.STMT IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.SYMB_TP IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ERRLOG.SYMB_VAL IS '';



PROMPT *** Create  grants  NBUR_DM_TXN_SYMBOLS_ERRLOG ***
grant SELECT                                                                 on NBUR_DM_TXN_SYMBOLS_ERRLOG to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_DM_TXN_SYMBOLS_ERRLOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_TXN_SYMBOLS_ERRLOG.sql =======
PROMPT ===================================================================================== 
