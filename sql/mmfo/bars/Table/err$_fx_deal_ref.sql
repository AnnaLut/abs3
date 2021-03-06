

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FX_DEAL_REF.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FX_DEAL_REF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FX_DEAL_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FX_DEAL_REF 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	DEAL_TAG VARCHAR2(4000), 
	SOS VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FX_DEAL_REF ***
 exec bpa.alter_policies('ERR$_FX_DEAL_REF');


COMMENT ON TABLE BARS.ERR$_FX_DEAL_REF IS 'DML Error Logging table for "FX_DEAL_REF"';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_REF.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_REF.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_REF.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_REF.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_REF.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_REF.REF IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_REF.DEAL_TAG IS '';
COMMENT ON COLUMN BARS.ERR$_FX_DEAL_REF.SOS IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FX_DEAL_REF.sql =========*** End 
PROMPT ===================================================================================== 
