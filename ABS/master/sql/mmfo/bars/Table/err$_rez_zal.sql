

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_REZ_ZAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_REZ_ZAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_REZ_ZAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_REZ_ZAL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	ACCS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	NBS VARCHAR2(4000), 
	PAWN VARCHAR2(4000), 
	S031 VARCHAR2(4000), 
	R031 VARCHAR2(4000), 
	PR_12 VARCHAR2(4000), 
	PWN VARCHAR2(4000), 
	OSTC_Z VARCHAR2(4000), 
	ACCS1 VARCHAR2(4000), 
	OSTC_S VARCHAR2(4000), 
	ACCC VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	OSTC_S_KP VARCHAR2(4000), 
	OSTC_Z31 VARCHAR2(4000), 
	KV_D VARCHAR2(4000), 
	KV_S VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_REZ_ZAL ***
 exec bpa.alter_policies('ERR$_REZ_ZAL');


COMMENT ON TABLE BARS.ERR$_REZ_ZAL IS 'DML Error Logging table for "REZ_ZAL"';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.KV_D IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.KV_S IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.ACCS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.KV IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.PAWN IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.S031 IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.R031 IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.PR_12 IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.PWN IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.OSTC_Z IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.ACCS1 IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.OSTC_S IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.ACCC IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.ND IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.OSTC_S_KP IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ZAL.OSTC_Z31 IS '';



PROMPT *** Create  grants  ERR$_REZ_ZAL ***
grant SELECT                                                                 on ERR$_REZ_ZAL    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_REZ_ZAL    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_REZ_ZAL.sql =========*** End *** 
PROMPT ===================================================================================== 
