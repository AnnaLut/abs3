

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_MB_PLAN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_MB_PLAN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_MB_PLAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_MB_PLAN 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	TIPD VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	S VARCHAR2(4000), 
	ND_ID VARCHAR2(4000), 
	COMM VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_MB_PLAN ***
 exec bpa.alter_policies('ERR$_MB_PLAN');


COMMENT ON TABLE BARS.ERR$_MB_PLAN IS 'DML Error Logging table for "MB_PLAN"';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.S IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.ND_ID IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.ID IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.TIPD IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.KV IS '';
COMMENT ON COLUMN BARS.ERR$_MB_PLAN.DAT IS '';



PROMPT *** Create  grants  ERR$_MB_PLAN ***
grant SELECT                                                                 on ERR$_MB_PLAN    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_MB_PLAN    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_MB_PLAN.sql =========*** End *** 
PROMPT ===================================================================================== 
