

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LICI.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LICI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_LICI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_LICI'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_LICI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LICI ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_LICI 
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
	FN_A VARCHAR2(12)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LICI ***
 exec bpa.alter_policies('TMP_LICI');


COMMENT ON TABLE BARS.TMP_LICI IS '';
COMMENT ON COLUMN BARS.TMP_LICI.ID IS '';
COMMENT ON COLUMN BARS.TMP_LICI.DAOPL IS '';
COMMENT ON COLUMN BARS.TMP_LICI.ACC IS '';
COMMENT ON COLUMN BARS.TMP_LICI.S IS '';
COMMENT ON COLUMN BARS.TMP_LICI.ND IS '';
COMMENT ON COLUMN BARS.TMP_LICI.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_LICI.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_LICI.ISP IS '';
COMMENT ON COLUMN BARS.TMP_LICI.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_LICI.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_LICI.KV IS '';
COMMENT ON COLUMN BARS.TMP_LICI.NAMA IS '';
COMMENT ON COLUMN BARS.TMP_LICI.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_LICI.NAMB IS '';
COMMENT ON COLUMN BARS.TMP_LICI.REF IS '';
COMMENT ON COLUMN BARS.TMP_LICI.TT IS '';
COMMENT ON COLUMN BARS.TMP_LICI.IOST IS '';
COMMENT ON COLUMN BARS.TMP_LICI.SK IS '';
COMMENT ON COLUMN BARS.TMP_LICI.DAPP IS '';
COMMENT ON COLUMN BARS.TMP_LICI.OKPOA IS '';
COMMENT ON COLUMN BARS.TMP_LICI.OKPOB IS '';
COMMENT ON COLUMN BARS.TMP_LICI.DK IS '';
COMMENT ON COLUMN BARS.TMP_LICI.VOB IS '';
COMMENT ON COLUMN BARS.TMP_LICI.POND IS '';
COMMENT ON COLUMN BARS.TMP_LICI.NAMEFILEA IS '';
COMMENT ON COLUMN BARS.TMP_LICI.KODIROWKA IS '';
COMMENT ON COLUMN BARS.TMP_LICI.NAZNS IS '';
COMMENT ON COLUMN BARS.TMP_LICI.BIS IS '';
COMMENT ON COLUMN BARS.TMP_LICI.NAZNK IS '';
COMMENT ON COLUMN BARS.TMP_LICI.D_REC IS '';
COMMENT ON COLUMN BARS.TMP_LICI.FN_A IS '';



PROMPT *** Create  grants  TMP_LICI ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LICI        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LICI        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LICI.sql =========*** End *** ====
PROMPT ===================================================================================== 
