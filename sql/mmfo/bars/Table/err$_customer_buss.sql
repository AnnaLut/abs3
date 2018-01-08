

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMER_BUSS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CUSTOMER_BUSS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CUSTOMER_BUSS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CUSTOMER_BUSS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	EDRPOU VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	BUSSLINE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CUSTOMER_BUSS ***
 exec bpa.alter_policies('ERR$_CUSTOMER_BUSS');


COMMENT ON TABLE BARS.ERR$_CUSTOMER_BUSS IS 'DML Error Logging table for "CUSTOMER_BUSS"';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_BUSS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_BUSS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_BUSS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_BUSS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_BUSS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_BUSS.EDRPOU IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_BUSS.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_BUSS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_BUSS.BUSSLINE IS '';



PROMPT *** Create  grants  ERR$_CUSTOMER_BUSS ***
grant SELECT                                                                 on ERR$_CUSTOMER_BUSS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CUSTOMER_BUSS to BARS_DM;
grant SELECT                                                                 on ERR$_CUSTOMER_BUSS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMER_BUSS.sql =========*** En
PROMPT ===================================================================================== 
