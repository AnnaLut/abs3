

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_BALANCE_CHANGES_UPDAT.sql ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ACC_BALANCE_CHANGES_UPDAT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ACC_BALANCE_CHANGES_UPDAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	CHANGE_TIME VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	OSTC VARCHAR2(4000), 
	DOS_DELTA VARCHAR2(4000), 
	KOS_DELTA VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	NLSB VARCHAR2(4000), 
	NLSA VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ACC_BALANCE_CHANGES_UPDAT ***
 exec bpa.alter_policies('ERR$_ACC_BALANCE_CHANGES_UPDAT');


COMMENT ON TABLE BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT IS 'DML Error Logging table for "ACC_BALANCE_CHANGES_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.OSTC IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.DOS_DELTA IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.KOS_DELTA IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.REF IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.TT IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.NLSB IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.NLSA IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.KF IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_BALANCE_CHANGES_UPDAT.ORA_ERR_ROWID$ IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_BALANCE_CHANGES_UPDAT.sql ===
PROMPT ===================================================================================== 