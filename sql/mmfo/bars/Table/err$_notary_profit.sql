

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_NOTARY_PROFIT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_NOTARY_PROFIT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_NOTARY_PROFIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_NOTARY_PROFIT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NOTARY_ID VARCHAR2(4000), 
	ACCR_ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	NBSOB22 VARCHAR2(4000), 
	REF_OPER VARCHAR2(4000), 
	DAT_OPER VARCHAR2(4000), 
	PROFIT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_NOTARY_PROFIT ***
 exec bpa.alter_policies('ERR$_NOTARY_PROFIT');


COMMENT ON TABLE BARS.ERR$_NOTARY_PROFIT IS 'DML Error Logging table for "NOTARY_PROFIT"';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.ID IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.NOTARY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.ACCR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.NBSOB22 IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.REF_OPER IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.DAT_OPER IS '';
COMMENT ON COLUMN BARS.ERR$_NOTARY_PROFIT.PROFIT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_NOTARY_PROFIT.sql =========*** En
PROMPT ===================================================================================== 
