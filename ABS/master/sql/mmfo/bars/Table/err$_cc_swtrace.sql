

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_SWTRACE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_SWTRACE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_SWTRACE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_SWTRACE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	SWO_BIC VARCHAR2(4000), 
	SWO_ACC VARCHAR2(4000), 
	SWO_ALT VARCHAR2(4000), 
	INTERM_B VARCHAR2(4000), 
	FIELD_58D VARCHAR2(4000), 
	NLS VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_SWTRACE ***
 exec bpa.alter_policies('ERR$_CC_SWTRACE');


COMMENT ON TABLE BARS.ERR$_CC_SWTRACE IS 'DML Error Logging table for "CC_SWTRACE"';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.SWO_BIC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.SWO_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.SWO_ALT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.INTERM_B IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.FIELD_58D IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SWTRACE.NLS IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_SWTRACE.sql =========*** End *
PROMPT ===================================================================================== 
