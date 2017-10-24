

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BOPCOUNT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BOPCOUNT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BOPCOUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BOPCOUNT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ISO_COUNTR VARCHAR2(4000), 
	KODC VARCHAR2(4000), 
	COUNTRY VARCHAR2(4000), 
	PR VARCHAR2(4000), 
	A2 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BOPCOUNT ***
 exec bpa.alter_policies('ERR$_BOPCOUNT');


COMMENT ON TABLE BARS.ERR$_BOPCOUNT IS 'DML Error Logging table for "BOPCOUNT"';
COMMENT ON COLUMN BARS.ERR$_BOPCOUNT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCOUNT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCOUNT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCOUNT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCOUNT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCOUNT.ISO_COUNTR IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCOUNT.KODC IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCOUNT.COUNTRY IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCOUNT.PR IS '';
COMMENT ON COLUMN BARS.ERR$_BOPCOUNT.A2 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BOPCOUNT.sql =========*** End ***
PROMPT ===================================================================================== 
