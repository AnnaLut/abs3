

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_VPKLB.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_VPKLB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_VPKLB ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_VPKLB 
   (	SAB VARCHAR2(6), 
	ACC NUMBER, 
	NLS VARCHAR2(14), 
	KV NUMBER, 
	NMS VARCHAR2(70), 
	NLSK VARCHAR2(14), 
	NAMK VARCHAR2(38), 
	MFO VARCHAR2(9), 
	NB VARCHAR2(38), 
	OKPO VARCHAR2(14), 
	S NUMBER, 
	ND VARCHAR2(10), 
	NAZN VARCHAR2(160), 
	VDAT DATE, 
	USERID NUMBER, 
	REF NUMBER, 
	SK NUMBER, 
	DAPP DATE, 
	DATP DATE, 
	VOB NUMBER, 
	DATD DATE, 
	FDAT DATE, 
	SOS NUMBER, 
	BLK_MSG VARCHAR2(200), 
	POND NUMBER, 
	DK NUMBER, 
	TT VARCHAR2(3), 
	KV2 NUMBER, 
	S2 NUMBER, 
	SQ NUMBER, 
	OST NUMBER, 
	SCN NUMBER, 
	STMT NUMBER, 
	D_REC VARCHAR2(50), 
	BRANCH VARCHAR2(30)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_VPKLB ***
 exec bpa.alter_policies('TMP_VPKLB');


COMMENT ON TABLE BARS.TMP_VPKLB IS '��������� ������� ��� ������������ ������� �� ��-����';
COMMENT ON COLUMN BARS.TMP_VPKLB.SAB IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.ACC IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.NLS IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.KV IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.NMS IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.NAMK IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.MFO IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.NB IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.S IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.ND IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.USERID IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.REF IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.SK IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.DAPP IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.DATP IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.VOB IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.DATD IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.SOS IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.BLK_MSG IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.POND IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.DK IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.TT IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.KV2 IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.S2 IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.SQ IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.OST IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.SCN IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.STMT IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.D_REC IS '';
COMMENT ON COLUMN BARS.TMP_VPKLB.BRANCH IS '';



PROMPT *** Create  grants  TMP_VPKLB ***
grant SELECT                                                                 on TMP_VPKLB       to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_VPKLB       to KLBX;
grant SELECT                                                                 on TMP_VPKLB       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_VPKLB.sql =========*** End *** ===
PROMPT ===================================================================================== 
