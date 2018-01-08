

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_RATES_SB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_RATES_SB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_RATES_SB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_RATES_SB 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	RATE_B VARCHAR2(4000), 
	FL_ALG VARCHAR2(4000), 
	QUOT_SIGN VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_RATES_SB ***
 exec bpa.alter_policies('ERR$_CP_RATES_SB');


COMMENT ON TABLE BARS.ERR$_CP_RATES_SB IS 'DML Error Logging table for "CP_RATES_SB"';
COMMENT ON COLUMN BARS.ERR$_CP_RATES_SB.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RATES_SB.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RATES_SB.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RATES_SB.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RATES_SB.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RATES_SB.REF IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RATES_SB.RATE_B IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RATES_SB.FL_ALG IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RATES_SB.QUOT_SIGN IS '';



PROMPT *** Create  grants  ERR$_CP_RATES_SB ***
grant SELECT                                                                 on ERR$_CP_RATES_SB to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CP_RATES_SB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_RATES_SB.sql =========*** End 
PROMPT ===================================================================================== 
