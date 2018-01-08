

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_EBK_CLIENT_ANALYSIS_ERROR.sql ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_EBK_CLIENT_ANALYSIS_ERROR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_EBK_CLIENT_ANALYSIS_ERROR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BATCHID VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	CODE VARCHAR2(4000), 
	MSG VARCHAR2(4000), 
	INSERT_DATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_EBK_CLIENT_ANALYSIS_ERROR ***
 exec bpa.alter_policies('ERR$_EBK_CLIENT_ANALYSIS_ERROR');


COMMENT ON TABLE BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR IS 'DML Error Logging table for "EBK_CLIENT_ANALYSIS_ERRORS"';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.BATCHID IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.KF IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.CODE IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.MSG IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_CLIENT_ANALYSIS_ERROR.INSERT_DATE IS '';



PROMPT *** Create  grants  ERR$_EBK_CLIENT_ANALYSIS_ERROR ***
grant SELECT                                                                 on ERR$_EBK_CLIENT_ANALYSIS_ERROR to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_EBK_CLIENT_ANALYSIS_ERROR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_EBK_CLIENT_ANALYSIS_ERROR.sql ===
PROMPT ===================================================================================== 
