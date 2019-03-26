

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_BORG_MESSAGE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_BORG_MESSAGE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_BORG_MESSAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_BORG_MESSAGE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	NOM_DOG VARCHAR2(4000), 
	DATE_DOG VARCHAR2(4000), 
	DATE_PLAT VARCHAR2(4000), 
	FILE_NAME VARCHAR2(4000), 
	DELETE_DATE VARCHAR2(4000), 
	DELETE_UID VARCHAR2(4000), 
	DOC_KIND VARCHAR2(4000), 
	DOC_TYPE VARCHAR2(4000), 
	BOUND_ID VARCHAR2(4000), 
	CONTROL_DATE VARCHAR2(4000), 
	APPROVE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_BORG_MESSAGE ***
 exec bpa.alter_policies('ERR$_CIM_BORG_MESSAGE');


COMMENT ON TABLE BARS.ERR$_CIM_BORG_MESSAGE IS 'DML Error Logging table for "CIM_BORG_MESSAGE"';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.NOM_DOG IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.DATE_DOG IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.DATE_PLAT IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.FILE_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.DELETE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.DELETE_UID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.DOC_KIND IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.DOC_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.BOUND_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.CONTROL_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_BORG_MESSAGE.APPROVE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_BORG_MESSAGE.sql =========***
PROMPT ===================================================================================== 