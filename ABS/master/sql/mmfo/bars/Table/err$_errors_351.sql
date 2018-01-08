

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ERRORS_351.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ERRORS_351 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ERRORS_351 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ERRORS_351 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	CUSTTYPE VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	TIP VARCHAR2(4000), 
	ERROR_TXT VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ERRORS_351 ***
 exec bpa.alter_policies('ERR$_ERRORS_351');


COMMENT ON TABLE BARS.ERR$_ERRORS_351 IS 'DML Error Logging table for "ERRORS_351"';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.ND IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.KV IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.TIP IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.ERROR_TXT IS '';
COMMENT ON COLUMN BARS.ERR$_ERRORS_351.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ERRORS_351.sql =========*** End *
PROMPT ===================================================================================== 
