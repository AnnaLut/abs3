

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TMP_PENS_UPSZN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_PENS_UPSZN ***
begin 
  execute immediate '
  CREATE TABLE PFU.TMP_PENS_UPSZN 
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


COMMENT ON TABLE PFU.TMP_PENS_UPSZN IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.MFO IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.NLS IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.FILIAL IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.KOD_VKLADU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.SUMMA IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.NMK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.OKPO IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.PAY_DAY IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.NAME_FILE IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.BRANCH IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.STATE IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.TXT IS '';
COMMENT ON COLUMN PFU.TMP_PENS_UPSZN.RNK IS '';



PROMPT *** Create  grants  TMP_PENS_UPSZN ***
grant SELECT                                                                 on TMP_PENS_UPSZN  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TMP_PENS_UPSZN.sql =========*** End ***
PROMPT ===================================================================================== 
