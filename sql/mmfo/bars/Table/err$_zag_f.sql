

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAG_F.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAG_F ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAG_F ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAG_F 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FN VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	N VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	DATK VARCHAR2(4000), 
	ERR VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	FNK VARCHAR2(4000), 
	TXTK VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAG_F ***
 exec bpa.alter_policies('ERR$_ZAG_F');


COMMENT ON TABLE BARS.ERR$_ZAG_F IS 'DML Error Logging table for "ZAG_F"';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.FN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.N IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.DATK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.ERR IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.KF IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.FNK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_F.TXTK IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAG_F.sql =========*** End *** ==
PROMPT ===================================================================================== 
