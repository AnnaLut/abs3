

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SW_OPERW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SW_OPERW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SW_OPERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SW_OPERW 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SWREF VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	SEQ VARCHAR2(4000), 
	N VARCHAR2(4000), 
	OPT VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SW_OPERW ***
 exec bpa.alter_policies('ERR$_SW_OPERW');


COMMENT ON TABLE BARS.ERR$_SW_OPERW IS 'DML Error Logging table for "SW_OPERW"';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.SWREF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.SEQ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.N IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.OPT IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPERW.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SW_OPERW.sql =========*** End ***
PROMPT ===================================================================================== 
