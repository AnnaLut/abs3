

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TMP_PENS_NLS_WAY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_PENS_NLS_WAY ***
begin 
  execute immediate '
  CREATE TABLE PFU.TMP_PENS_NLS_WAY 
   (	MFO VARCHAR2(6), 
	NLS_PFU VARCHAR2(19), 
	NLS_BANK VARCHAR2(19), 
	OB22_NLS_BANK VARCHAR2(4), 
	NLS_BANK_WAY VARCHAR2(19), 
	OB22_NLS_BANK_WAY VARCHAR2(4), 
	FILIAL VARCHAR2(5), 
	KOD_VKLADU VARCHAR2(3), 
	NMK_PFU VARCHAR2(100), 
	NMK_BANK VARCHAR2(100), 
	OKPO_PFU VARCHAR2(14), 
	OKPO_BANK VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.TMP_PENS_NLS_WAY IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.MFO IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.NLS_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.NLS_BANK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.OB22_NLS_BANK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.NLS_BANK_WAY IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.OB22_NLS_BANK_WAY IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.FILIAL IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.KOD_VKLADU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.NMK_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.NMK_BANK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.OKPO_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_WAY.OKPO_BANK IS '';



PROMPT *** Create  grants  TMP_PENS_NLS_WAY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PENS_NLS_WAY to BARS;
grant SELECT                                                                 on TMP_PENS_NLS_WAY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TMP_PENS_NLS_WAY.sql =========*** End *
PROMPT ===================================================================================== 
