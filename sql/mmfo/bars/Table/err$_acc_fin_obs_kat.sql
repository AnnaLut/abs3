

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_FIN_OBS_KAT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ACC_FIN_OBS_KAT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ACC_FIN_OBS_KAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ACC_FIN_OBS_KAT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	FIN VARCHAR2(4000), 
	OBS VARCHAR2(4000), 
	KAT VARCHAR2(4000), 
	K VARCHAR2(4000), 
	PR VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ACC_FIN_OBS_KAT ***
 exec bpa.alter_policies('ERR$_ACC_FIN_OBS_KAT');


COMMENT ON TABLE BARS.ERR$_ACC_FIN_OBS_KAT IS 'DML Error Logging table for "ACC_FIN_OBS_KAT"';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.FIN IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.OBS IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.KAT IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.K IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_FIN_OBS_KAT.PR IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_FIN_OBS_KAT.sql =========*** 
PROMPT ===================================================================================== 
