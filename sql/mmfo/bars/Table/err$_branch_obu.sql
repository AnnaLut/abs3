

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BRANCH_OBU.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BRANCH_OBU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BRANCH_OBU ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BRANCH_OBU 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BRANCH VARCHAR2(4000), 
	RID VARCHAR2(4000), 
	RU VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	OPENDATE VARCHAR2(4000), 
	CLOSEDATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BRANCH_OBU ***
 exec bpa.alter_policies('ERR$_BRANCH_OBU');


COMMENT ON TABLE BARS.ERR$_BRANCH_OBU IS 'DML Error Logging table for "BRANCH_OBU"';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.RID IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.RU IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.OPENDATE IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_OBU.CLOSEDATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BRANCH_OBU.sql =========*** End *
PROMPT ===================================================================================== 
