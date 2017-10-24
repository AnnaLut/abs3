

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_CONTRACTS_TRADE.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_CONTRACTS_TRADE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_CONTRACTS_TRADE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_CONTRACTS_TRADE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CONTR_ID VARCHAR2(4000), 
	SPEC_ID VARCHAR2(4000), 
	SUBJECT_ID VARCHAR2(4000), 
	DEADLINE VARCHAR2(4000), 
	TRADE_DESC VARCHAR2(4000), 
	WITHOUT_ACTS VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_CONTRACTS_TRADE ***
 exec bpa.alter_policies('ERR$_CIM_CONTRACTS_TRADE');


COMMENT ON TABLE BARS.ERR$_CIM_CONTRACTS_TRADE IS 'DML Error Logging table for "CIM_CONTRACTS_TRADE"';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.CONTR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.SPEC_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.SUBJECT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.DEADLINE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.TRADE_DESC IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACTS_TRADE.WITHOUT_ACTS IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_CONTRACTS_TRADE.sql =========
PROMPT ===================================================================================== 
