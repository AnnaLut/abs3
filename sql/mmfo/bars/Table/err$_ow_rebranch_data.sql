

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OW_REBRANCH_DATA.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OW_REBRANCH_DATA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OW_REBRANCH_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OW_REBRANCH_DATA 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	FILEID VARCHAR2(4000), 
	IDN VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	STATE VARCHAR2(4000), 
	MSG VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OW_REBRANCH_DATA ***
 exec bpa.alter_policies('ERR$_OW_REBRANCH_DATA');


COMMENT ON TABLE BARS.ERR$_OW_REBRANCH_DATA IS 'DML Error Logging table for "OW_REBRANCH_DATA"';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.ID IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.FILEID IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.IDN IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.STATE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.MSG IS '';
COMMENT ON COLUMN BARS.ERR$_OW_REBRANCH_DATA.KF IS '';



PROMPT *** Create  grants  ERR$_OW_REBRANCH_DATA ***
grant SELECT                                                                 on ERR$_OW_REBRANCH_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OW_REBRANCH_DATA.sql =========***
PROMPT ===================================================================================== 
