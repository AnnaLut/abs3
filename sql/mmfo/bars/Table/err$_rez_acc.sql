

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_REZ_ACC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_REZ_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_REZ_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_REZ_ACC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	NBS VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	DAOS VARCHAR2(4000), 
	DAPP VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	NMS VARCHAR2(4000), 
	LIM VARCHAR2(4000), 
	PAP VARCHAR2(4000), 
	TIP VARCHAR2(4000), 
	VID VARCHAR2(4000), 
	MDATE VARCHAR2(4000), 
	DAZS VARCHAR2(4000), 
	ACCC VARCHAR2(4000), 
	TOBO VARCHAR2(4000), 
	KV_D VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_REZ_ACC ***
 exec bpa.alter_policies('ERR$_REZ_ACC');


COMMENT ON TABLE BARS.ERR$_REZ_ACC IS 'DML Error Logging table for "REZ_ACC"';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.KV IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.DAOS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.DAPP IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.NMS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.LIM IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.PAP IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.TIP IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.VID IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.MDATE IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.DAZS IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.ACCC IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.TOBO IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_ACC.KV_D IS '';



PROMPT *** Create  grants  ERR$_REZ_ACC ***
grant SELECT                                                                 on ERR$_REZ_ACC    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_REZ_ACC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_REZ_ACC.sql =========*** End *** 
PROMPT ===================================================================================== 
