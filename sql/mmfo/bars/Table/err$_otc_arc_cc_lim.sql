

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTC_ARC_CC_LIM.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTC_ARC_CC_LIM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTC_ARC_CC_LIM ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTC_ARC_CC_LIM 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DAT_OTC VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	LIM2 VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	SUMG VARCHAR2(4000), 
	SUMO VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTC_ARC_CC_LIM ***
 exec bpa.alter_policies('ERR$_OTC_ARC_CC_LIM');


COMMENT ON TABLE BARS.ERR$_OTC_ARC_CC_LIM IS 'DML Error Logging table for "OTC_ARC_CC_LIM"';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.DAT_OTC IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.ND IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.LIM2 IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.SUMG IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.SUMO IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_ARC_CC_LIM.KF IS '';



PROMPT *** Create  grants  ERR$_OTC_ARC_CC_LIM ***
grant SELECT                                                                 on ERR$_OTC_ARC_CC_LIM to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTC_ARC_CC_LIM.sql =========*** E
PROMPT ===================================================================================== 
