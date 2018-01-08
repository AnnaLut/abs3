

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_RATE_RISE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_RATE_RISE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_RATE_RISE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_RATE_RISE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	VIDD VARCHAR2(4000), 
	DURATION_M VARCHAR2(4000), 
	DURATION_D VARCHAR2(4000), 
	IR VARCHAR2(4000), 
	OP VARCHAR2(4000), 
	BR VARCHAR2(4000), 
	ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_RATE_RISE ***
 exec bpa.alter_policies('ERR$_DPT_RATE_RISE');


COMMENT ON TABLE BARS.ERR$_DPT_RATE_RISE IS 'DML Error Logging table for "DPT_RATE_RISE"';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.VIDD IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.DURATION_M IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.DURATION_D IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.IR IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.OP IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.BR IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_RATE_RISE.ID IS '';



PROMPT *** Create  grants  ERR$_DPT_RATE_RISE ***
grant SELECT                                                                 on ERR$_DPT_RATE_RISE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_RATE_RISE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_RATE_RISE.sql =========*** En
PROMPT ===================================================================================== 
