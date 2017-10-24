

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CM_CREDITS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CM_CREDITS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CM_CREDITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CM_CREDITS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	DCLASS VARCHAR2(4000), 
	DVKR VARCHAR2(4000), 
	DSUM VARCHAR2(4000), 
	DDATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CM_CREDITS ***
 exec bpa.alter_policies('ERR$_CM_CREDITS');


COMMENT ON TABLE BARS.ERR$_CM_CREDITS IS 'DML Error Logging table for "CM_CREDITS"';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.DCLASS IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.DVKR IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.DSUM IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CREDITS.DDATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CM_CREDITS.sql =========*** End *
PROMPT ===================================================================================== 
