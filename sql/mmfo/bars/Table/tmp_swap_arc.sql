

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SWAP_ARC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SWAP_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SWAP_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SWAP_ARC 
   (	DAT DATE, 
	NTIK VARCHAR2(15), 
	RNK NUMBER, 
	NMK VARCHAR2(70), 
	KVA NUMBER(*,0), 
	NLSA VARCHAR2(15), 
	DAT_A DATE, 
	SUMA NUMBER, 
	KVB NUMBER(*,0), 
	NLSB VARCHAR2(15), 
	DAT_B DATE, 
	SUMB NUMBER, 
	PVX1 NUMBER, 
	PVX NUMBER, 
	IRAE NUMBER, 
	IRBE NUMBER, 
	PVX1A NUMBER, 
	PVX1B NUMBER, 
	REF NUMBER(*,0), 
	SWAP_TAG NUMBER, 
	DEAL_TAG NUMBER(*,0), 
	KODF VARCHAR2(4), 
	KOD VARCHAR2(20), 
	BVQ NUMBER, 
	BVQA NUMBER, 
	BVQB NUMBER, 
	B DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SWAP_ARC ***
 exec bpa.alter_policies('TMP_SWAP_ARC');


COMMENT ON TABLE BARS.TMP_SWAP_ARC IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.DAT IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.NTIK IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.RNK IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.NMK IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.KVA IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.DAT_A IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.SUMA IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.KVB IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.DAT_B IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.SUMB IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.PVX1 IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.PVX IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.IRAE IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.IRBE IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.PVX1A IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.PVX1B IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.REF IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.SWAP_TAG IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.DEAL_TAG IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.KODF IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.KOD IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.BVQ IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.BVQA IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.BVQB IS '';
COMMENT ON COLUMN BARS.TMP_SWAP_ARC.B IS '';



PROMPT *** Create  grants  TMP_SWAP_ARC ***
grant SELECT                                                                 on TMP_SWAP_ARC    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SWAP_ARC    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SWAP_ARC    to START1;
grant SELECT                                                                 on TMP_SWAP_ARC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SWAP_ARC.sql =========*** End *** 
PROMPT ===================================================================================== 