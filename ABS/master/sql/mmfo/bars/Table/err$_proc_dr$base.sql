

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PROC_DR$BASE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PROC_DR$BASE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PROC_DR$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PROC_DR$BASE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NBS VARCHAR2(4000), 
	G67 VARCHAR2(4000), 
	V67 VARCHAR2(4000), 
	SOUR VARCHAR2(4000), 
	NBSN VARCHAR2(4000), 
	G67N VARCHAR2(4000), 
	V67N VARCHAR2(4000), 
	NBSZ VARCHAR2(4000), 
	REZID VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	TTV VARCHAR2(4000), 
	IO VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_PROC_DR$BASE ***
 exec bpa.alter_policies('ERR$_PROC_DR$BASE');


COMMENT ON TABLE BARS.ERR$_PROC_DR$BASE IS 'DML Error Logging table for "PROC_DR$BASE"';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.G67 IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.V67 IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.SOUR IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.NBSN IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.G67N IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.V67N IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.NBSZ IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.REZID IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.TT IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.TTV IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.IO IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_PROC_DR$BASE.KF IS '';



PROMPT *** Create  grants  ERR$_PROC_DR$BASE ***
grant SELECT                                                                 on ERR$_PROC_DR$BASE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_PROC_DR$BASE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PROC_DR$BASE.sql =========*** End
PROMPT ===================================================================================== 
