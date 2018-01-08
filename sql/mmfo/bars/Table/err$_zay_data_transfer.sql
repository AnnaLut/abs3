

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_DATA_TRANSFER.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAY_DATA_TRANSFER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAY_DATA_TRANSFER ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAY_DATA_TRANSFER 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	REQ_ID VARCHAR2(4000), 
	URL VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	TRANSFER_TYPE VARCHAR2(4000), 
	TRANSFER_DATE VARCHAR2(4000), 
	TRANSFER_RESULT VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAY_DATA_TRANSFER ***
 exec bpa.alter_policies('ERR$_ZAY_DATA_TRANSFER');


COMMENT ON TABLE BARS.ERR$_ZAY_DATA_TRANSFER IS 'DML Error Logging table for "ZAY_DATA_TRANSFER"';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.REQ_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.URL IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.TRANSFER_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.TRANSFER_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.TRANSFER_RESULT IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DATA_TRANSFER.KF IS '';



PROMPT *** Create  grants  ERR$_ZAY_DATA_TRANSFER ***
grant SELECT                                                                 on ERR$_ZAY_DATA_TRANSFER to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ZAY_DATA_TRANSFER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_DATA_TRANSFER.sql =========**
PROMPT ===================================================================================== 
