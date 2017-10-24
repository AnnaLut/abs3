

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SW_950_ARCH.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SW_950_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SW_950_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SW_950_ARCH 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SWREF VARCHAR2(4000), 
	NOSTRO_ACC VARCHAR2(4000), 
	NUM VARCHAR2(4000), 
	STMT_DATE VARCHAR2(4000), 
	OBAL VARCHAR2(4000), 
	CBAL VARCHAR2(4000), 
	ADD_INFO VARCHAR2(4000), 
	DONE VARCHAR2(4000), 
	STMT_BDATE VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SW_950_ARCH ***
 exec bpa.alter_policies('ERR$_SW_950_ARCH');


COMMENT ON TABLE BARS.ERR$_SW_950_ARCH IS 'DML Error Logging table for "SW_950_ARCH"';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.SWREF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.NOSTRO_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.NUM IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.STMT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.OBAL IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.CBAL IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.ADD_INFO IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.DONE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.STMT_BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.KV IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950_ARCH.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SW_950_ARCH.sql =========*** End 
PROMPT ===================================================================================== 
