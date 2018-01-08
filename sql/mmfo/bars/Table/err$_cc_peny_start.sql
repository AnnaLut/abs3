

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_PENY_START.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_PENY_START ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_PENY_START ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_PENY_START 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	OSTC VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	ACC_SN8 VARCHAR2(4000), 
	NLS_SN8 VARCHAR2(4000), 
	IR VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_PENY_START ***
 exec bpa.alter_policies('ERR$_CC_PENY_START');


COMMENT ON TABLE BARS.ERR$_CC_PENY_START IS 'DML Error Logging table for "CC_PENY_START"';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.OSTC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.ACC_SN8 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.NLS_SN8 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PENY_START.IR IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_PENY_START.sql =========*** En
PROMPT ===================================================================================== 
