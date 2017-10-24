

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_IMPORT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_IMPORT ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_IMPORT 
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
	INSERTION_DATE DATE DEFAULT sysdate, 
	VERIFICATION_FLAG VARCHAR2(1), 
	VERIFICATION_ERR_CODE NUMBER, 
	VERIFICATION_ERR_MSG VARCHAR2(4000), 
	VERIFICATION_DATE DATE, 
	CONFIRMATION_FLAG VARCHAR2(1), 
	CONFIRMATION_DATE DATE, 
	BOOKING_FLAG VARCHAR2(1), 
	BOOKING_ERR_CODE NUMBER, 
	BOOKING_ERR_MSG VARCHAR2(4000), 
	BOOKING_DATE DATE, 
	REMOVAL_FLAG VARCHAR2(1), 
	REMOVAL_DATE DATE, 
	IGNORE_ERR_CODE NUMBER(*,0), 
	IGNORE_ERR_MSG VARCHAR2(4000), 
	IGNORE_COUNT NUMBER(*,0), 
	IGNORE_DATE DATE, 
	PRTY NUMBER(*,0), 
	NOTIFICATION_FLAG VARCHAR2(1), 
	NOTIFICATION_DATE DATE, 
	SYSTEM_ERR_CODE NUMBER(*,0), 
	SYSTEM_ERR_MSG VARCHAR2(4000), 
	SYSTEM_ERR_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_IMPORT IS '��������� ��� ������� � ���';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.EXT_REF IS 'External Reference';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.REF IS '�������� ��������� � ���';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.TT IS '��� ��������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.ND IS '������������ ����� ���������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VOB IS '��� ���������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VDAT IS '���� �������������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.DATD IS '���� ���������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.DATP IS '���� ����������� ��������� � ����';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.DK IS '������� �����/������:
0 - ������ ��������(direct debit),
1 - ���������� ��������,
2 - �������������� ������,
3 - �������������� ���������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.KV IS '��� ������ �';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.S IS '����� �';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.KV2 IS '��� ������ �';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.S2 IS '����� �';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SQ IS '���������� ����� �';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SK IS '������ ��������� �����';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.MFO_A IS '��� ����� �����������(���)';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NAM_A IS '������������ �����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NLS_A IS '���� �����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.ID_A IS '�����. ��� �����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.MFO_B IS '��� ����� ����������(���)';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NAM_B IS '������������ ����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NLS_B IS '���� ����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.ID_B IS '�����. ��� ����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NAZN IS '���������� �������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.USERID IS 'ID ������������ - �����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.ID_O IS '������������� ����� �������������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SIGN IS '��� ���������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.INSERTION_DATE IS '���� ������� ���������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VERIFICATION_FLAG IS '���� �����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VERIFICATION_ERR_CODE IS '��� ������ ��� �����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VERIFICATION_ERR_MSG IS '��������� �� ������ ��� �����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VERIFICATION_DATE IS '���� �����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.CONFIRMATION_FLAG IS '���� ������������� ������ ���������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.CONFIRMATION_DATE IS '���� ������������� ������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.BOOKING_FLAG IS '���� �������� ������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.BOOKING_ERR_CODE IS '��� ������ �������� ������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.BOOKING_ERR_MSG IS '��������� �� ������ ��� �������� ������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.BOOKING_DATE IS '���� �������� ������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.REMOVAL_FLAG IS '���� ������� �� ��������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.REMOVAL_DATE IS '���� ����� ������� �������� ���������� �������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.IGNORE_ERR_CODE IS '��� ������, ������� �� ����������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.IGNORE_ERR_MSG IS '��������� �� ������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.IGNORE_COUNT IS '���-�� ������� � �������������� ������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.IGNORE_DATE IS '���� ������������� ������, ������� ���������������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.PRTY IS '';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NOTIFICATION_FLAG IS '���� ����������� ��������-�������� �� ������(������� ��� ���) ���-��';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NOTIFICATION_DATE IS '���� ����������� ��������-�������� �� ������(������� ��� ���) ���-��';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SYSTEM_ERR_CODE IS '��������� ��� ������ ��� ������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SYSTEM_ERR_MSG IS '�������� ��������� ������ ��� ������';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SYSTEM_ERR_DATE IS '���� ������������� ��������� ������';




