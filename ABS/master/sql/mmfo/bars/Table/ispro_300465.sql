

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ISPRO_300465.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ISPRO_300465 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ISPRO_300465 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ISPRO_300465 
   (	NM NUMBER(2,0), 
	NP NUMBER(3,0), 
	DK NUMBER(1,0), 
	REF NUMBER(9,0), 
	TP VARCHAR2(2), 
	MFO NUMBER(9,0), 
	ND VARCHAR2(10), 
	VOB NUMBER(2,0), 
	NLS VARCHAR2(14), 
	NLSK VARCHAR2(14), 
	SK NUMBER(2,0), 
	S NUMBER(16,0), 
	VDATE DATE, 
	VTIME NUMBER(6,0), 
	DA DATE, 
	PFA NUMBER(1,0), 
	NA NUMBER(5,0), 
	SPO VARCHAR2(3), 
	SOS NUMBER(2,0), 
	NS NUMBER(5,0), 
	PZO NUMBER(1,0), 
	KW NUMBER(1,0), 
	SR NUMBER(5,0), 
	BLK NUMBER(1,0), 
	KISP VARCHAR2(6), 
	SIGN VARCHAR2(64), 
	KLIP NUMBER(1,0), 
	POND VARCHAR2(8), 
	KOD VARCHAR2(14), 
	KODB VARCHAR2(14), 
	DATD DATE, 
	PLAT VARCHAR2(38), 
	POLU VARCHAR2(38), 
	NAZ1 VARCHAR2(160), 
	VSPO VARCHAR2(80), 
	NLS1 VARCHAR2(14), 
	TT NUMBER(2,0), 
	PTIME NUMBER(4,0), 
	WTIME NUMBER(4,0), 
	KTIME NUMBER(4,0), 
	TV VARCHAR2(2), 
	TK VARCHAR2(2), 
	DKLI DATE, 
	TKLI VARCHAR2(6), 
	R3 NUMBER(1,0), 
	NDR3 VARCHAR2(12), 
	VR3 NUMBER(1,0), 
	KASVID VARCHAR2(100), 
	KASFIO VARCHAR2(40), 
	KASDOK VARCHAR2(15), 
	KASSER VARCHAR2(5), 
	KASNDOK VARCHAR2(6), 
	KASNAR DATE, 
	KASADR VARCHAR2(45), 
	KASDOV VARCHAR2(25), 
	KASNDOV VARCHAR2(6), 
	REF99BM NUMBER(16,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ISPRO_300465 ***
 exec bpa.alter_policies('ISPRO_300465');


COMMENT ON TABLE BARS.ISPRO_300465 IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.NM IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.NP IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.DK IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.REF IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.TP IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.MFO IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.ND IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.VOB IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.NLS IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.NLSK IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.SK IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.S IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.VDATE IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.VTIME IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.DA IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.PFA IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.NA IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.SPO IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.SOS IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.NS IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.PZO IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KW IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.SR IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.BLK IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KISP IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.SIGN IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KLIP IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.POND IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KOD IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KODB IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.DATD IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.PLAT IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.POLU IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.NAZ1 IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.VSPO IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.NLS1 IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.TT IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.PTIME IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.WTIME IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KTIME IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.TV IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.TK IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.DKLI IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.TKLI IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.R3 IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.NDR3 IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.VR3 IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KASVID IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KASFIO IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KASDOK IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KASSER IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KASNDOK IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KASNAR IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KASADR IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KASDOV IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.KASNDOV IS '';
COMMENT ON COLUMN BARS.ISPRO_300465.REF99BM IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ISPRO_300465.sql =========*** End *** 
PROMPT ===================================================================================== 
