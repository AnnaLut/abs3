

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SW_STMT_INFO.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SW_STMT_INFO ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SW_STMT_INFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SW_STMT_INFO 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	STATEMENT_NUMBER VARCHAR2(4000), 
	LAST_MESSAGE_REF VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SW_STMT_INFO ***
 exec bpa.alter_policies('ERR$_SW_STMT_INFO');


COMMENT ON TABLE BARS.ERR$_SW_STMT_INFO IS 'DML Error Logging table for "SW_STMT_INFO"';
COMMENT ON COLUMN BARS.ERR$_SW_STMT_INFO.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_STMT_INFO.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_STMT_INFO.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_STMT_INFO.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_STMT_INFO.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_STMT_INFO.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SW_STMT_INFO.STATEMENT_NUMBER IS '';
COMMENT ON COLUMN BARS.ERR$_SW_STMT_INFO.LAST_MESSAGE_REF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_STMT_INFO.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SW_STMT_INFO.sql =========*** End
PROMPT ===================================================================================== 
