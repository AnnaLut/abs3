

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_INS_ACCIDENTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_INS_ACCIDENTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_INS_ACCIDENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_INS_ACCIDENTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	DEAL_ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	STAFF_ID VARCHAR2(4000), 
	CRT_DATE VARCHAR2(4000), 
	ACDT_DATE VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	REFUND_SUM VARCHAR2(4000), 
	REFUND_DATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_INS_ACCIDENTS ***
 exec bpa.alter_policies('ERR$_INS_ACCIDENTS');


COMMENT ON TABLE BARS.ERR$_INS_ACCIDENTS IS 'DML Error Logging table for "INS_ACCIDENTS"';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.DEAL_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.STAFF_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.CRT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.ACDT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.REFUND_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_INS_ACCIDENTS.REFUND_DATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_INS_ACCIDENTS.sql =========*** En
PROMPT ===================================================================================== 
