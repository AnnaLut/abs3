

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_CURRENCY_INCOME_RU.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAY_CURRENCY_INCOME_RU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAY_CURRENCY_INCOME_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAY_CURRENCY_INCOME_RU 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	MFO VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	PDAT VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	NAZN VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	LCV VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	NMK VARCHAR2(4000), 
	S VARCHAR2(4000), 
	S_OBZ VARCHAR2(4000), 
	TXT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAY_CURRENCY_INCOME_RU ***
 exec bpa.alter_policies('ERR$_ZAY_CURRENCY_INCOME_RU');


COMMENT ON TABLE BARS.ERR$_ZAY_CURRENCY_INCOME_RU IS 'DML Error Logging table for "ZAY_CURRENCY_INCOME_RU"';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.PDAT IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.TT IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.REF IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.NAZN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.KV IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.LCV IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.NMK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.S IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.S_OBZ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_CURRENCY_INCOME_RU.TXT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_CURRENCY_INCOME_RU.sql ======
PROMPT ===================================================================================== 
