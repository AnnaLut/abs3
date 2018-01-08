

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TMP_PENS_PFU.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_PENS_PFU ***
begin 
  execute immediate '
  CREATE TABLE PFU.TMP_PENS_PFU 
   (	MFO VARCHAR2(6), 
	NLS VARCHAR2(19), 
	FILIAL VARCHAR2(5), 
	KOD_VKLADU VARCHAR2(3), 
	SUMMA NUMBER(38,0), 
	NMK VARCHAR2(100), 
	OKPO VARCHAR2(10), 
	PAY_DAY VARCHAR2(2), 
	NAME_FILE VARCHAR2(32), 
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


COMMENT ON TABLE PFU.TMP_PENS_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.MFO IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.NLS IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.FILIAL IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.KOD_VKLADU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.SUMMA IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.NMK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.OKPO IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.PAY_DAY IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.NAME_FILE IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.BRANCH IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.STATE IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.TXT IS '';
COMMENT ON COLUMN PFU.TMP_PENS_PFU.RNK IS '';



PROMPT *** Create  grants  TMP_PENS_PFU ***
grant SELECT                                                                 on TMP_PENS_PFU    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TMP_PENS_PFU.sql =========*** End *** =
PROMPT ===================================================================================== 
