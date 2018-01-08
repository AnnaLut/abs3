

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_DATA_TMP.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORPORATION_DATA_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORPORATION_DATA_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORPORATION_DATA_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORPORATION_DATA_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORPORATION_DATA_TMP 
   (	CORPORATION_ID NUMBER(5,0), 
	FILE_DATE DATE, 
	ROWTYPE NUMBER, 
	OURMFO VARCHAR2(6), 
	NLS VARCHAR2(14), 
	KV NUMBER, 
	OKPO VARCHAR2(14), 
	OBDB NUMBER, 
	OBDBQ NUMBER, 
	OBKR NUMBER, 
	OBKRQ NUMBER, 
	OST NUMBER, 
	OSTQ NUMBER, 
	KOD_CORP NUMBER, 
	KOD_USTAN NUMBER, 
	KOD_ANALYT VARCHAR2(4), 
	DAPP DATE, 
	POSTDAT DATE, 
	DOCDAT DATE, 
	VALDAT DATE, 
	ND VARCHAR2(10), 
	VOB NUMBER, 
	DK NUMBER, 
	MFOA VARCHAR2(6), 
	NLSA VARCHAR2(14), 
	KVA NUMBER, 
	NAMA VARCHAR2(70), 
	OKPOA VARCHAR2(14), 
	MFOB VARCHAR2(6), 
	NLSB VARCHAR2(14), 
	KVB NUMBER, 
	NAMB VARCHAR2(70), 
	OKPOB VARCHAR2(14), 
	S NUMBER, 
	DOCKV NUMBER, 
	SQ NUMBER, 
	NAZN VARCHAR2(160), 
	DOCTYPE NUMBER, 
	POSTTIME DATE, 
	NAMK VARCHAR2(70), 
	NMS VARCHAR2(70), 
	TT VARCHAR2(3), 
	SESSION_ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORPORATION_DATA_TMP ***
 exec bpa.alter_policies('OB_CORPORATION_DATA_TMP');


COMMENT ON TABLE BARS.OB_CORPORATION_DATA_TMP IS '������������� ������� ��������� �-����� � ��';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.CORPORATION_ID IS '������������� ����������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.FILE_DATE IS '����, �� ��� ��������� ������� �� ����������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.ROWTYPE IS '������ �������/��������/�i������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OURMFO IS '��� �����';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NLS IS '�������� ������� (������� �������  ��� ����������� �����)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KV IS '������ �������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OKPO IS '��� ����';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OBDB IS '������� ������� � �����';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OBDBQ IS '������� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OBKR IS '�������� ������� � �����';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OBKRQ IS '�������� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OST IS '�������� ������� � �����';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OSTQ IS '�������� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KOD_CORP IS '��� �������������� �볺���';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KOD_USTAN IS '��� �������� �������������� �볺���';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KOD_ANALYT IS '��� ����������� �����';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.DAPP IS '���� ������������ ���� �� �������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.POSTDAT IS '���� ���������� � ��� (���� ���� �� ������� ��� ������� �� �������)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.DOCDAT IS '���� ���������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.VALDAT IS '���� �����������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.ND IS '����� ���������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.VOB IS '��� ���������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.DK IS '�����/������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.MFOA IS '��� ����� ��������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NLSA IS '�������� ������� ��������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KVA IS '������ ��������� ������� ��������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NAMA IS '������������ �볺��� ��������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OKPOA IS '������������� �볺��� ��������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.MFOB IS '��� ����� ����������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NLSB IS '�������� ������� ����������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KVB IS '������ ��������� ������� ����������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NAMB IS '������������ �볺��� ����������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OKPOB IS '������������� �볺��� ����������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.S IS '���� ������� � �����';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.DOCKV IS '������ �������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.SQ IS '���� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NAZN IS '����������� �������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.DOCTYPE IS '������ ��������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.POSTTIME IS '��� ���������� � ���';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NAMK IS '������������ �볺���';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NMS IS '������������ �������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.TT IS '��� ��������';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.SESSION_ID IS '������������� ��� ������������ ����� � ��';




PROMPT *** Create  constraint SYS_C00109843 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_DATA_TMP MODIFY (CORPORATION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109844 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_DATA_TMP MODIFY (FILE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109845 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_DATA_TMP MODIFY (SESSION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OB_CORP_DATA_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.OB_CORP_DATA_IDX ON BARS.OB_CORPORATION_DATA_TMP (CORPORATION_ID, FILE_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OB_CORP_DATA_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.OB_CORP_DATA_IDX2 ON BARS.OB_CORPORATION_DATA_TMP (SESSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORPORATION_DATA_TMP ***
grant SELECT                                                                 on OB_CORPORATION_DATA_TMP to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on OB_CORPORATION_DATA_TMP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OB_CORPORATION_DATA_TMP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_DATA_TMP.sql =========*
PROMPT ===================================================================================== 
