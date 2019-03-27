

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SKRYNKA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SKRYNKA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SKRYNKA 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	O_SK VARCHAR2(4000), 
	N_SK VARCHAR2(4000), 
	SNUM VARCHAR2(4000), 
	KEYUSED VARCHAR2(4000), 
	ISP_MO VARCHAR2(4000), 
	KEYNUMBER VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SKRYNKA ***
 exec bpa.alter_policies('ERR$_SKRYNKA');


COMMENT ON TABLE BARS.ERR$_SKRYNKA IS 'DML Error Logging table for "SKRYNKA"';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.O_SK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.N_SK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.SNUM IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.KEYUSED IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.ISP_MO IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.KEYNUMBER IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA.sql =========*** End *** 
PROMPT ===================================================================================== 