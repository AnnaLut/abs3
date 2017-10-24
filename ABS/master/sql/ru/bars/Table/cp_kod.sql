

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_KOD.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_KOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_KOD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_KOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_KOD 
   (	ID NUMBER, 
	CP_ID VARCHAR2(20), 
	KV NUMBER, 
	NAME VARCHAR2(70), 
	DAT_EM DATE, 
	DATP DATE, 
	IR NUMBER, 
	CENA NUMBER, 
	CENA_KUP NUMBER, 
	DATZR DATE, 
	DATVK DATE, 
	KAT23 NUMBER, 
	DOK DATE, 
	CENA_START NUMBER, 
	BASEY NUMBER, 
	DOX NUMBER, 
	EMI NUMBER, 
	COUNTRY NUMBER, 
	KY NUMBER, 
	RNK NUMBER, 
	DNK DATE, 
	PERIOD_KUP NUMBER, 
	IDT VARCHAR2(4), 
	PR1_KUP NUMBER(*,0), 
	PR_AMR NUMBER(*,0), 
	DAT_RR DATE, 
	FIN23 NUMBER(*,0), 
	K23 NUMBER, 
	PR_AKT NUMBER(*,0), 
	VNCRR VARCHAR2(4), 
	METR NUMBER(*,0), 
	GS NUMBER, 
	CENA_KUP0 NUMBER, 
	TIP NUMBER, 
	AMORT NUMBER, 
	DCP NUMBER, 
	IO NUMBER(*,0), 
	RIVEN NUMBER(*,0), 
	IN_BR NUMBER(*,0), 
	QUOT_SIGN NUMBER(*,0), 
	EXPIRY NUMBER(*,0), 
	VNCRP VARCHAR2(4), 
	ZAL_CP NUMBER, 
	PAWN NUMBER(*,0), 
	HIERARCHY_ID NUMBER(*,0), 
	FIN_351 NUMBER, 
	PD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_KOD ***
 exec bpa.alter_policies('CP_KOD');


COMMENT ON TABLE BARS.CP_KOD IS '���������� ����� ��';
COMMENT ON COLUMN BARS.CP_KOD.DATZR IS '���� ���������� ���������';
COMMENT ON COLUMN BARS.CP_KOD.DATVK IS '���� ������� ������� ��������� ������';
COMMENT ON COLUMN BARS.CP_KOD.KAT23 IS '�������i� �����i �� �������� �� ���-23';
COMMENT ON COLUMN BARS.CP_KOD.DOK IS '���� ������ ���������� ������';
COMMENT ON COLUMN BARS.CP_KOD.CENA_START IS '�������� ���i������ ����i��� ��';
COMMENT ON COLUMN BARS.CP_KOD.FIN_351 IS 'Գ�.���� ����� 351 ����.';
COMMENT ON COLUMN BARS.CP_KOD.PD IS 'PD';
COMMENT ON COLUMN BARS.CP_KOD.ZAL_CP IS '������������ �� 1 ��.��';
COMMENT ON COLUMN BARS.CP_KOD.PAWN IS '��� ������������';
COMMENT ON COLUMN BARS.CP_KOD.HIERARCHY_ID IS 'г���� �������� ����������� ������� ������ ������';
COMMENT ON COLUMN BARS.CP_KOD.ID IS '����� �� - ��������� ����';
COMMENT ON COLUMN BARS.CP_KOD.CP_ID IS '������� ��� ��';
COMMENT ON COLUMN BARS.CP_KOD.KV IS '��� �������';
COMMENT ON COLUMN BARS.CP_KOD.NAME IS '������������ ��������';
COMMENT ON COLUMN BARS.CP_KOD.DAT_EM IS '���� �������';
COMMENT ON COLUMN BARS.CP_KOD.DATP IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.CP_KOD.IR IS '������� % ������';
COMMENT ON COLUMN BARS.CP_KOD.CENA IS '������� ���i������ ����i��� ��';
COMMENT ON COLUMN BARS.CP_KOD.CENA_KUP IS '���� ������ 1 �� (� ����� � ��� 10.55)';
COMMENT ON COLUMN BARS.CP_KOD.BASEY IS '';
COMMENT ON COLUMN BARS.CP_KOD.DOX IS '��� ����������';
COMMENT ON COLUMN BARS.CP_KOD.EMI IS '��� ��������';
COMMENT ON COLUMN BARS.CP_KOD.COUNTRY IS '������ ��������';
COMMENT ON COLUMN BARS.CP_KOD.KY IS '�i�-��� ����� ������ � ����';
COMMENT ON COLUMN BARS.CP_KOD.RNK IS '��������������� ����� ����������� - �������� ��';
COMMENT ON COLUMN BARS.CP_KOD.DNK IS '���� ������ ���������� ������';
COMMENT ON COLUMN BARS.CP_KOD.PERIOD_KUP IS '�������� ������ (����).';
COMMENT ON COLUMN BARS.CP_KOD.IDT IS '';
COMMENT ON COLUMN BARS.CP_KOD.PR1_KUP IS '1 = ��������� ����� �� ������� ����� ������,
2 = ��������� ����� �� ������� 1 �� � �������� �� ���-�� � ������
null = �� �������. �� ��� ��� 1 = �� ������� ������,
                      ��� ��� 2 = �� ������� 1 ��';
COMMENT ON COLUMN BARS.CP_KOD.PR_AMR IS '5= ������� ����/���� �� ��.������ (�������� ��, �������)
4= �������� ����/���� �������(����.������)
 = ������� ����/���� �� ��.������ (�������� ���)';
COMMENT ON COLUMN BARS.CP_KOD.DAT_RR IS '���� ���������� ��������� ���������� ������';
COMMENT ON COLUMN BARS.CP_KOD.FIN23 IS '�i����� �� ���-23';
COMMENT ON COLUMN BARS.CP_KOD.K23 IS '����.�������� ������ �� ���-23';
COMMENT ON COLUMN BARS.CP_KOD.PR_AKT IS '������ ������������';
COMMENT ON COLUMN BARS.CP_KOD.VNCRR IS '�����i��i� ��������� ����i��';
COMMENT ON COLUMN BARS.CP_KOD.METR IS '';
COMMENT ON COLUMN BARS.CP_KOD.GS IS '';
COMMENT ON COLUMN BARS.CP_KOD.CENA_KUP0 IS '';
COMMENT ON COLUMN BARS.CP_KOD.TIP IS '����������(�����), �����������(����)';
COMMENT ON COLUMN BARS.CP_KOD.AMORT IS '�����.����. = 1,�����.����. =0';
COMMENT ON COLUMN BARS.CP_KOD.DCP IS '1-���� � ���, 0-���';
COMMENT ON COLUMN BARS.CP_KOD.IO IS '�����.% �� ��/��� �������';
COMMENT ON COLUMN BARS.CP_KOD.RIVEN IS 'г���� �������� �� � ������� ���������� ���. �������';
COMMENT ON COLUMN BARS.CP_KOD.IN_BR IS '�������� �� �������� ������ 0/1';
COMMENT ON COLUMN BARS.CP_KOD.QUOT_SIGN IS 'sign quotation on the stock exchange(������� ��������� �� �����)';
COMMENT ON COLUMN BARS.CP_KOD.EXPIRY IS 'ʳ������ ��� ������������';
COMMENT ON COLUMN BARS.CP_KOD.VNCRP IS '���������� ���';




PROMPT *** Create  constraint FX_CP_KOD_IDT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FX_CP_KOD_IDT FOREIGN KEY (IDT)
	  REFERENCES BARS.CP_TYPE (IDT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.CC_TIPD (TIPD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_EMI ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_EMI FOREIGN KEY (EMI)
	  REFERENCES BARS.CP_EMI (EMI) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_DOX ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_DOX FOREIGN KEY (DOX)
	  REFERENCES BARS.CP_DOX (DOX) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CP_KOD_VR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT CP_KOD_VR FOREIGN KEY (AMORT)
	  REFERENCES BARS.CP_VR (VR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_HIERARCHY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_HIERARCHY FOREIGN KEY (HIERARCHY_ID)
	  REFERENCES BARS.CP_HIERARCHY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CP_KOD_BASEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT CP_KOD_BASEY FOREIGN KEY (BASEY)
	  REFERENCES BARS.BASEY (BASEY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CP_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT XPK_CP_KOD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001959467 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (DAT_EM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001959466 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001959465 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (CP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001959464 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_KOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_KOD ON BARS.CP_KOD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_CP_ID_CP_KOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XAK_CP_ID_CP_KOD ON BARS.CP_KOD (CP_ID, DAT_EM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_KOD ***
grant SELECT                                                                 on CP_KOD          to BARSUPL;
grant FLASHBACK,SELECT                                                       on CP_KOD          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_KOD          to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_KOD          to CP_ROLE;
grant SELECT                                                                 on CP_KOD          to RPBN001;
grant SELECT                                                                 on CP_KOD          to UPLD;
grant FLASHBACK,SELECT                                                       on CP_KOD          to WR_REFREAD;



PROMPT *** Create SYNONYM  to CP_KOD ***

  CREATE OR REPLACE PUBLIC SYNONYM CP_KOD FOR BARS.CP_KOD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_KOD.sql =========*** End *** ======
PROMPT ===================================================================================== 
