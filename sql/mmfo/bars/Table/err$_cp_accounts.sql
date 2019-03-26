

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_ACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_ACCOUNTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CP_REF VARCHAR2(4000), 
	CP_ACCTYPE VARCHAR2(4000), 
	CP_ACC VARCHAR2(4000), 
	OSTC VARCHAR2(4000), 
	OSTCR VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_ACCOUNTS ***
 exec bpa.alter_policies('ERR$_CP_ACCOUNTS');


COMMENT ON TABLE BARS.ERR$_CP_ACCOUNTS IS 'DML Error Logging table for "CP_ACCOUNTS"';
COMMENT ON COLUMN BARS.ERR$_CP_ACCOUNTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCOUNTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCOUNTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCOUNTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCOUNTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCOUNTS.CP_REF IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCOUNTS.CP_ACCTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCOUNTS.CP_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCOUNTS.OSTC IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ACCOUNTS.OSTCR IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_ACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 