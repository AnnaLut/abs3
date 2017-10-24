

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_VIDD_FIELD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_VIDD_FIELD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_VIDD_FIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_VIDD_FIELD 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TAG VARCHAR2(4000), 
	VIDD VARCHAR2(4000), 
	OBZ VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_VIDD_FIELD ***
 exec bpa.alter_policies('ERR$_DPT_VIDD_FIELD');


COMMENT ON TABLE BARS.ERR$_DPT_VIDD_FIELD IS 'DML Error Logging table for "DPT_VIDD_FIELD"';
COMMENT ON COLUMN BARS.ERR$_DPT_VIDD_FIELD.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_VIDD_FIELD.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_VIDD_FIELD.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_VIDD_FIELD.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_VIDD_FIELD.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_VIDD_FIELD.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_VIDD_FIELD.VIDD IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_VIDD_FIELD.OBZ IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_VIDD_FIELD.sql =========*** E
PROMPT ===================================================================================== 
