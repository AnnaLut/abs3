

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_INS_PARTNER_BRANCH_RNK.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_INS_PARTNER_BRANCH_RNK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_INS_PARTNER_BRANCH_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_INS_PARTNER_BRANCH_RNK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	PARTNER_ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	RNK VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_INS_PARTNER_BRANCH_RNK ***
 exec bpa.alter_policies('ERR$_INS_PARTNER_BRANCH_RNK');


COMMENT ON TABLE BARS.ERR$_INS_PARTNER_BRANCH_RNK IS 'DML Error Logging table for "INS_PARTNER_BRANCH_RNK"';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_BRANCH_RNK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_BRANCH_RNK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_BRANCH_RNK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_BRANCH_RNK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_BRANCH_RNK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_BRANCH_RNK.PARTNER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_BRANCH_RNK.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_BRANCH_RNK.RNK IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_INS_PARTNER_BRANCH_RNK.sql ======
PROMPT ===================================================================================== 
