

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LICCORPC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LICCORPC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LICCORPC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_LICCORPC 
   (	ROWTYPE NUMBER, 
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
	TT VARCHAR2(3)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LICCORPC ***
 exec bpa.alter_policies('TMP_LICCORPC');


COMMENT ON TABLE BARS.TMP_LICCORPC IS '��������� ������� ��� ������������ ������� �� ����. ��������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OBDB IS '������� ������� � �����';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OBDBQ IS '������� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OBKR IS '�������� ������� � �����';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OBKRQ IS '�������� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OST IS '�������� ������� � �����';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OSTQ IS '�������� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KOD_CORP IS '��� �������������� �볺���';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KOD_USTAN IS '��� �������� �������������� �볺���';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KOD_ANALYT IS '��� ����������� �����';
COMMENT ON COLUMN BARS.TMP_LICCORPC.DAPP IS '���� ������������ ���� �� �������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.POSTDAT IS '���� ���������� � ��� (���� ���� �� ������� ��� ������� �� �������)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.DOCDAT IS '���� ���������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.VALDAT IS '���� �����������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.ND IS '����� ���������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.VOB IS '��� ���������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.DK IS '�����/������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.MFOA IS '��� ����� ��������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NLSA IS '�������� ������� ��������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KVA IS '������ ��������� ������� ��������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NAMA IS '������������ �볺��� ��������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OKPOA IS '������������� �볺��� ��������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.MFOB IS '��� ����� ����������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NLSB IS '�������� ������� ����������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KVB IS '������ ��������� ������� ����������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NAMB IS '������������ �볺��� ����������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OKPOB IS '������������� �볺��� ����������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.S IS '���� ������� � �����';
COMMENT ON COLUMN BARS.TMP_LICCORPC.DOCKV IS '������ �������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.SQ IS '���� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NAZN IS '����������� �������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.DOCTYPE IS '������ ��������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.POSTTIME IS '��� ���������� � ��� ';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NAMK IS '������������ �볺���';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NMS IS '������������ �������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.TT IS '��� ��������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.ROWTYPE IS '������ �������/��������/�i������ ';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OURMFO IS '��� �����';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NLS IS '�������� ������� (������� �������  ��� ����������� �����)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KV IS '������ �������';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OKPO IS '��� ����';



PROMPT *** Create  grants  TMP_LICCORPC ***
grant SELECT                                                                 on TMP_LICCORPC    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LICCORPC    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LICCORPC    to RPBN001;
grant SELECT                                                                 on TMP_LICCORPC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LICCORPC.sql =========*** End *** 
PROMPT ===================================================================================== 
