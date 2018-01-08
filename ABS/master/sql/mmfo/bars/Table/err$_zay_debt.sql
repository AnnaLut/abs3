

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_DEBT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAY_DEBT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAY_DEBT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAY_DEBT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	REFD VARCHAR2(4000), 
	TIP VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	ZAY_SUM VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAY_DEBT ***
 exec bpa.alter_policies('ERR$_ZAY_DEBT');


COMMENT ON TABLE BARS.ERR$_ZAY_DEBT IS 'DML Error Logging table for "ZAY_DEBT"';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.REF IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.REFD IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.TIP IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.ZAY_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_DEBT.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_DEBT.sql =========*** End ***
PROMPT ===================================================================================== 
