

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_LINES_I.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_LINES_I ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_LINES_I ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_LINES_I 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FN VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	N VARCHAR2(4000), 
	ERR VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_LINES_I ***
 exec bpa.alter_policies('ERR$_LINES_I');


COMMENT ON TABLE BARS.ERR$_LINES_I IS 'DML Error Logging table for "LINES_I"';
COMMENT ON COLUMN BARS.ERR$_LINES_I.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_I.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_I.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_I.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_I.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_I.FN IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_I.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_I.N IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_I.ERR IS '';
COMMENT ON COLUMN BARS.ERR$_LINES_I.KF IS '';



PROMPT *** Create  grants  ERR$_LINES_I ***
grant SELECT                                                                 on ERR$_LINES_I    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_LINES_I.sql =========*** End *** 
PROMPT ===================================================================================== 
