

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_KOD_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_KOD_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_KOD_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KOD_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CP_KOD_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_KOD_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_KOD_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ID NUMBER, 
	EMI NUMBER, 
	DOX NUMBER(38,0), 
	CP_ID VARCHAR2(20), 
	KV NUMBER, 
	NAME VARCHAR2(70), 
	COUNTRY NUMBER(38,0), 
	DATP DATE, 
	IR NUMBER, 
	TIP NUMBER, 
	DAT_EM DATE, 
	AMORT NUMBER, 
	DCP NUMBER, 
	CENA NUMBER, 
	BASEY NUMBER, 
	CENA_KUP NUMBER(10,2), 
	KY NUMBER, 
	DOK DATE, 
	DNK DATE, 
	RNK NUMBER, 
	PERIOD_KUP NUMBER, 
	IDT VARCHAR2(4), 
	DAT_RR DATE, 
	PR1_KUP NUMBER(*,0), 
	PR_AMR NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	VNCRR VARCHAR2(4), 
	PR_AKT NUMBER(*,0), 
	METR NUMBER(*,0), 
	GS NUMBER(2,0), 
	CENA_KUP0 NUMBER(10,2), 
	CENA_START NUMBER, 
	QUOT_SIGN NUMBER(*,0), 
	DATZR DATE, 
	DATVK DATE, 
	IO NUMBER(*,0), 
	RIVEN NUMBER(*,0), 
	IN_BR NUMBER(*,0), 
	EXPIRY NUMBER(*,0), 
	ZAL_CP NUMBER, 
	PAWN NUMBER(*,0), 
	HIERARCHY_ID NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_KOD_UPDATE ***
 exec bpa.alter_policies('CP_KOD_UPDATE');


COMMENT ON TABLE BARS.CP_KOD_UPDATE IS '���������� ����� ��';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.IDUPD IS '��������� ���� ��� ������� ����������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CHGACTION IS '��� ���������� (I/U/D)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.EFFECTDATE IS '���������� ���� ������ �������� ����������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CHGDATE IS '���������� ���� ����������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DONEBY IS '��� ������������. ��� ���� ����������(���� � ������� ��� ���� ��������� ���������� - �������� ������ ���������)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.ID IS '����� �� - ��������� ����';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.EMI IS '��� ��������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DOX IS '��� ����������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CP_ID IS '������� ��� ��';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.KV IS '��� �������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.NAME IS '������������ ��������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.COUNTRY IS '������ ��������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DATP IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.IR IS '������� % ������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.TIP IS '����������(�����), �����������(����)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DAT_EM IS '���� �������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.AMORT IS '�����.����. = 1,�����.����. =0';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DCP IS '1-���� � ���, 0-���';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CENA IS '������� ���i������ ����i��� ��';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.BASEY IS '��� �������� ����';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CENA_KUP IS '���� ������ 1 �� (� ����� � ��� 10.55)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.KY IS '�i�-��� ����� ������ � ���_';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DOK IS '���� ������ ���������� ������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DNK IS '���� ������ ���������� ������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.RNK IS '��������������� ����� ����������� - �������� ��';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.PERIOD_KUP IS '�������� ������ (����).';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.IDT IS '��� ��';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DAT_RR IS '���� ���������� ��������� ���������� ������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.PR1_KUP IS '1 = ��������� ����� �� ������� ����� ������,
2 = ��������� ����� �� ������� 1 �� � �������� �� ���-�� � ������
null = �� �������. �� ��� ��� 1 = �� ������� ������,
                      ��� ��� 2 = �� ������� 1 ��';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.PR_AMR IS '5= ������� ����/���� �� ��.������ (�������� ��, �������)
4= �������� ����/���� �������(����.������)
 = ������� ����/���� �� ��.������ (�������� ���)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.FIN23 IS '�i����� �� ���-23';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.KAT23 IS '�������i� �����i �� �������� �� ���-23';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.K23 IS '����.�������� ������ �� ���-23';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.VNCRR IS '�����i��i� ��������� ����i��';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.PR_AKT IS '������ ������������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.METR IS '����� ����������� %';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.GS IS '������ ����. ��';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CENA_KUP0 IS '�_�� ������...';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CENA_START IS '�������� ���i������ ����i��� ��';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.QUOT_SIGN IS 'sign quotation on the stock exchange(������� ��������� �� �����)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DATZR IS '���� ���������� ����_���_�';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DATVK IS '���� ������� ������� ��������� ���_���';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.IO IS '����������� %-� �� ��/��� �������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.RIVEN IS 'г���� �������� �� � ������� ���������� ���. �������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.IN_BR IS '�������� �� �������� ������ 0/1';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.EXPIRY IS 'ʳ������ ��� ������������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.ZAL_CP IS '������������ �� 1 ��.��';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.PAWN IS '��� ������������';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.HIERARCHY_ID IS 'г���� �������� ����������� ������� ��';




PROMPT *** Create  constraint SYS_C009607 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (DAT_EM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPKODUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (KF CONSTRAINT CC_CPKODUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CPKODUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE ADD CONSTRAINT FK_CPKODUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009603 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (DOX NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CPKOD_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE ADD CONSTRAINT PK_CPKOD_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009602 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (EMI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009604 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (CP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009605 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009606 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009601 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CPKOD_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CPKOD_UPDATE ON BARS.CP_KOD_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CPKOD_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CPKOD_UPDATEEFFDAT ON BARS.CP_KOD_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CPKOD_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CPKOD_UPDATEPK ON BARS.CP_KOD_UPDATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table CP_KOD_UPDATE add fin_351 number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table CP_KOD_UPDATE add pd number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CP_KOD_UPDATE add fair_method_id number(2)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table CP_KOD_UPDATE add spec_cond_id number(2)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


PROMPT *** Create  grants  CP_KOD_UPDATE ***
grant SELECT                                                                 on CP_KOD_UPDATE   to BARSUPL;
grant SELECT                                                                 on CP_KOD_UPDATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_KOD_UPDATE   to BARS_DM;
grant SELECT                                                                 on CP_KOD_UPDATE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_KOD_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
