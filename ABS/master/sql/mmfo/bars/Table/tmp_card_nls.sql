

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CARD_NLS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CARD_NLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CARD_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CARD_NLS 
   (	RNK_OLD NUMBER(9,0), 
	RNK_NEW NUMBER(9,0), 
	NLS VARCHAR2(14), 
	OKPO VARCHAR2(15), 
	NMK VARCHAR2(50), 
	KV NUMBER, 
	BRANCH VARCHAR2(30), 
	FDAT1 DATE, 
	FDAT2 DATE, 
	NMK1 VARCHAR2(50), 
	NMK2 VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CARD_NLS ***
 exec bpa.alter_policies('TMP_CARD_NLS');


COMMENT ON TABLE BARS.TMP_CARD_NLS IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.RNK_OLD IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.RNK_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.NLS IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.NMK IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.KV IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.FDAT1 IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.FDAT2 IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.NMK1 IS '';
COMMENT ON COLUMN BARS.TMP_CARD_NLS.NMK2 IS '';



PROMPT *** Create  grants  TMP_CARD_NLS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CARD_NLS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_CARD_NLS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CARD_NLS.sql =========*** End *** 
PROMPT ===================================================================================== 
