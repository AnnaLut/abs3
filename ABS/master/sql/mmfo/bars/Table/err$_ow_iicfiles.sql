

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OW_IICFILES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OW_IICFILES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OW_IICFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OW_IICFILES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FILE_NAME VARCHAR2(4000), 
	FILE_DATE VARCHAR2(4000), 
	FILE_N VARCHAR2(4000), 
	FILE_S VARCHAR2(4000), 
	TICK_NAME VARCHAR2(4000), 
	TICK_DATE VARCHAR2(4000), 
	TICK_STATUS VARCHAR2(4000), 
	TICK_ACCEPT_REC VARCHAR2(4000), 
	TICK_REJECT_REC VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OW_IICFILES ***
 exec bpa.alter_policies('ERR$_OW_IICFILES');


COMMENT ON TABLE BARS.ERR$_OW_IICFILES IS 'DML Error Logging table for "OW_IICFILES"';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.FILE_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.FILE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.FILE_N IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.FILE_S IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.TICK_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.TICK_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.TICK_STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.TICK_ACCEPT_REC IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.TICK_REJECT_REC IS '';
COMMENT ON COLUMN BARS.ERR$_OW_IICFILES.KF IS '';



PROMPT *** Create  grants  ERR$_OW_IICFILES ***
grant SELECT                                                                 on ERR$_OW_IICFILES to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OW_IICFILES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OW_IICFILES.sql =========*** End 
PROMPT ===================================================================================== 
