

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_PROECT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BPK_PROECT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BPK_PROECT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BPK_PROECT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	PRODUCT_CODE VARCHAR2(4000), 
	OKPO_N VARCHAR2(4000), 
	USED_W4 VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BPK_PROECT ***
 exec bpa.alter_policies('ERR$_BPK_PROECT');


COMMENT ON TABLE BARS.ERR$_BPK_PROECT IS 'DML Error Logging table for "BPK_PROECT"';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.ID IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.PRODUCT_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.OKPO_N IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.USED_W4 IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT.KF IS '';



PROMPT *** Create  grants  ERR$_BPK_PROECT ***
grant SELECT                                                                 on ERR$_BPK_PROECT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_BPK_PROECT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_PROECT.sql =========*** End *
PROMPT ===================================================================================== 
