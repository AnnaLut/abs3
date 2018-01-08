

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CCK_RESTR_ACC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CCK_RESTR_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CCK_RESTR_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CCK_RESTR_ACC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	VID_RESTR VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	SUMR VARCHAR2(4000), 
	FDAT_END VARCHAR2(4000), 
	PR_NO VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CCK_RESTR_ACC ***
 exec bpa.alter_policies('ERR$_CCK_RESTR_ACC');


COMMENT ON TABLE BARS.ERR$_CCK_RESTR_ACC IS 'DML Error Logging table for "CCK_RESTR_ACC"';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.VID_RESTR IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.SUMR IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.FDAT_END IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.PR_NO IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_RESTR_ACC.KF IS '';



PROMPT *** Create  grants  ERR$_CCK_RESTR_ACC ***
grant SELECT                                                                 on ERR$_CCK_RESTR_ACC to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CCK_RESTR_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CCK_RESTR_ACC.sql =========*** En
PROMPT ===================================================================================== 
