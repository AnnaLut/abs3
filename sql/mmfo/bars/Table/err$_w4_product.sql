

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_W4_PRODUCT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_W4_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_W4_PRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_W4_PRODUCT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CODE VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	GRP_CODE VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	NBS VARCHAR2(4000), 
	OB22 VARCHAR2(4000), 
	DATE_OPEN VARCHAR2(4000), 
	DATE_CLOSE VARCHAR2(4000), 
	TIP VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_W4_PRODUCT ***
 exec bpa.alter_policies('ERR$_W4_PRODUCT');


COMMENT ON TABLE BARS.ERR$_W4_PRODUCT IS 'DML Error Logging table for "W4_PRODUCT"';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.CODE IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.GRP_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.KV IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.OB22 IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.DATE_OPEN IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.DATE_CLOSE IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.TIP IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT.KF IS '';



PROMPT *** Create  grants  ERR$_W4_PRODUCT ***
grant SELECT                                                                 on ERR$_W4_PRODUCT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_W4_PRODUCT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_W4_PRODUCT.sql =========*** End *
PROMPT ===================================================================================== 
