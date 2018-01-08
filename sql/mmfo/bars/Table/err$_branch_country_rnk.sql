

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BRANCH_COUNTRY_RNK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BRANCH_COUNTRY_RNK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BRANCH_COUNTRY_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BRANCH_COUNTRY_RNK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BRANCH VARCHAR2(4000), 
	COUNTRY VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	RNK VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BRANCH_COUNTRY_RNK ***
 exec bpa.alter_policies('ERR$_BRANCH_COUNTRY_RNK');


COMMENT ON TABLE BARS.ERR$_BRANCH_COUNTRY_RNK IS 'DML Error Logging table for "BRANCH_COUNTRY_RNK"';
COMMENT ON COLUMN BARS.ERR$_BRANCH_COUNTRY_RNK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_COUNTRY_RNK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_COUNTRY_RNK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_COUNTRY_RNK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_COUNTRY_RNK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_COUNTRY_RNK.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_COUNTRY_RNK.COUNTRY IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_COUNTRY_RNK.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_BRANCH_COUNTRY_RNK.RNK IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BRANCH_COUNTRY_RNK.sql =========*
PROMPT ===================================================================================== 
