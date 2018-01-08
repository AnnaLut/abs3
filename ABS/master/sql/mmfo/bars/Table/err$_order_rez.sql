

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ORDER_REZ.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ORDER_REZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ORDER_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ORDER_REZ 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	GRP VARCHAR2(4000), 
	DK VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	NLSA VARCHAR2(4000), 
	NLSB VARCHAR2(4000), 
	S VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ORDER_REZ ***
 exec bpa.alter_policies('ERR$_ORDER_REZ');


COMMENT ON TABLE BARS.ERR$_ORDER_REZ IS 'DML Error Logging table for "ORDER_REZ"';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.GRP IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.DK IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.KV IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.NLSA IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.NLSB IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.S IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_ORDER_REZ.KF IS '';



PROMPT *** Create  grants  ERR$_ORDER_REZ ***
grant SELECT                                                                 on ERR$_ORDER_REZ  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ORDER_REZ  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ORDER_REZ.sql =========*** End **
PROMPT ===================================================================================== 
