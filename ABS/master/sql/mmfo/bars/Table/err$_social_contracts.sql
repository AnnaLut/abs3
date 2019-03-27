

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SOCIAL_CONTRACTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SOCIAL_CONTRACTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SOCIAL_CONTRACTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SOCIAL_CONTRACTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CONTRACT_ID VARCHAR2(4000), 
	TYPE_ID VARCHAR2(4000), 
	AGENCY_ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	CONTRACT_NUM VARCHAR2(4000), 
	CONTRACT_DATE VARCHAR2(4000), 
	CLOSED_DATE VARCHAR2(4000), 
	CARD_ACCOUNT VARCHAR2(4000), 
	PENSION_NUM VARCHAR2(4000), 
	DETAILS VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SOCIAL_CONTRACTS ***
 exec bpa.alter_policies('ERR$_SOCIAL_CONTRACTS');


COMMENT ON TABLE BARS.ERR$_SOCIAL_CONTRACTS IS 'DML Error Logging table for "SOCIAL_CONTRACTS"';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.CONTRACT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.TYPE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.AGENCY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.CONTRACT_NUM IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.CONTRACT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.CLOSED_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.CARD_ACCOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.PENSION_NUM IS '';
COMMENT ON COLUMN BARS.ERR$_SOCIAL_CONTRACTS.DETAILS IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SOCIAL_CONTRACTS.sql =========***
PROMPT ===================================================================================== 