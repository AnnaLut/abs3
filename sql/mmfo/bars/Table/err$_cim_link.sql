

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_LINK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_LINK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_LINK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_LINK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	PAYMENT_ID VARCHAR2(4000), 
	FANTOM_ID VARCHAR2(4000), 
	VMD_ID VARCHAR2(4000), 
	ACT_ID VARCHAR2(4000), 
	S VARCHAR2(4000), 
	DELETE_DATE VARCHAR2(4000), 
	UID_DEL_JOURNAL VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	COMMENTS VARCHAR2(4000), 
	CREATE_DATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_LINK ***
 exec bpa.alter_policies('ERR$_CIM_LINK');


COMMENT ON TABLE BARS.ERR$_CIM_LINK IS 'DML Error Logging table for "CIM_LINK"';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.PAYMENT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.FANTOM_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.VMD_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.ACT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.S IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.DELETE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.UID_DEL_JOURNAL IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.COMMENTS IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_LINK.CREATE_DATE IS '';



PROMPT *** Create  grants  ERR$_CIM_LINK ***
grant SELECT                                                                 on ERR$_CIM_LINK   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIM_LINK   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_LINK.sql =========*** End ***
PROMPT ===================================================================================== 
