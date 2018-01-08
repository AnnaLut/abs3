

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CUST_REQ_ACCESS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CUST_REQ_ACCESS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CUST_REQ_ACCESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CUST_REQ_ACCESS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REQ_ID VARCHAR2(4000), 
	CONTRACT_ID VARCHAR2(4000), 
	AMOUNT VARCHAR2(4000), 
	FLAGS VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CUST_REQ_ACCESS ***
 exec bpa.alter_policies('ERR$_CUST_REQ_ACCESS');


COMMENT ON TABLE BARS.ERR$_CUST_REQ_ACCESS IS 'DML Error Logging table for "CUST_REQ_ACCESS"';
COMMENT ON COLUMN BARS.ERR$_CUST_REQ_ACCESS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUST_REQ_ACCESS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUST_REQ_ACCESS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUST_REQ_ACCESS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUST_REQ_ACCESS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUST_REQ_ACCESS.REQ_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CUST_REQ_ACCESS.CONTRACT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CUST_REQ_ACCESS.AMOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_CUST_REQ_ACCESS.FLAGS IS '';



PROMPT *** Create  grants  ERR$_CUST_REQ_ACCESS ***
grant SELECT                                                                 on ERR$_CUST_REQ_ACCESS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CUST_REQ_ACCESS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CUST_REQ_ACCESS.sql =========*** 
PROMPT ===================================================================================== 
