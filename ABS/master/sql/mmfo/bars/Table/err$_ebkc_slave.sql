

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_EBKC_SLAVE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_EBKC_SLAVE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_EBKC_SLAVE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_EBKC_SLAVE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	GCIF VARCHAR2(4000), 
	SLAVE_KF VARCHAR2(4000), 
	CUST_TYPE VARCHAR2(4000), 
	SLAVE_RNK VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_EBKC_SLAVE ***
 exec bpa.alter_policies('ERR$_EBKC_SLAVE');


COMMENT ON TABLE BARS.ERR$_EBKC_SLAVE IS 'DML Error Logging table for "EBKC_SLAVE"';
COMMENT ON COLUMN BARS.ERR$_EBKC_SLAVE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SLAVE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SLAVE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SLAVE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SLAVE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SLAVE.GCIF IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SLAVE.SLAVE_KF IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SLAVE.CUST_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SLAVE.SLAVE_RNK IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_EBKC_SLAVE.sql =========*** End *
PROMPT ===================================================================================== 
