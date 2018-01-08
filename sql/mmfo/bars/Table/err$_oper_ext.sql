

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OPER_EXT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OPER_EXT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OPER_EXT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OPER_EXT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	PAY_BANKDATE VARCHAR2(4000), 
	PAY_CALDATE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OPER_EXT ***
 exec bpa.alter_policies('ERR$_OPER_EXT');


COMMENT ON TABLE BARS.ERR$_OPER_EXT IS 'DML Error Logging table for "OPER_EXT"';
COMMENT ON COLUMN BARS.ERR$_OPER_EXT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_EXT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_EXT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_EXT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_EXT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_EXT.REF IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_EXT.KF IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_EXT.PAY_BANKDATE IS '';
COMMENT ON COLUMN BARS.ERR$_OPER_EXT.PAY_CALDATE IS '';



PROMPT *** Create  grants  ERR$_OPER_EXT ***
grant SELECT                                                                 on ERR$_OPER_EXT   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OPER_EXT   to BARS_DM;
grant SELECT                                                                 on ERR$_OPER_EXT   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OPER_EXT.sql =========*** End ***
PROMPT ===================================================================================== 
