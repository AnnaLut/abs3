

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OPERW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OPERW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OPERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OPERW 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OPERW ***
 exec bpa.alter_policies('ERR$_OPERW');


COMMENT ON TABLE BARS.ERR$_OPERW IS 'DML Error Logging table for "OPERW"';
COMMENT ON COLUMN BARS.ERR$_OPERW.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERW.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERW.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERW.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERW.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OPERW.REF IS '';
COMMENT ON COLUMN BARS.ERR$_OPERW.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_OPERW.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_OPERW.KF IS '';



PROMPT *** Create  grants  ERR$_OPERW ***
grant SELECT                                                                 on ERR$_OPERW      to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OPERW      to BARS_DM;
grant SELECT                                                                 on ERR$_OPERW      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OPERW.sql =========*** End *** ==
PROMPT ===================================================================================== 
