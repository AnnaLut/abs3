

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_REZ_PROTOCOL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_REZ_PROTOCOL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_REZ_PROTOCOL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_REZ_PROTOCOL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	USERID VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	DAT_BANK VARCHAR2(4000), 
	DAT_SYS VARCHAR2(4000), 
	DAT_OTCN VARCHAR2(4000), 
	CRC VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_REZ_PROTOCOL ***
 exec bpa.alter_policies('ERR$_REZ_PROTOCOL');


COMMENT ON TABLE BARS.ERR$_REZ_PROTOCOL IS 'DML Error Logging table for "REZ_PROTOCOL"';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.DAT_BANK IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.DAT_SYS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.DAT_OTCN IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.CRC IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.REF IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_PROTOCOL.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_REZ_PROTOCOL.sql =========*** End
PROMPT ===================================================================================== 
