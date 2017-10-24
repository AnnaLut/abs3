

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LICS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LICS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_LICS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_LICS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_LICS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LICS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_LICS 
   (	ID NUMBER(38,0), 
	DAOPL DATE, 
	ACC NUMBER(16,0), 
	S NUMBER(17,0), 
	ND VARCHAR2(10), 
	MFOB VARCHAR2(9), 
	NAZN VARCHAR2(160), 
	ISP NUMBER(38,0), 
	NLSA VARCHAR2(14), 
	MFOA VARCHAR2(9), 
	KV NUMBER, 
	NAMA VARCHAR2(38), 
	NLSB VARCHAR2(14), 
	NAMB VARCHAR2(38), 
	REF NUMBER(16,0), 
	TT CHAR(3), 
	IOST NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	VDAT DATE, 
	PDAT DATE, 
	SK NUMBER(38,0), 
	DAPP DATE, 
	OKPOA VARCHAR2(14), 
	OKPOB VARCHAR2(14), 
	DK NUMBER(38,0), 
	VOB NUMBER(38,0), 
	POND VARCHAR2(10), 
	NAMEFILEA VARCHAR2(12), 
	KODIROWKA NUMBER, 
	NAZNS VARCHAR2(2), 
	BIS NUMBER, 
	NAZNK VARCHAR2(3), 
	D_REC VARCHAR2(80), 
	FN_A VARCHAR2(12), 
	REC NUMBER, 
	DATD DATE, 
	DATB1 DATE, 
	DATB2 DATE, 
	DATOV DATE, 
	DATBIS DATE, 
	OKPOZ VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LICS ***
 exec bpa.alter_policies('TMP_LICS');


COMMENT ON TABLE BARS.TMP_LICS IS '';
COMMENT ON COLUMN BARS.TMP_LICS.ID IS '';
COMMENT ON COLUMN BARS.TMP_LICS.DAOPL IS '';
COMMENT ON COLUMN BARS.TMP_LICS.ACC IS '';
COMMENT ON COLUMN BARS.TMP_LICS.S IS '';
COMMENT ON COLUMN BARS.TMP_LICS.ND IS '';
COMMENT ON COLUMN BARS.TMP_LICS.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_LICS.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_LICS.ISP IS '';
COMMENT ON COLUMN BARS.TMP_LICS.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_LICS.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_LICS.KV IS '';
COMMENT ON COLUMN BARS.TMP_LICS.NAMA IS '';
COMMENT ON COLUMN BARS.TMP_LICS.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_LICS.NAMB IS '';
COMMENT ON COLUMN BARS.TMP_LICS.REF IS '';
COMMENT ON COLUMN BARS.TMP_LICS.TT IS '';
COMMENT ON COLUMN BARS.TMP_LICS.IOST IS '';
COMMENT ON COLUMN BARS.TMP_LICS.DOS IS '';
COMMENT ON COLUMN BARS.TMP_LICS.KOS IS '';
COMMENT ON COLUMN BARS.TMP_LICS.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_LICS.PDAT IS '';
COMMENT ON COLUMN BARS.TMP_LICS.SK IS '';
COMMENT ON COLUMN BARS.TMP_LICS.DAPP IS '';
COMMENT ON COLUMN BARS.TMP_LICS.OKPOA IS '';
COMMENT ON COLUMN BARS.TMP_LICS.OKPOB IS '';
COMMENT ON COLUMN BARS.TMP_LICS.DK IS '';
COMMENT ON COLUMN BARS.TMP_LICS.VOB IS '';
COMMENT ON COLUMN BARS.TMP_LICS.POND IS '';
COMMENT ON COLUMN BARS.TMP_LICS.NAMEFILEA IS '';
COMMENT ON COLUMN BARS.TMP_LICS.KODIROWKA IS '';
COMMENT ON COLUMN BARS.TMP_LICS.NAZNS IS '';
COMMENT ON COLUMN BARS.TMP_LICS.BIS IS '';
COMMENT ON COLUMN BARS.TMP_LICS.NAZNK IS '';
COMMENT ON COLUMN BARS.TMP_LICS.D_REC IS '';
COMMENT ON COLUMN BARS.TMP_LICS.FN_A IS '';
COMMENT ON COLUMN BARS.TMP_LICS.REC IS '';
COMMENT ON COLUMN BARS.TMP_LICS.DATD IS '';
COMMENT ON COLUMN BARS.TMP_LICS.DATB1 IS 'Дата банка плательщика';
COMMENT ON COLUMN BARS.TMP_LICS.DATB2 IS 'Дата банка получателя';
COMMENT ON COLUMN BARS.TMP_LICS.DATOV IS 'Дата проводки документа';
COMMENT ON COLUMN BARS.TMP_LICS.DATBIS IS 'Дата возможных БИСов';
COMMENT ON COLUMN BARS.TMP_LICS.OKPOZ IS 'ОКПО в заглавных строках';



PROMPT *** Create  grants  TMP_LICS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LICS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_LICS        to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_LICS        to OPERKKK;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LICS        to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_LICS        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_LICS ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_LICS FOR BARS.TMP_LICS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LICS.sql =========*** End *** ====
PROMPT ===================================================================================== 
