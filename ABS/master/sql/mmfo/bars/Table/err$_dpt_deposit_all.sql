

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_DEPOSIT_ALL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_DEPOSIT_ALL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_DEPOSIT_ALL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_DEPOSIT_ALL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DEPOSIT_ID VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_DEPOSIT_ALL ***
 exec bpa.alter_policies('ERR$_DPT_DEPOSIT_ALL');


COMMENT ON TABLE BARS.ERR$_DPT_DEPOSIT_ALL IS 'DML Error Logging table for "DPT_DEPOSIT_ALL"';
COMMENT ON COLUMN BARS.ERR$_DPT_DEPOSIT_ALL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_DEPOSIT_ALL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_DEPOSIT_ALL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_DEPOSIT_ALL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_DEPOSIT_ALL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_DEPOSIT_ALL.DEPOSIT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_DEPOSIT_ALL.KF IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_DEPOSIT_ALL.BRANCH IS '';



PROMPT *** Create  grants  ERR$_DPT_DEPOSIT_ALL ***
grant SELECT                                                                 on ERR$_DPT_DEPOSIT_ALL to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_DEPOSIT_ALL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_DEPOSIT_ALL.sql =========*** 
PROMPT ===================================================================================== 
