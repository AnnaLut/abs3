

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_KL_FE9.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_KL_FE9 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_KL_FE9 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_KL_FE9 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NLSD VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	NLSK VARCHAR2(4000), 
	D060 VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	PR_DEL VARCHAR2(4000), 
	OB22 VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_KL_FE9 ***
 exec bpa.alter_policies('ERR$_KL_FE9');


COMMENT ON TABLE BARS.ERR$_KL_FE9 IS 'DML Error Logging table for "KL_FE9"';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.NLSD IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.KV IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.NLSK IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.D060 IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.TT IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.PR_DEL IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.OB22 IS '';
COMMENT ON COLUMN BARS.ERR$_KL_FE9.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_KL_FE9.sql =========*** End *** =
PROMPT ===================================================================================== 
