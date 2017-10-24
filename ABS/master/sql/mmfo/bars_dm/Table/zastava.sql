

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/ZASTAVA.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table ZASTAVA ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.ZASTAVA 
   (	PER_ID NUMBER, 
	KF VARCHAR2(6), 
	RNK NUMBER(38,0), 
	OKPO VARCHAR2(14), 
	ND NUMBER(38,0), 
	VIDD NUMBER(*,0), 
	NDZ VARCHAR2(20), 
	DATEZ DATE, 
	MPAWN VARCHAR2(35), 
	PAWNPAWN NUMBER(*,0), 
	PAWN NUMBER(*,0), 
	OZN VARCHAR2(100), 
	BVART NUMBER(15,2), 
	SVART NUMBER(15,2), 
	NREE VARCHAR2(45), 
	NDSTRAH VARCHAR2(15), 
	DATESTRAH DATE, 
	CNTCHK NUMBER(*,0), 
	DLCHK DATE, 
	NFACT VARCHAR2(100), 
	STZZ NUMBER(*,0), 
	ACC_PAWN NUMBER(*,0), 
	RNK_ACCPAWN NUMBER(*,0), 
	STATE_ACCPAWN NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.ZASTAVA IS '���������� �����';
COMMENT ON COLUMN BARS_DM.ZASTAVA.PER_ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.KF IS '���';
COMMENT ON COLUMN BARS_DM.ZASTAVA.RNK IS '������������� �볺���';
COMMENT ON COLUMN BARS_DM.ZASTAVA.OKPO IS '���';
COMMENT ON COLUMN BARS_DM.ZASTAVA.ND IS '������������� ���������� ��������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.VIDD IS '��� ��������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.NDZ IS '����� �������� �������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.DATEZ IS '���� �������� �������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.MPAWN IS '������, ��������������� ������������ �����';
COMMENT ON COLUMN BARS_DM.ZASTAVA.PAWNPAWN IS '��� ������ ������������ ����� � ������������� �����';
COMMENT ON COLUMN BARS_DM.ZASTAVA.PAWN IS '��� �������� �������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.OZN IS '����� ������ �������� �������(�����, �����, ������, �� ������� ��� �� ������, �������)';
COMMENT ON COLUMN BARS_DM.ZASTAVA.BVART IS '�������� ������� ������������ ����� (� ����������� ���)';
COMMENT ON COLUMN BARS_DM.ZASTAVA.SVART IS '������������� ������� ������������ �����(������������ �������) ';
COMMENT ON COLUMN BARS_DM.ZASTAVA.NREE IS '������������ ����� � ���������� ����� ��������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.NDSTRAH IS '����� �������� ����������� ������������ �����';
COMMENT ON COLUMN BARS_DM.ZASTAVA.DATESTRAH IS '���� ��������� �������� ����������� ������������ �����';
COMMENT ON COLUMN BARS_DM.ZASTAVA.CNTCHK IS 'ʳ������ �������� �������� �� �� ��� �� ����������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.DLCHK IS '���� �������� �������� ������������ �����';
COMMENT ON COLUMN BARS_DM.ZASTAVA.NFACT IS '�������� �������, �� �������� �� ���� (�������) �����';
COMMENT ON COLUMN BARS_DM.ZASTAVA.STZZ IS '���� ��������� ���������� �� �������� �������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.ACC_PAWN IS 'acc �������, �� ����� ����������� �������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.RNK_ACCPAWN IS '��� �������� �������, �� ����� ����������� �������';
COMMENT ON COLUMN BARS_DM.ZASTAVA.STATE_ACCPAWN IS '0 � �������� ��� ��� �������, 1 � ��������� ����� ��� �������';




PROMPT *** Create  constraint FK_ZASTAVA_PERID_PERIOD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.ZASTAVA ADD CONSTRAINT FK_ZASTAVA_PERID_PERIOD_ID FOREIGN KEY (PER_ID)
	  REFERENCES BARS_DM.PERIODS (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZASTAVA_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.ZASTAVA MODIFY (PER_ID CONSTRAINT CC_ZASTAVA_PERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZASTAVA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.ZASTAVA MODIFY (KF CONSTRAINT CC_ZASTAVA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZASTAVA_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.ZASTAVA MODIFY (RNK CONSTRAINT CC_ZASTAVA_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZASTAVA_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.ZASTAVA MODIFY (ND CONSTRAINT CC_ZASTAVA_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ZASTAVA_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_ZASTAVA_PERID ON BARS_DM.ZASTAVA (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZASTAVA ***
grant SELECT                                                                 on ZASTAVA         to BARS;
grant SELECT                                                                 on ZASTAVA         to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/ZASTAVA.sql =========*** End *** ==
PROMPT ===================================================================================== 
