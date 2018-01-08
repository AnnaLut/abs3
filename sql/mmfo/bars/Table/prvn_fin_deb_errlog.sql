

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_FIN_DEB_ERRLOG.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_FIN_DEB_ERRLOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_FIN_DEB_ERRLOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_FIN_DEB_ERRLOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_FIN_DEB_ERRLOG 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC_SS VARCHAR2(4000), 
	ACC_SP VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	AGRM_ID VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_FIN_DEB_ERRLOG ***
 exec bpa.alter_policies('PRVN_FIN_DEB_ERRLOG');


COMMENT ON TABLE BARS.PRVN_FIN_DEB_ERRLOG IS 'DML Error Logging table for "PRVN_FIN_DEB"';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ACC_SS IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ACC_SP IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.KF IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.AGRM_ID IS '';



PROMPT *** Create  grants  PRVN_FIN_DEB_ERRLOG ***
grant SELECT                                                                 on PRVN_FIN_DEB_ERRLOG to BARSREADER_ROLE;
grant SELECT                                                                 on PRVN_FIN_DEB_ERRLOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_FIN_DEB_ERRLOG.sql =========*** E
PROMPT ===================================================================================== 
