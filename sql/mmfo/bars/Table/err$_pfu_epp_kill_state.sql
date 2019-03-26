

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PFU_EPP_KILL_STATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PFU_EPP_KILL_STATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PFU_EPP_KILL_STATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PFU_EPP_KILL_STATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID_STATE VARCHAR2(4000), 
	NAME VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PFU_EPP_KILL_STATE ***
 exec bpa.alter_policies('ERR$_PFU_EPP_KILL_STATE');


COMMENT ON TABLE BARS.ERR$_PFU_EPP_KILL_STATE IS 'DML Error Logging table for "PFU_EPP_KILL_STATE"';
COMMENT ON COLUMN BARS.ERR$_PFU_EPP_KILL_STATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_EPP_KILL_STATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_EPP_KILL_STATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_EPP_KILL_STATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_EPP_KILL_STATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_EPP_KILL_STATE.ID_STATE IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_EPP_KILL_STATE.NAME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PFU_EPP_KILL_STATE.sql =========*
PROMPT ===================================================================================== 