

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_TAG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_TAG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_TAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_TAG 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TAG VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	TAGTYPE VARCHAR2(4000), 
	TABLE_NAME VARCHAR2(4000), 
	TYPE VARCHAR2(4000), 
	NSISQLWHERE VARCHAR2(4000), 
	EDIT_IN_FORM VARCHAR2(4000), 
	NOT_TO_EDIT VARCHAR2(4000), 
	CODE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_TAG ***
 exec bpa.alter_policies('ERR$_CC_TAG');


COMMENT ON TABLE BARS.ERR$_CC_TAG IS 'DML Error Logging table for "CC_TAG"';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.TAGTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.NSISQLWHERE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.EDIT_IN_FORM IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.NOT_TO_EDIT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_TAG.CODE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_TAG.sql =========*** End *** =
PROMPT ===================================================================================== 
