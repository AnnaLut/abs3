

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMER_RI.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CUSTOMER_RI ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CUSTOMER_RI ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CUSTOMER_RI 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	IDCODE VARCHAR2(4000), 
	DOCT VARCHAR2(4000), 
	DOCS VARCHAR2(4000), 
	DOCN VARCHAR2(4000), 
	INSFORM VARCHAR2(4000), 
	K060 VARCHAR2(4000), 
	FILERI VARCHAR2(4000), 
	DATERI VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CUSTOMER_RI ***
 exec bpa.alter_policies('ERR$_CUSTOMER_RI');


COMMENT ON TABLE BARS.ERR$_CUSTOMER_RI IS 'DML Error Logging table for "CUSTOMER_RI"';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.IDCODE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.DOCT IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.DOCS IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.DOCN IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.INSFORM IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.K060 IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.FILERI IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.DATERI IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMER_RI.KF IS '';



PROMPT *** Create  grants  ERR$_CUSTOMER_RI ***
grant SELECT                                                                 on ERR$_CUSTOMER_RI to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CUSTOMER_RI to BARS_DM;
grant SELECT                                                                 on ERR$_CUSTOMER_RI to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMER_RI.sql =========*** End 
PROMPT ===================================================================================== 
