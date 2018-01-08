

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BOPCODE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BOPCODE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BOPCODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BOPCODE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TRANSCODE VARCHAR2(4000), 
	KOD_NNN VARCHAR2(4000), 
	TRANSDESC VARCHAR2(4000), 
	KIND VARCHAR2(4000), 
	TRANSCODE_N VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BOPCODE ***
 exec bpa.alter_policies('ERR$_BOPCODE');


COMMENT ON TABLE BARS.ERR$_BOPCODE IS 'DML Error Logging table for "BOPCODE"';
COMMENT ON COLUMN BARS.ERR$_BOPCODE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCODE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCODE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCODE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCODE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCODE.TRANSCODE IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCODE.KOD_NNN IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCODE.TRANSDESC IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCODE.KIND IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCODE.TRANSCODE_N IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BOPCODE.sql =========*** End *** 
PROMPT ===================================================================================== 
