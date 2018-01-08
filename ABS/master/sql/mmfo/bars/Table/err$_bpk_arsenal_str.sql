

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_ARSENAL_STR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BPK_ARSENAL_STR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BPK_ARSENAL_STR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BPK_ARSENAL_STR 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	OB22 VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BPK_ARSENAL_STR ***
 exec bpa.alter_policies('ERR$_BPK_ARSENAL_STR');


COMMENT ON TABLE BARS.ERR$_BPK_ARSENAL_STR IS 'DML Error Logging table for "BPK_ARSENAL_STR"';
COMMENT ON COLUMN BARS.ERR$_BPK_ARSENAL_STR.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_ARSENAL_STR.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_ARSENAL_STR.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_ARSENAL_STR.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_ARSENAL_STR.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_ARSENAL_STR.ID IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_ARSENAL_STR.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_ARSENAL_STR.OB22 IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_ARSENAL_STR.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_ARSENAL_STR.sql =========*** 
PROMPT ===================================================================================== 
