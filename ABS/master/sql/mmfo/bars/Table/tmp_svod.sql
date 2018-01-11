

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SVOD.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SVOD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SVOD ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SVOD 
   (	ID NUMBER(*,0), 
	USERID NUMBER(38,0), 
	FIO VARCHAR2(50), 
	KL CHAR(1), 
	KV1 NUMBER(38,0), 
	FDAT DATE, 
	TT VARCHAR2(5), 
	NAMTT VARCHAR2(30), 
	REF NUMBER(*,0), 
	STMT NUMBER(*,0), 
	KV NUMBER(38,0), 
	NLS VARCHAR2(15), 
	S NUMBER(38,0), 
	SQ NUMBER(38,0), 
	NAMEOT VARCHAR2(70), 
	PT VARCHAR2(30), 
	TECH NUMBER(38,0), 
	DK NUMBER(38,0), 
	NLSB VARCHAR2(15), 
	OTD VARCHAR2(30), 
	SK NUMBER(38,0), 
	SKK NUMBER(38,0), 
	SD NUMBER(38,0), 
	SDD NUMBER(38,0), 
	KAS NUMBER(38,0), 
	NAZN VARCHAR2(160)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SVOD ***
 exec bpa.alter_policies('TMP_SVOD');


COMMENT ON TABLE BARS.TMP_SVOD IS '��������� �� �������� ������� ���� ���������� ���';
COMMENT ON COLUMN BARS.TMP_SVOD.ID IS '��� ������������ ������������ �����';
COMMENT ON COLUMN BARS.TMP_SVOD.USERID IS '��� ������������, ����������� ��������';
COMMENT ON COLUMN BARS.TMP_SVOD.FIO IS '��� ������������ ����������� ��������';
COMMENT ON COLUMN BARS.TMP_SVOD.KL IS '������� �-9';
COMMENT ON COLUMN BARS.TMP_SVOD.KV1 IS '�������������� ������� =2 - ������ =1 -������';
COMMENT ON COLUMN BARS.TMP_SVOD.FDAT IS '���� �� ������� ���������';
COMMENT ON COLUMN BARS.TMP_SVOD.TT IS '��� ��������';
COMMENT ON COLUMN BARS.TMP_SVOD.NAMTT IS '�������� ��������';
COMMENT ON COLUMN BARS.TMP_SVOD.REF IS '��������';
COMMENT ON COLUMN BARS.TMP_SVOD.STMT IS '���������� ��� ��������';
COMMENT ON COLUMN BARS.TMP_SVOD.KV IS '��� ������';
COMMENT ON COLUMN BARS.TMP_SVOD.NLS IS '����� �����';
COMMENT ON COLUMN BARS.TMP_SVOD.S IS '����� � ��������';
COMMENT ON COLUMN BARS.TMP_SVOD.SQ IS '���-���������� �����';
COMMENT ON COLUMN BARS.TMP_SVOD.NAMEOT IS '�������� ������';
COMMENT ON COLUMN BARS.TMP_SVOD.PT IS '�������� ������ ����������  (����_���������)';
COMMENT ON COLUMN BARS.TMP_SVOD.TECH IS '������� ��� ����������� �� ���������������';
COMMENT ON COLUMN BARS.TMP_SVOD.DK IS '��-��';
COMMENT ON COLUMN BARS.TMP_SVOD.NLSB IS '����- ������������� ��� �����';
COMMENT ON COLUMN BARS.TMP_SVOD.OTD IS '����� ������';
COMMENT ON COLUMN BARS.TMP_SVOD.SK IS '����� ����� �� �������� ���������';
COMMENT ON COLUMN BARS.TMP_SVOD.SKK IS '����� ���������� �� �������� ����������';
COMMENT ON COLUMN BARS.TMP_SVOD.SD IS '����� ����� �� �������� ���������';
COMMENT ON COLUMN BARS.TMP_SVOD.SDD IS '����� ���������� �� �������� ���������';
COMMENT ON COLUMN BARS.TMP_SVOD.KAS IS '������� ���-����� �������� =1 �� ���,=2 ���';
COMMENT ON COLUMN BARS.TMP_SVOD.NAZN IS '���������� �������';



PROMPT *** Create  grants  TMP_SVOD ***
grant SELECT                                                                 on TMP_SVOD        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SVOD        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SVOD        to RPBN001;
grant SELECT                                                                 on TMP_SVOD        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_SVOD        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_SVOD ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_SVOD FOR BARS.TMP_SVOD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SVOD.sql =========*** End *** ====
PROMPT ===================================================================================== 
