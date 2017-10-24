

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_TIP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SKRYNKA_TIP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SKRYNKA_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SKRYNKA_TIP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	O_SK VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	S VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	ETALON_ID VARCHAR2(4000), 
	CELL_COUNT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SKRYNKA_TIP ***
 exec bpa.alter_policies('ERR$_SKRYNKA_TIP');


COMMENT ON TABLE BARS.ERR$_SKRYNKA_TIP IS 'DML Error Logging table for "SKRYNKA_TIP"';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.O_SK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.S IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.KF IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.ETALON_ID IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_TIP.CELL_COUNT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_TIP.sql =========*** End 
PROMPT ===================================================================================== 
