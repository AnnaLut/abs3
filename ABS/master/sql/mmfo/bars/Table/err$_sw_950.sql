

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SW_950.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SW_950 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SW_950 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SW_950 
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




PROMPT *** ALTER_POLICIES to ERR$_SW_950 ***
 exec bpa.alter_policies('ERR$_SW_950');


COMMENT ON TABLE BARS.ERR$_SW_950 IS 'DML Error Logging table for "SW_950"';
COMMENT ON COLUMN BARS.ERR$_SW_950.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.SWREF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.NOSTRO_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.NUM IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.STMT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.OBAL IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.CBAL IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.ADD_INFO IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.DONE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.STMT_BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.KV IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SW_950.sql =========*** End *** =
PROMPT ===================================================================================== 
