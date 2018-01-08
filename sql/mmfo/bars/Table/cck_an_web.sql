

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_AN_WEB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_AN_WEB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_AN_WEB'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CCK_AN_WEB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_AN_WEB ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_AN_WEB 
   (	DL CHAR(1), 
	NBS CHAR(4), 
	PR NUMBER, 
	PRS NUMBER, 
	SROK NUMBER, 
	KV NUMBER(*,0), 
	N1 NUMBER, 
	N2 NUMBER, 
	N3 NUMBER, 
	NAME VARCHAR2(30), 
	OE NUMBER(*,0), 
	INSIDER NUMBER(*,0), 
	TIP NUMBER(*,0), 
	POROG NUMBER(*,0), 
	N4 NUMBER, 
	N5 NUMBER, 
	REG NUMBER(*,0), 
	ACCL NUMBER(*,0), 
	ACC NUMBER(*,0), 
	ACRA NUMBER(*,0), 
	CC_ID VARCHAR2(20), 
	ZAL NUMBER, 
	ZALQ NUMBER, 
	REZ NUMBER, 
	REZQ NUMBER, 
	UV NUMBER, 
	NLS VARCHAR2(15), 
	AIM NUMBER(*,0), 
	USERID NUMBER, 
	BRANCH VARCHAR2(30), 
	ND NUMBER, 
	NAME1 VARCHAR2(35), 
	NLSALT VARCHAR2(15), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	REC_ID VARCHAR2(32)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_AN_WEB ***
 exec bpa.alter_policies('CCK_AN_WEB');


COMMENT ON TABLE BARS.CCK_AN_WEB IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.DL IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.NBS IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.PR IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.PRS IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.SROK IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.KV IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.N1 IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.N2 IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.N3 IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.NAME IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.OE IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.INSIDER IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.TIP IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.POROG IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.N4 IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.N5 IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.REG IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.ACCL IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.ACC IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.ACRA IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.CC_ID IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.ZAL IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.ZALQ IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.REZ IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.REZQ IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.UV IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.NLS IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.AIM IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.USERID IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.BRANCH IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.ND IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.NAME1 IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.NLSALT IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.KF IS '';
COMMENT ON COLUMN BARS.CCK_AN_WEB.REC_ID IS '';



PROMPT *** Create  grants  CCK_AN_WEB ***
grant SELECT                                                                 on CCK_AN_WEB      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on CCK_AN_WEB      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_AN_WEB      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_AN_WEB.sql =========*** End *** ==
PROMPT ===================================================================================== 
