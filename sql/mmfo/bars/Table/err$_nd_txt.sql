

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ND_TXT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ND_TXT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ND_TXT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ND_TXT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ND_TXT ***
 exec bpa.alter_policies('ERR$_ND_TXT');


COMMENT ON TABLE BARS.ERR$_ND_TXT IS 'DML Error Logging table for "ND_TXT"';
COMMENT ON COLUMN BARS.ERR$_ND_TXT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT.ND IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_ND_TXT.KF IS '';



PROMPT *** Create  grants  ERR$_ND_TXT ***
grant SELECT                                                                 on ERR$_ND_TXT     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ND_TXT.sql =========*** End *** =
PROMPT ===================================================================================== 
