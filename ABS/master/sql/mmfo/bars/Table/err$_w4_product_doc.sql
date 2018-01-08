

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_W4_PRODUCT_DOC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_W4_PRODUCT_DOC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_W4_PRODUCT_DOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_W4_PRODUCT_DOC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	GRP_CODE VARCHAR2(4000), 
	DOC_ID VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_W4_PRODUCT_DOC ***
 exec bpa.alter_policies('ERR$_W4_PRODUCT_DOC');


COMMENT ON TABLE BARS.ERR$_W4_PRODUCT_DOC IS 'DML Error Logging table for "W4_PRODUCT_DOC"';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT_DOC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT_DOC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT_DOC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT_DOC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT_DOC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT_DOC.GRP_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_W4_PRODUCT_DOC.DOC_ID IS '';



PROMPT *** Create  grants  ERR$_W4_PRODUCT_DOC ***
grant SELECT                                                                 on ERR$_W4_PRODUCT_DOC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_W4_PRODUCT_DOC.sql =========*** E
PROMPT ===================================================================================== 
