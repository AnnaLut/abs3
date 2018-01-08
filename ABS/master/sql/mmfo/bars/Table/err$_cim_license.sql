

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_LICENSE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_LICENSE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_LICENSE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_LICENSE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	LICENSE_ID VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	NUM VARCHAR2(4000), 
	TYPE VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	S VARCHAR2(4000), 
	BEGIN_DATE VARCHAR2(4000), 
	END_DATE VARCHAR2(4000), 
	COMMENTS VARCHAR2(4000), 
	DELETE_DATE VARCHAR2(4000), 
	DELETE_UID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_LICENSE ***
 exec bpa.alter_policies('ERR$_CIM_LICENSE');


COMMENT ON TABLE BARS.ERR$_CIM_LICENSE IS 'DML Error Logging table for "CIM_LICENSE"';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.COMMENTS IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.DELETE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.DELETE_UID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.LICENSE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.NUM IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.S IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.BEGIN_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LICENSE.END_DATE IS '';



PROMPT *** Create  grants  ERR$_CIM_LICENSE ***
grant SELECT                                                                 on ERR$_CIM_LICENSE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIM_LICENSE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_LICENSE.sql =========*** End 
PROMPT ===================================================================================== 
