

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_989917_REF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_989917_REF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_989917_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_989917_REF 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF1 VARCHAR2(4000), 
	REF2 VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_989917_REF ***
 exec bpa.alter_policies('ERR$_CC_989917_REF');


COMMENT ON TABLE BARS.ERR$_CC_989917_REF IS 'DML Error Logging table for "CC_989917_REF"';
COMMENT ON COLUMN BARS.ERR$_CC_989917_REF.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_989917_REF.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_989917_REF.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_989917_REF.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_989917_REF.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_989917_REF.REF1 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_989917_REF.REF2 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_989917_REF.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_989917_REF.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CC_989917_REF.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_989917_REF.sql =========*** En
PROMPT ===================================================================================== 
