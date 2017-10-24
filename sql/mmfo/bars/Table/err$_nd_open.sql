

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ND_OPEN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ND_OPEN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ND_OPEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ND_OPEN 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ND_OPEN ***
 exec bpa.alter_policies('ERR$_ND_OPEN');


COMMENT ON TABLE BARS.ERR$_ND_OPEN IS 'DML Error Logging table for "ND_OPEN"';
COMMENT ON COLUMN BARS.ERR$_ND_OPEN.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_OPEN.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_OPEN.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_OPEN.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_OPEN.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_OPEN.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_ND_OPEN.ND IS '';
COMMENT ON COLUMN BARS.ERR$_ND_OPEN.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ND_OPEN.sql =========*** End *** 
PROMPT ===================================================================================== 
