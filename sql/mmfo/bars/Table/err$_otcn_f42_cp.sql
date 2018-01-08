

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_F42_CP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTCN_F42_CP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTCN_F42_CP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTCN_F42_CP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	SUM_ZAL VARCHAR2(4000), 
	DAT_ZAL VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	KODP VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTCN_F42_CP ***
 exec bpa.alter_policies('ERR$_OTCN_F42_CP');


COMMENT ON TABLE BARS.ERR$_OTCN_F42_CP IS 'DML Error Logging table for "OTCN_F42_CP"';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.KV IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.SUM_ZAL IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.DAT_ZAL IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.KODP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_F42_CP.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_F42_CP.sql =========*** End 
PROMPT ===================================================================================== 
