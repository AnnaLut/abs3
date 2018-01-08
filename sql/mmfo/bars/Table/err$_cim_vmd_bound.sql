

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_VMD_BOUND.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_VMD_BOUND ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_VMD_BOUND ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_VMD_BOUND 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BOUND_ID VARCHAR2(4000), 
	DIRECT VARCHAR2(4000), 
	VMD_ID VARCHAR2(4000), 
	CONTR_ID VARCHAR2(4000), 
	S_VT VARCHAR2(4000), 
	RATE_VK VARCHAR2(4000), 
	S_VK VARCHAR2(4000), 
	COMMENTS VARCHAR2(4000), 
	JOURNAL_NUM VARCHAR2(4000), 
	JOURNAL_ID VARCHAR2(4000), 
	CREATE_DATE VARCHAR2(4000), 
	MODIFY_DATE VARCHAR2(4000), 
	DELETE_DATE VARCHAR2(4000), 
	UID_DEL_BOUND VARCHAR2(4000), 
	UID_DEL_JOURNAL VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	BORG_REASON VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_VMD_BOUND ***
 exec bpa.alter_policies('ERR$_CIM_VMD_BOUND');


COMMENT ON TABLE BARS.ERR$_CIM_VMD_BOUND IS 'DML Error Logging table for "CIM_VMD_BOUND"';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.BOUND_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.DIRECT IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.VMD_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.CONTR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.S_VT IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.RATE_VK IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.S_VK IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.COMMENTS IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.JOURNAL_NUM IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.JOURNAL_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.MODIFY_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.DELETE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.UID_DEL_BOUND IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.UID_DEL_JOURNAL IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_VMD_BOUND.BORG_REASON IS '';



PROMPT *** Create  grants  ERR$_CIM_VMD_BOUND ***
grant SELECT                                                                 on ERR$_CIM_VMD_BOUND to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIM_VMD_BOUND to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_VMD_BOUND.sql =========*** En
PROMPT ===================================================================================== 
