

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_ACTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_ACTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_ACTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_ACTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACT_ID VARCHAR2(4000), 
	DIRECT VARCHAR2(4000), 
	ACT_TYPE VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	BENEF_ID VARCHAR2(4000), 
	NUM VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	S VARCHAR2(4000), 
	ACT_DATE VARCHAR2(4000), 
	ALLOW_DATE VARCHAR2(4000), 
	CREATE_DATE VARCHAR2(4000), 
	CONTRACT_NUM VARCHAR2(4000), 
	CONTRACT_DATE VARCHAR2(4000), 
	BOUND_SUM VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	FILE_NAME VARCHAR2(4000), 
	FILE_DATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_ACTS ***
 exec bpa.alter_policies('ERR$_CIM_ACTS');


COMMENT ON TABLE BARS.ERR$_CIM_ACTS IS 'DML Error Logging table for "CIM_ACTS"';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.ACT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.DIRECT IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.ACT_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.BENEF_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.NUM IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.S IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.ACT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.ALLOW_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.CONTRACT_NUM IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.CONTRACT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.BOUND_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.FILE_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_ACTS.FILE_DATE IS '';



PROMPT *** Create  grants  ERR$_CIM_ACTS ***
grant SELECT                                                                 on ERR$_CIM_ACTS   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIM_ACTS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_ACTS.sql =========*** End ***
PROMPT ===================================================================================== 
