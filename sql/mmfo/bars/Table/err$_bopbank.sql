

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BOPBANK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BOPBANK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BOPBANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BOPBANK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REGNUM VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	ADDRESS VARCHAR2(4000), 
	FIO VARCHAR2(4000), 
	ELADR VARCHAR2(4000), 
	BIC VARCHAR2(4000), 
	REGNUM_N VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BOPBANK ***
 exec bpa.alter_policies('ERR$_BOPBANK');


COMMENT ON TABLE BARS.ERR$_BOPBANK IS 'DML Error Logging table for "BOPBANK"';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.REGNUM IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.ADDRESS IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.FIO IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.ELADR IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.BIC IS '';
COMMENT ON COLUMN BARS.ERR$_BOPBANK.REGNUM_N IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BOPBANK.sql =========*** End *** 
PROMPT ===================================================================================== 
