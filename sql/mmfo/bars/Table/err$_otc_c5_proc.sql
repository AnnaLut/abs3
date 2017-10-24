

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTC_C5_PROC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTC_C5_PROC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTC_C5_PROC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTC_C5_PROC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DATF VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	KODP VARCHAR2(4000), 
	ZNAP VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTC_C5_PROC ***
 exec bpa.alter_policies('ERR$_OTC_C5_PROC');


COMMENT ON TABLE BARS.ERR$_OTC_C5_PROC IS 'DML Error Logging table for "OTC_C5_PROC"';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.ND IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.KV IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.KODP IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.ZNAP IS '';
COMMENT ON COLUMN BARS.ERR$_OTC_C5_PROC.KF IS '';



PROMPT *** Create  grants  ERR$_OTC_C5_PROC ***
grant SELECT                                                                 on ERR$_OTC_C5_PROC to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTC_C5_PROC.sql =========*** End 
PROMPT ===================================================================================== 
