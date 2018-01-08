

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TMP_PENS_NLS_OB22.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_PENS_NLS_OB22 ***
begin 
  execute immediate '
  CREATE TABLE PFU.TMP_PENS_NLS_OB22 
   (	MFO VARCHAR2(6), 
	NLS_PFU VARCHAR2(19), 
	OB22_NLS_PFU VARCHAR2(4), 
	NLS_BANK VARCHAR2(19), 
	OB22_NLS_BANK VARCHAR2(4), 
	NMK_PFU VARCHAR2(100), 
	NMK_BANK VARCHAR2(100), 
	OKPO_PFU VARCHAR2(14), 
	OKPO_BANK VARCHAR2(14), 
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


COMMENT ON TABLE PFU.TMP_PENS_NLS_OB22 IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.MFO IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.NLS_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.OB22_NLS_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.NLS_BANK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.OB22_NLS_BANK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.NMK_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.NMK_BANK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.OKPO_PFU IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.OKPO_BANK IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.STATE IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.TXT IS '';
COMMENT ON COLUMN PFU.TMP_PENS_NLS_OB22.RNK IS '';



PROMPT *** Create  grants  TMP_PENS_NLS_OB22 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PENS_NLS_OB22 to BARS;
grant SELECT                                                                 on TMP_PENS_NLS_OB22 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TMP_PENS_NLS_OB22.sql =========*** End 
PROMPT ===================================================================================== 
