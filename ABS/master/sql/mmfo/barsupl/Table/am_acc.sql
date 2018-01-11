

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/AM_ACC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table AM_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.AM_ACC 
   (	KF VARCHAR2(6), 
	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	NLSALT VARCHAR2(15), 
	BRANCH VARCHAR2(30), 
	KV NUMBER(3,0), 
	DAOS DATE, 
	MDATE DATE, 
	RNK NUMBER(22,0), 
	ACCC NUMBER(38,0), 
	LIM NUMBER(24,0), 
	VID NUMBER(2,0), 
	BLKD NUMBER(3,0), 
	BLKK NUMBER(3,0), 
	NBS CHAR(4), 
	TIP CHAR(3), 
	DAZS DATE, 
	PAP NUMBER, 
	OB22 CHAR(2), 
	R011 VARCHAR2(1), 
	R012 VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.AM_ACC IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.KF IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.ACC IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.NLS IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.NLSALT IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.BRANCH IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.KV IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.DAOS IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.MDATE IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.RNK IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.ACCC IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.LIM IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.VID IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.BLKD IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.BLKK IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.NBS IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.TIP IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.DAZS IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.PAP IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.OB22 IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.R011 IS '';
COMMENT ON COLUMN BARSUPL.AM_ACC.R012 IS '';



PROMPT *** Create  grants  AM_ACC ***
grant SELECT                                                                 on AM_ACC          to BARSREADER_ROLE;
grant SELECT                                                                 on AM_ACC          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/AM_ACC.sql =========*** End *** ===
PROMPT ===================================================================================== 
