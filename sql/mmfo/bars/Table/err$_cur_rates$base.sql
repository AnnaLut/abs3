

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CUR_RATES$BASE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CUR_RATES$BASE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CUR_RATES$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CUR_RATES$BASE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KV VARCHAR2(4000), 
	VDATE VARCHAR2(4000), 
	BSUM VARCHAR2(4000), 
	RATE_O VARCHAR2(4000), 
	RATE_B VARCHAR2(4000), 
	RATE_S VARCHAR2(4000), 
	RATE_SPOT VARCHAR2(4000), 
	RATE_FORWARD VARCHAR2(4000), 
	LIM_POS VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	OFFICIAL VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CUR_RATES$BASE ***
 exec bpa.alter_policies('ERR$_CUR_RATES$BASE');


COMMENT ON TABLE BARS.ERR$_CUR_RATES$BASE IS 'DML Error Logging table for "CUR_RATES$BASE"';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.VDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.BSUM IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.RATE_O IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.RATE_B IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.RATE_S IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.RATE_SPOT IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.RATE_FORWARD IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.LIM_POS IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_CUR_RATES$BASE.OFFICIAL IS '';



PROMPT *** Create  grants  ERR$_CUR_RATES$BASE ***
grant SELECT                                                                 on ERR$_CUR_RATES$BASE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CUR_RATES$BASE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CUR_RATES$BASE.sql =========*** E
PROMPT ===================================================================================== 
