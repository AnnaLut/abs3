

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OW_CRVACC_REQUEST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OW_CRVACC_REQUEST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OW_CRVACC_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OW_CRVACC_REQUEST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	REQUEST_ID VARCHAR2(4000), 
	REQUEST_DATE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OW_CRVACC_REQUEST ***
 exec bpa.alter_policies('ERR$_OW_CRVACC_REQUEST');


COMMENT ON TABLE BARS.ERR$_OW_CRVACC_REQUEST IS 'DML Error Logging table for "OW_CRVACC_REQUEST"';
COMMENT ON COLUMN BARS.ERR$_OW_CRVACC_REQUEST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVACC_REQUEST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVACC_REQUEST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVACC_REQUEST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVACC_REQUEST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVACC_REQUEST.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVACC_REQUEST.REQUEST_ID IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVACC_REQUEST.REQUEST_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVACC_REQUEST.KF IS '';



PROMPT *** Create  grants  ERR$_OW_CRVACC_REQUEST ***
grant SELECT                                                                 on ERR$_OW_CRVACC_REQUEST to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OW_CRVACC_REQUEST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OW_CRVACC_REQUEST.sql =========**
PROMPT ===================================================================================== 
