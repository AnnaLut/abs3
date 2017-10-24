

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_W4_CARD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_W4_CARD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_W4_CARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_W4_CARD 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CODE VARCHAR2(4000), 
	PRODUCT_CODE VARCHAR2(4000), 
	SUB_CODE VARCHAR2(4000), 
	DATE_OPEN VARCHAR2(4000), 
	DATE_CLOSE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_W4_CARD ***
 exec bpa.alter_policies('ERR$_W4_CARD');


COMMENT ON TABLE BARS.ERR$_W4_CARD IS 'DML Error Logging table for "W4_CARD"';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.CODE IS '';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.PRODUCT_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.SUB_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.DATE_OPEN IS '';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.DATE_CLOSE IS '';
COMMENT ON COLUMN BARS.ERR$_W4_CARD.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_W4_CARD.sql =========*** End *** 
PROMPT ===================================================================================== 
