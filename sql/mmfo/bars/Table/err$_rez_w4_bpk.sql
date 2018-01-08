

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_REZ_W4_BPK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_REZ_W4_BPK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_REZ_W4_BPK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_REZ_W4_BPK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	ACC_PK VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	NBS VARCHAR2(4000), 
	OB22 VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	TIP VARCHAR2(4000), 
	TIP_KART VARCHAR2(4000), 
	SDATE VARCHAR2(4000), 
	WDATE VARCHAR2(4000), 
	FIN23 VARCHAR2(4000), 
	S250 VARCHAR2(4000), 
	GRP VARCHAR2(4000), 
	VKR VARCHAR2(4000), 
	RESTR VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_REZ_W4_BPK ***
 exec bpa.alter_policies('ERR$_REZ_W4_BPK');


COMMENT ON TABLE BARS.ERR$_REZ_W4_BPK IS 'DML Error Logging table for "REZ_W4_BPK"';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.ND IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.ACC_PK IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.OB22 IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.KV IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.TIP IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.TIP_KART IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.SDATE IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.WDATE IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.FIN23 IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.S250 IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.GRP IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.VKR IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.RESTR IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_W4_BPK.KF IS '';



PROMPT *** Create  grants  ERR$_REZ_W4_BPK ***
grant SELECT                                                                 on ERR$_REZ_W4_BPK to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_REZ_W4_BPK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_REZ_W4_BPK.sql =========*** End *
PROMPT ===================================================================================== 
