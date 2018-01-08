

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_SOB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_SOB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_SOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_SOB 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	FREQ VARCHAR2(4000), 
	PSYS VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	FACT_DATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_SOB ***
 exec bpa.alter_policies('ERR$_CC_SOB');


COMMENT ON TABLE BARS.ERR$_CC_SOB IS 'DML Error Logging table for "CC_SOB"';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.FREQ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.PSYS IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.KF IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SOB.FACT_DATE IS '';



PROMPT *** Create  grants  ERR$_CC_SOB ***
grant SELECT                                                                 on ERR$_CC_SOB     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CC_SOB     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_SOB.sql =========*** End *** =
PROMPT ===================================================================================== 