PROMPT *** Create  constraint CC_DOCIMPORT_RMFL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT CC_DOCIMPORT_RMFL CHECK (removal_flag=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_INSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (INSERTION_DATE CONSTRAINT CC_DOCIMPORT_INSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_CFFL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT CC_DOCIMPORT_CFFL CHECK (confirmation_flag=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_VRFL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT CC_DOCIMPORT_VRFL CHECK (verification_flag in (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DOCIMPORT ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT PK_DOCIMPORT PRIMARY KEY (EXT_REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NOTIFFLAG_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT CC_DOCIMPORT_NOTIFFLAG_CC CHECK (notification_flag=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_EXTREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (EXT_REF CONSTRAINT CC_DOCIMPORT_EXTREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (TT CONSTRAINT CC_DOCIMPORT_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (DK CONSTRAINT CC_DOCIMPORT_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (KV CONSTRAINT CC_DOCIMPORT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (S CONSTRAINT CC_DOCIMPORT_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_MFOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (MFO_A CONSTRAINT CC_DOCIMPORT_MFOA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NAMA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (NAM_A CONSTRAINT CC_DOCIMPORT_NAMA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (NLS_A CONSTRAINT CC_DOCIMPORT_NLSA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_IDA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (ID_A CONSTRAINT CC_DOCIMPORT_IDA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_MFOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (MFO_B CONSTRAINT CC_DOCIMPORT_MFOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NAMB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (NAM_B CONSTRAINT CC_DOCIMPORT_NAMB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NLSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (NLS_B CONSTRAINT CC_DOCIMPORT_NLSB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_IDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (ID_B CONSTRAINT CC_DOCIMPORT_IDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NAZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (NAZN CONSTRAINT CC_DOCIMPORT_NAZN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (USERID CONSTRAINT CC_DOCIMPORT_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_BKFL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT CC_DOCIMPORT_BKFL CHECK (booking_flag in (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCIMPORT_PAY ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCIMPORT_PAY ON BARSAQ.DOC_IMPORT (CASE  WHEN (CONFIRMATION_FLAG=''Y'' AND BOOKING_FLAG IS NULL AND REMOVAL_FLAG IS NULL) THEN ''Y'' ELSE NULL END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCIMPORT_NOTIFREQ ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCIMPORT_NOTIFREQ ON BARSAQ.DOC_IMPORT (CASE  WHEN (BOOKING_FLAG IS NOT NULL AND NOTIFICATION_FLAG IS NULL) THEN ''Y'' ELSE NULL END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCIMPORT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOCIMPORT ON BARSAQ.DOC_IMPORT (EXT_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCIMPORT_RM ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCIMPORT_RM ON BARSAQ.DOC_IMPORT (REMOVAL_FLAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCIMPORT_INSDATE ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCIMPORT_INSDATE ON BARSAQ.DOC_IMPORT (INSERTION_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCIMPORT_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.I_DOCIMPORT_REF ON BARSAQ.DOC_IMPORT (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_IMPORT ***
grant SELECT                                                                 on DOC_IMPORT      to BARS with grant option;
grant SELECT                                                                 on DOC_IMPORT      to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT                                                          on DOC_IMPORT      to REFSYNC_USR;
grant SELECT                                                                 on DOC_IMPORT      to START1;
grant SELECT                                                                 on DOC_IMPORT      to WR_REFREAD;



PROMPT *** Create SYNONYM  to DOC_IMPORT ***

  CREATE OR REPLACE SYNONYM BARS.DOC_IMPORT FOR BARSAQ.DOC_IMPORT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_IMPORT.sql =========*** End *** 
PROMPT ===================================================================================== 
