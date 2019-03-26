

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_SYNC_QUEUE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SKRYNKA_SYNC_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SKRYNKA_SYNC_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SKRYNKA_SYNC_QUEUE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	SYNC_TYPE VARCHAR2(4000), 
	OBJ_ID VARCHAR2(4000), 
	MSG_STATUS VARCHAR2(4000), 
	MSG_TIME VARCHAR2(4000), 
	ERR_TEXT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SKRYNKA_SYNC_QUEUE ***
 exec bpa.alter_policies('ERR$_SKRYNKA_SYNC_QUEUE');


COMMENT ON TABLE BARS.ERR$_SKRYNKA_SYNC_QUEUE IS 'DML Error Logging table for "SKRYNKA_SYNC_QUEUE"';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.ID IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.SYNC_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.OBJ_ID IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.MSG_STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.MSG_TIME IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_SYNC_QUEUE.ERR_TEXT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_SYNC_QUEUE.sql =========*
PROMPT ===================================================================================== 