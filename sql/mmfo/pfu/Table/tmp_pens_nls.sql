

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TMP_PENS_NLS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_PENS_NLS ***
begin 
  execute immediate '
  CREATE TABLE PFU.TMP_PENS_NLS 
   (	MFO VARCHAR2(6), 
	NLS_PFU VARCHAR2(19), 
	NLS_BANK VARCHAR2(19), 
	FILIAL VARCHAR2(5), 
	KOD_VKLADU VARCHAR2(3), 
	SUMMA NUMBER(38,0), 
	NMK_PFU VARCHAR2(100), 
	NMK_BANK VARCHAR2(100), 
	OKPO_PFU VARCHAR2(14), 
	OKPO_BANK VARCHAR2(14), 
	BRANCH VARCHAR2(30), 
	STATE VARCHAR2(2), 
	TXT VARCHAR2(120), 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.TMP_PENS_NLS IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.MFO IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.NLS_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.NLS_BANK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.FILIAL IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.KOD_VKLADU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.SUMMA IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.NMK_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.NMK_BANK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.OKPO_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.OKPO_BANK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.BRANCH IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.STATE IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.TXT IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS.RNK IS '';



PROMPT *** Create  grants  TMP_PENS_NLS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PENS_NLS    to BARS;
grant SELECT                                                                 on TMP_PENS_NLS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TMP_PENS_NLS.sql =========*** End *** =
PROMPT ===================================================================================== 
