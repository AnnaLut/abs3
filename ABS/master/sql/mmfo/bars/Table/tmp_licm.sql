

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LICM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LICM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LICM ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_LICM 
   (	FDAT DATE, 
	TIP CHAR(3), 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(38,0), 
	NMS VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	DAPP DATE, 
	ISP NUMBER, 
	OSTF NUMBER, 
	OSTFQ NUMBER, 
	OSTFR NUMBER, 
	DOS NUMBER, 
	KOS NUMBER, 
	DOSQ NUMBER, 
	KOSQ NUMBER, 
	DOSR NUMBER, 
	KOSR NUMBER, 
	REF NUMBER, 
	NLS2 VARCHAR2(14), 
	MFO2 VARCHAR2(6), 
	NB2 VARCHAR2(38), 
	NMK2 VARCHAR2(70), 
	OKPO2 VARCHAR2(14), 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	ND VARCHAR2(10), 
	NAZN VARCHAR2(230), 
	TT CHAR(3), 
	SK NUMBER, 
	VOB NUMBER, 
	BIS NUMBER, 
	DK NUMBER, 
	DATD DATE, 
	DATP DATE, 
	VDAT DATE, 
	USERID NUMBER, 
	BRANCH VARCHAR2(30), 
	ROWTYPE NUMBER, 
	GRPLIST VARCHAR2(70), 
	D_REC VARCHAR2(60), 
	REFNLS VARCHAR2(14), 
	NLSALT VARCHAR2(15)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LICM ***
 exec bpa.alter_policies('TMP_LICM');


COMMENT ON TABLE BARS.TMP_LICM IS '��������� ������� ��� ���������� �� ��������';
COMMENT ON COLUMN BARS.TMP_LICM.NLSALT IS '�������������� ����� �����';
COMMENT ON COLUMN BARS.TMP_LICM.FDAT IS '���� �������� �� �����';
COMMENT ON COLUMN BARS.TMP_LICM.TIP IS '���  �����';
COMMENT ON COLUMN BARS.TMP_LICM.ACC IS 'acc �����';
COMMENT ON COLUMN BARS.TMP_LICM.NLS IS '������� ���� �������';
COMMENT ON COLUMN BARS.TMP_LICM.KV IS '������ ����� �������';
COMMENT ON COLUMN BARS.TMP_LICM.NMS IS '������������ ���� �������';
COMMENT ON COLUMN BARS.TMP_LICM.OKPO IS '���� ������� �����';
COMMENT ON COLUMN BARS.TMP_LICM.NMK IS '������������ ������� �����';
COMMENT ON COLUMN BARS.TMP_LICM.DAPP IS '����� ����. �������� �� ����� �������';
COMMENT ON COLUMN BARS.TMP_LICM.ISP IS '����������� �����';
COMMENT ON COLUMN BARS.TMP_LICM.OSTF IS '�������� ������� �� ���� ��������';
COMMENT ON COLUMN BARS.TMP_LICM.OSTFQ IS '�������� �������(�����) �� ���� ��������';
COMMENT ON COLUMN BARS.TMP_LICM.OSTFR IS '�������� �������(� �����������) �� ���� ��������';
COMMENT ON COLUMN BARS.TMP_LICM.DOS IS '������� �����';
COMMENT ON COLUMN BARS.TMP_LICM.KOS IS '������� ������';
COMMENT ON COLUMN BARS.TMP_LICM.DOSQ IS '������� ����� (�����)';
COMMENT ON COLUMN BARS.TMP_LICM.KOSQ IS '������� ������ (�����)';
COMMENT ON COLUMN BARS.TMP_LICM.DOSR IS '������� ����� (� �����������)';
COMMENT ON COLUMN BARS.TMP_LICM.KOSR IS '������� ������ (� �����������)';
COMMENT ON COLUMN BARS.TMP_LICM.REF IS '���. ���������';
COMMENT ON COLUMN BARS.TMP_LICM.NLS2 IS '���� ��������������';
COMMENT ON COLUMN BARS.TMP_LICM.MFO2 IS '��� ��������������';
COMMENT ON COLUMN BARS.TMP_LICM.NB2 IS '������������ ����� ��������������';
COMMENT ON COLUMN BARS.TMP_LICM.NMK2 IS '������������ ��������������';
COMMENT ON COLUMN BARS.TMP_LICM.OKPO2 IS '���� ��������������';
COMMENT ON COLUMN BARS.TMP_LICM.S IS '����� ���-��';
COMMENT ON COLUMN BARS.TMP_LICM.SQ IS '���������� ����� ���-��';
COMMENT ON COLUMN BARS.TMP_LICM.ND IS '� ���������';
COMMENT ON COLUMN BARS.TMP_LICM.NAZN IS '����������';
COMMENT ON COLUMN BARS.TMP_LICM.TT IS '��� ��������';
COMMENT ON COLUMN BARS.TMP_LICM.SK IS '������ ����. �����';
COMMENT ON COLUMN BARS.TMP_LICM.VOB IS '��� ���������';
COMMENT ON COLUMN BARS.TMP_LICM.BIS IS '����� ��� ������';
COMMENT ON COLUMN BARS.TMP_LICM.DK IS '������� �� (0-�������� �� �����, 1-���������� �� ����, >1-�������������� ������(����������� ������ � ��������� bars_rptlic.get_inform_docs))';
COMMENT ON COLUMN BARS.TMP_LICM.DATD IS '���� ����� ���������';
COMMENT ON COLUMN BARS.TMP_LICM.DATP IS '���� ������ ���������';
COMMENT ON COLUMN BARS.TMP_LICM.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_LICM.USERID IS '��� ����������� ���������';
COMMENT ON COLUMN BARS.TMP_LICM.BRANCH IS '��������, � ���. ��� ������ ���-�';
COMMENT ON COLUMN BARS.TMP_LICM.ROWTYPE IS '';
COMMENT ON COLUMN BARS.TMP_LICM.GRPLIST IS '������ �������� ����� � ���. ������ ����';
COMMENT ON COLUMN BARS.TMP_LICM.D_REC IS '';
COMMENT ON COLUMN BARS.TMP_LICM.REFNLS IS '������� ���� �� �������� ��� �������� ������(���� ������� �������� �� ������������� ����� - �� ���������)';



PROMPT *** Create  grants  TMP_LICM ***
grant SELECT                                                                 on TMP_LICM        to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_LICM        to BARS_ACCESS_DEFROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_LICM        to RPBN001;
grant SELECT                                                                 on TMP_LICM        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LICM.sql =========*** End *** ====
PROMPT ===================================================================================== 
