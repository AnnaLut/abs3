

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CM_PRODUCT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CM_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CM_PRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CM_PRODUCT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	PRODUCT_CODE VARCHAR2(4000), 
	PERCENT_OSN VARCHAR2(4000), 
	PERCENT_MOB VARCHAR2(4000), 
	PERCENT_CRED VARCHAR2(4000), 
	PERCENT_OVER VARCHAR2(4000), 
	CHG_DATE VARCHAR2(4000), 
	CHG_USER VARCHAR2(4000), 
	PERCENT_NOTUSEDLIMIT VARCHAR2(4000), 
	PERCENT_GRACE VARCHAR2(4000), 
	MM_MAX VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CM_PRODUCT ***
 exec bpa.alter_policies('ERR$_CM_PRODUCT');


COMMENT ON TABLE BARS.ERR$_CM_PRODUCT IS 'DML Error Logging table for "CM_PRODUCT"';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.PRODUCT_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.PERCENT_OSN IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.PERCENT_MOB IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.PERCENT_CRED IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.PERCENT_OVER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.CHG_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.CHG_USER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.PERCENT_NOTUSEDLIMIT IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.PERCENT_GRACE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.MM_MAX IS '';
COMMENT ON COLUMN BARS.ERR$_CM_PRODUCT.KF IS '';



PROMPT *** Create  grants  ERR$_CM_PRODUCT ***
grant SELECT                                                                 on ERR$_CM_PRODUCT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CM_PRODUCT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CM_PRODUCT.sql =========*** End *
PROMPT ===================================================================================== 
