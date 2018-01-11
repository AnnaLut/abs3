

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TMP_KVITOVKA2.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_KVITOVKA2 ***
begin 
  execute immediate '
  CREATE TABLE PFU.TMP_KVITOVKA2 
   (	ID NUMBER(38,0), 
	NMK VARCHAR2(120), 
	OKPO VARCHAR2(10), 
	NLS VARCHAR2(16), 
	MFO VARCHAR2(6), 
	SUMMA NUMBER(38,0), 
	STATE VARCHAR2(120), 
	TXT VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.TMP_KVITOVKA2 IS '';
COMMENT ON COLUMN PFU.TMP_KVITOVKA2.ID IS '';
COMMENT ON COLUMN PFU.TMP_KVITOVKA2.NMK IS '';
COMMENT ON COLUMN PFU.TMP_KVITOVKA2.OKPO IS '';
COMMENT ON COLUMN PFU.TMP_KVITOVKA2.NLS IS '';
COMMENT ON COLUMN PFU.TMP_KVITOVKA2.MFO IS '';
COMMENT ON COLUMN PFU.TMP_KVITOVKA2.SUMMA IS '';
COMMENT ON COLUMN PFU.TMP_KVITOVKA2.STATE IS '';
COMMENT ON COLUMN PFU.TMP_KVITOVKA2.TXT IS '';



PROMPT *** Create  grants  TMP_KVITOVKA2 ***
grant SELECT                                                                 on TMP_KVITOVKA2   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_KVITOVKA2   to SHEVCHENKOOVO;
grant SELECT                                                                 on TMP_KVITOVKA2   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TMP_KVITOVKA2.sql =========*** End *** 
PROMPT ===================================================================================== 
