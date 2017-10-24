

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TMP_PFU_PENS_NLS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_PFU_PENS_NLS ***
begin 
  execute immediate '
  CREATE TABLE PFU.TMP_PFU_PENS_NLS 
   (	MFO VARCHAR2(6), 
	NLS VARCHAR2(40), 
	OKPO VARCHAR2(14), 
	PASSPORT VARCHAR2(14), 
	NMK VARCHAR2(70), 
	NMK1 VARCHAR2(70), 
	NMK2 VARCHAR2(70), 
	FOUND VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.TMP_PFU_PENS_NLS IS '';
COMMENT ON COLUMN PFU.TMP_PFU_PENS_NLS.MFO IS '';
COMMENT ON COLUMN PFU.TMP_PFU_PENS_NLS.NLS IS '';
COMMENT ON COLUMN PFU.TMP_PFU_PENS_NLS.OKPO IS '';
COMMENT ON COLUMN PFU.TMP_PFU_PENS_NLS.PASSPORT IS '';
COMMENT ON COLUMN PFU.TMP_PFU_PENS_NLS.NMK IS '';
COMMENT ON COLUMN PFU.TMP_PFU_PENS_NLS.NMK1 IS '';
COMMENT ON COLUMN PFU.TMP_PFU_PENS_NLS.NMK2 IS '';
COMMENT ON COLUMN PFU.TMP_PFU_PENS_NLS.FOUND IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TMP_PFU_PENS_NLS.sql =========*** End *
PROMPT ===================================================================================== 
