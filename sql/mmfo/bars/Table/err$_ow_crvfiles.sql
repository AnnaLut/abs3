

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OW_CRVFILES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OW_CRVFILES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OW_CRVFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OW_CRVFILES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	FILE_NAME VARCHAR2(4000), 
	FILE_DATE VARCHAR2(4000), 
	FILE_N VARCHAR2(4000), 
	ERR_CODE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OW_CRVFILES ***
 exec bpa.alter_policies('ERR$_OW_CRVFILES');


COMMENT ON TABLE BARS.ERR$_OW_CRVFILES IS 'DML Error Logging table for "OW_CRVFILES"';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.ID IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.FILE_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.FILE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.FILE_N IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.ERR_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_CRVFILES.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OW_CRVFILES.sql =========*** End 
PROMPT ===================================================================================== 
