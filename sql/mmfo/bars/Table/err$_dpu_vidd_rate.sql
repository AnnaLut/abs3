

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPU_VIDD_RATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPU_VIDD_RATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPU_VIDD_RATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPU_VIDD_RATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	VIDD VARCHAR2(4000), 
	TERM VARCHAR2(4000), 
	LIMIT VARCHAR2(4000), 
	RATE VARCHAR2(4000), 
	TERM_DAYS VARCHAR2(4000), 
	TERM_INCLUDE VARCHAR2(4000), 
	SUMM_INCLUDE VARCHAR2(4000), 
	MAX_RATE VARCHAR2(4000), 
	TYPE_ID VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPU_VIDD_RATE ***
 exec bpa.alter_policies('ERR$_DPU_VIDD_RATE');


COMMENT ON TABLE BARS.ERR$_DPU_VIDD_RATE IS 'DML Error Logging table for "DPU_VIDD_RATE"';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.VIDD IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.TERM IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.LIMIT IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.RATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.TERM_DAYS IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.TERM_INCLUDE IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.SUMM_INCLUDE IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.MAX_RATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.TYPE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.KV IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_VIDD_RATE.KF IS '';



PROMPT *** Create  grants  ERR$_DPU_VIDD_RATE ***
grant SELECT                                                                 on ERR$_DPU_VIDD_RATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPU_VIDD_RATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPU_VIDD_RATE.sql =========*** En
PROMPT ===================================================================================== 
