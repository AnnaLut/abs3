

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_E_DEAL$BASE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_E_DEAL$BASE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_E_DEAL$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_E_DEAL$BASE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	CC_ID VARCHAR2(4000), 
	SDATE VARCHAR2(4000), 
	WDATE VARCHAR2(4000), 
	USER_ID VARCHAR2(4000), 
	SA VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	ACC26 VARCHAR2(4000), 
	ACC36 VARCHAR2(4000), 
	ACCD VARCHAR2(4000), 
	ACCP VARCHAR2(4000), 
	NDI VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_E_DEAL$BASE ***
 exec bpa.alter_policies('ERR$_E_DEAL$BASE');


COMMENT ON TABLE BARS.ERR$_E_DEAL$BASE IS 'DML Error Logging table for "E_DEAL$BASE"';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.ND IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.CC_ID IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.SDATE IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.WDATE IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.USER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.SA IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.ACC26 IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.ACC36 IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.ACCD IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.ACCP IS '';
COMMENT ON COLUMN BARS.ERR$_E_DEAL$BASE.NDI IS '';



PROMPT *** Create  grants  ERR$_E_DEAL$BASE ***
grant SELECT                                                                 on ERR$_E_DEAL$BASE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_E_DEAL$BASE.sql =========*** End 
PROMPT ===================================================================================== 
