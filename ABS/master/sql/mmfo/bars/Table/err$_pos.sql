

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_POS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_POS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_POS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_POS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	POS VARCHAR2(4000), 
	NAME VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_POS ***
 exec bpa.alter_policies('ERR$_POS');


COMMENT ON TABLE BARS.ERR$_POS IS 'DML Error Logging table for "POS"';
COMMENT ON COLUMN BARS.ERR$_POS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_POS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_POS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_POS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_POS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_POS.POS IS '';
COMMENT ON COLUMN BARS.ERR$_POS.NAME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_POS.sql =========*** End *** ====
PROMPT ===================================================================================== 