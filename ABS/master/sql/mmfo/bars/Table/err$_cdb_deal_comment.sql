

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CDB_DEAL_COMMENT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CDB_DEAL_COMMENT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CDB_DEAL_COMMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CDB_DEAL_COMMENT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	COMMENT_DATE VARCHAR2(4000), 
	COMMENT_MESSAGE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CDB_DEAL_COMMENT ***
 exec bpa.alter_policies('ERR$_CDB_DEAL_COMMENT');


COMMENT ON TABLE BARS.ERR$_CDB_DEAL_COMMENT IS 'DML Error Logging table for "CDB_DEAL_COMMENT"';
COMMENT ON COLUMN BARS.ERR$_CDB_DEAL_COMMENT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CDB_DEAL_COMMENT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CDB_DEAL_COMMENT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CDB_DEAL_COMMENT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CDB_DEAL_COMMENT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CDB_DEAL_COMMENT.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CDB_DEAL_COMMENT.COMMENT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CDB_DEAL_COMMENT.COMMENT_MESSAGE IS '';



PROMPT *** Create  grants  ERR$_CDB_DEAL_COMMENT ***
grant SELECT                                                                 on ERR$_CDB_DEAL_COMMENT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CDB_DEAL_COMMENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CDB_DEAL_COMMENT.sql =========***
PROMPT ===================================================================================== 
