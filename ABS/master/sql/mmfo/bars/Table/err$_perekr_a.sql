

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PEREKR_A.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PEREKR_A ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PEREKR_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PEREKR_A 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDG VARCHAR2(4000), 
	IDS VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	SPS VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PEREKR_A ***
 exec bpa.alter_policies('ERR$_PEREKR_A');


COMMENT ON TABLE BARS.ERR$_PEREKR_A IS 'DML Error Logging table for "PEREKR_A"';
COMMENT ON COLUMN BARS.ERR$_PEREKR_A.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_A.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_A.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_A.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_A.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_A.IDG IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_A.IDS IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_A.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_A.SPS IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_A.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PEREKR_A.sql =========*** End ***
PROMPT ===================================================================================== 
