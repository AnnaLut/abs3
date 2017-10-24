

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_EX_KL351.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_EX_KL351 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_EX_KL351 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_EX_KL351 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	PAWN VARCHAR2(4000), 
	KL_351 VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_EX_KL351 ***
 exec bpa.alter_policies('ERR$_EX_KL351');


COMMENT ON TABLE BARS.ERR$_EX_KL351 IS 'DML Error Logging table for "EX_KL351"';
COMMENT ON COLUMN BARS.ERR$_EX_KL351.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_EX_KL351.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EX_KL351.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_EX_KL351.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_EX_KL351.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EX_KL351.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_EX_KL351.PAWN IS '';
COMMENT ON COLUMN BARS.ERR$_EX_KL351.KL_351 IS '';
COMMENT ON COLUMN BARS.ERR$_EX_KL351.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_EX_KL351.sql =========*** End ***
PROMPT ===================================================================================== 
