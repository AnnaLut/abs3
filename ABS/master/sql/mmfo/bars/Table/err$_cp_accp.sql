

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_ACCP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_ACCP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_ACCP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_ACCP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	ACC VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_ACCP ***
 exec bpa.alter_policies('ERR$_CP_ACCP');


COMMENT ON TABLE BARS.ERR$_CP_ACCP IS 'DML Error Logging table for "CP_ACCP"';
COMMENT ON COLUMN BARS.ERR$_CP_ACCP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCP.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCP.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCP.ORA_ERR_OPTYP$ IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_ACCP.sql =========*** End *** 
PROMPT ===================================================================================== 
