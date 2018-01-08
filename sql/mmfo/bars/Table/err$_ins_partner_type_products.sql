

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_INS_PARTNER_TYPE_PRODUCTS.sql ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_INS_PARTNER_TYPE_PRODUCTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_INS_PARTNER_TYPE_PRODUCTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	PRODUCT_ID VARCHAR2(4000), 
	PARTNER_ID VARCHAR2(4000), 
	TYPE_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_INS_PARTNER_TYPE_PRODUCTS ***
 exec bpa.alter_policies('ERR$_INS_PARTNER_TYPE_PRODUCTS');


COMMENT ON TABLE BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS IS 'DML Error Logging table for "INS_PARTNER_TYPE_PRODUCTS"';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS.PRODUCT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS.PARTNER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_PRODUCTS.TYPE_ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_INS_PARTNER_TYPE_PRODUCTS.sql ===
PROMPT ===================================================================================== 
