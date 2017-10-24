

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_DOC_IMPORT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_DOC_IMPORT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_DOC_IMPORT 
   (	EXT_REF VARCHAR2(40), 
	REF NUMBER, 
	TT CHAR(3), 
	ND VARCHAR2(10), 
	VOB NUMBER, 
	VDAT DATE, 
	DATD DATE, 
	DATP DATE, 
	DK NUMBER, 
	KV NUMBER, 
	S NUMBER, 
	KV2 NUMBER, 
	S2 NUMBER, 
	SQ NUMBER, 
	SK NUMBER, 
	MFO_A VARCHAR2(6), 
	NAM_A VARCHAR2(38), 
	NLS_A VARCHAR2(14), 
	ID_A VARCHAR2(10), 
	MFO_B VARCHAR2(6), 
	NAM_B VARCHAR2(38), 
	NLS_B VARCHAR2(14), 
	ID_B VARCHAR2(10), 
	NAZN VARCHAR2(160), 
	USERID NUMBER, 
	ID_O VARCHAR2(6), 
	SIGN RAW(256), 
	ERR_LANG VARCHAR2(3), 
	ERR_USR_MSG VARCHAR2(4000), 
	ERR_APP_CODE VARCHAR2(9), 
	ERR_APP_MSG VARCHAR2(4000), 
	ERR_APP_ACT VARCHAR2(4000), 
	ERR_DB_CODE NUMBER, 
	ERR_DB_MSG VARCHAR2(4000)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_DOC_IMPORT IS '��������� ��� ������� � ���';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.EXT_REF IS 'External Reference';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.REF IS '�������� ��������� � ���';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.TT IS '��� ��������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ND IS '������������ ����� ���������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.VOB IS '��� ���������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.VDAT IS '���� �������������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.DATD IS '���� ���������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.DATP IS '���� ����������� ��������� � ����';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.DK IS '������� �����/������:
0 - ������ ��������(direct debit),
1 - ���������� ��������,
2 - �������������� ������,
3 - �������������� ���������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.KV IS '��� ������ �';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.S IS '����� �';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.KV2 IS '��� ������ �';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.S2 IS '����� �';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.SQ IS '���������� ����� �';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.SK IS '������ ��������� �����';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.MFO_A IS '��� ����� �����������(���)';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.NAM_A IS '������������ �����������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.NLS_A IS '���� �����������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ID_A IS '�����. ��� �����������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.MFO_B IS '��� ����� ����������(���)';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.NAM_B IS '������������ ����������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.NLS_B IS '���� ����������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ID_B IS '�����. ��� ����������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.NAZN IS '���������� �������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.USERID IS 'ID ������������ - �����������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ID_O IS '������������� ����� �������������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.SIGN IS '��� ���������';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_LANG IS '����, �� ������� ������ ���� ��������� �� ������: ENG,RUS,UKR,...';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_USR_MSG IS '��������� �� ������. ���������� ������������ ������.';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_APP_CODE IS '��� ���������� ������. ���������� ��������� � �� IBS. ���������� ������������ ������ � ���� "Details"';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_APP_MSG IS '�������� ���������� ������. ���������� ��������� � �� IBS. ���������� ������������ ������ � ���� "Details"';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_APP_ACT IS '�������� �� ���������� ������. ���������� ��������� � �� IBS. ���������� ������������ ������ � ���� "Details"';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_DB_CODE IS '��� ������ �� ���. ���������� ��������� � �� IBS. ������������ �� ����������.';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_DB_MSG IS '�������� ������ �� ���. ���������� ��������� � �� IBS. ������������ �� ����������.';




PROMPT *** Create  constraint PK_TMPDOCIMPORT ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT ADD CONSTRAINT PK_TMPDOCIMPORT PRIMARY KEY (EXT_REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_NAZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (NAZN CONSTRAINT CC_TMPDOCIMPORT_NAZN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_IDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (ID_B CONSTRAINT CC_TMPDOCIMPORT_IDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_NLSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (NLS_B CONSTRAINT CC_TMPDOCIMPORT_NLSB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_NAMB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (NAM_B CONSTRAINT CC_TMPDOCIMPORT_NAMB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_MFOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (MFO_B CONSTRAINT CC_TMPDOCIMPORT_MFOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_IDA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (ID_A CONSTRAINT CC_TMPDOCIMPORT_IDA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (NLS_A CONSTRAINT CC_TMPDOCIMPORT_NLSA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_NAMA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (NAM_A CONSTRAINT CC_TMPDOCIMPORT_NAMA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_MFOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (MFO_A CONSTRAINT CC_TMPDOCIMPORT_MFOA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (S CONSTRAINT CC_TMPDOCIMPORT_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (KV CONSTRAINT CC_TMPDOCIMPORT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (DK CONSTRAINT CC_TMPDOCIMPORT_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (TT CONSTRAINT CC_TMPDOCIMPORT_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_EXTREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (EXT_REF CONSTRAINT CC_TMPDOCIMPORT_EXTREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPDOCIMPORT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_TMPDOCIMPORT ON BARSAQ.TMP_DOC_IMPORT (EXT_REF) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DOC_IMPORT ***
grant INSERT,SELECT                                                          on TMP_DOC_IMPORT  to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_DOC_IMPORT.sql =========*** End 
PROMPT ===================================================================================== 
