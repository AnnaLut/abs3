

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_CUST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FIN_CUST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FIN_CUST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FIN_CUST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NMK VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	CUSTTYPE VARCHAR2(4000), 
	FZ VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	VED VARCHAR2(4000), 
	DATEA VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FIN_CUST ***
 exec bpa.alter_policies('ERR$_FIN_CUST');


COMMENT ON TABLE BARS.ERR$_FIN_CUST IS 'DML Error Logging table for "FIN_CUST"';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.NMK IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.FZ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.VED IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_CUST.DATEA IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_CUST.sql =========*** End ***
PROMPT ===================================================================================== 
