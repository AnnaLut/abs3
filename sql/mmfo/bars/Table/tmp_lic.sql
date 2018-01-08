

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LIC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LIC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LIC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_LIC 
   (	ID NUMBER(38,0), 
	FDAT DATE, 
	ACC NUMBER(38,0), 
	PP NUMBER(38,0), 
	WD NUMBER(38,0), 
	S NUMBER(24,0), 
	ND VARCHAR2(10), 
	MFO VARCHAR2(12), 
	NAZN VARCHAR2(220), 
	VDAT DATE, 
	NLSK VARCHAR2(15), 
	NAMK VARCHAR2(38), 
	USERID NUMBER(38,0), 
	REF NUMBER(38,0), 
	TT CHAR(3), 
	SK NUMBER(38,0), 
	DAPP DATE, 
	DATP DATE, 
	OSTF NUMBER(24,0), 
	ISP NUMBER(38,0), 
	KV NUMBER(38,0), 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	NB VARCHAR2(38), 
	VOB NUMBER(38,0), 
	OSTI NUMBER(24,0), 
	DATD DATE, 
	BIS NUMBER(38,0), 
	OSTFQ NUMBER(24,0), 
	OSTIQ NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	DOSPQ NUMBER(24,0), 
	KOSPQ NUMBER(24,0), 
	OSTPF NUMBER(24,0), 
	OSTPI NUMBER(24,0), 
	OSTPFQ NUMBER(24,0), 
	OSTPIQ NUMBER(24,0), 
	DEB_PERE NUMBER(24,0), 
	CRD_PERE NUMBER(24,0), 
	NMK2 VARCHAR2(70), 
	NLSKALT VARCHAR2(14), 
	NLSALT VARCHAR2(14), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	PDAT DATE
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LIC ***
 exec bpa.alter_policies('TMP_LIC');


COMMENT ON TABLE BARS.TMP_LIC IS '��������� �������';
COMMENT ON COLUMN BARS.TMP_LIC.ID IS '������������� �����������';
COMMENT ON COLUMN BARS.TMP_LIC.FDAT IS '���� ���������';
COMMENT ON COLUMN BARS.TMP_LIC.ACC IS '������������� ����� �';
COMMENT ON COLUMN BARS.TMP_LIC.PP IS '??';
COMMENT ON COLUMN BARS.TMP_LIC.WD IS '??';
COMMENT ON COLUMN BARS.TMP_LIC.S IS '�����';
COMMENT ON COLUMN BARS.TMP_LIC.ND IS '����� ���������';
COMMENT ON COLUMN BARS.TMP_LIC.MFO IS '��� ����� �';
COMMENT ON COLUMN BARS.TMP_LIC.NAZN IS '���������� �������';
COMMENT ON COLUMN BARS.TMP_LIC.VDAT IS '���� �������������';
COMMENT ON COLUMN BARS.TMP_LIC.NLSK IS '����� ����� ��������������';
COMMENT ON COLUMN BARS.TMP_LIC.NAMK IS '������������ ��������������';
COMMENT ON COLUMN BARS.TMP_LIC.USERID IS '�� ������������� (��� ���� ��������)';
COMMENT ON COLUMN BARS.TMP_LIC.REF IS '����������';
COMMENT ON COLUMN BARS.TMP_LIC.TT IS '��� ���������� ����������';
COMMENT ON COLUMN BARS.TMP_LIC.SK IS '������ ���������';
COMMENT ON COLUMN BARS.TMP_LIC.DAPP IS '���� ���������� ��������';
COMMENT ON COLUMN BARS.TMP_LIC.DATP IS '���� �������';
COMMENT ON COLUMN BARS.TMP_LIC.OSTF IS '�������� ������� �� ����';
COMMENT ON COLUMN BARS.TMP_LIC.ISP IS '�����������';
COMMENT ON COLUMN BARS.TMP_LIC.KV IS '��� ������';
COMMENT ON COLUMN BARS.TMP_LIC.NLS IS '����� ����� �';
COMMENT ON COLUMN BARS.TMP_LIC.NMS IS '������������ ����� �';
COMMENT ON COLUMN BARS.TMP_LIC.OKPO IS '���� ����������.';
COMMENT ON COLUMN BARS.TMP_LIC.NB IS '������������ ����� �';
COMMENT ON COLUMN BARS.TMP_LIC.VOB IS '��� ���������';
COMMENT ON COLUMN BARS.TMP_LIC.OSTI IS '��������� ������� �� ����';
COMMENT ON COLUMN BARS.TMP_LIC.DATD IS '���� ���������';
COMMENT ON COLUMN BARS.TMP_LIC.BIS IS '���.';
COMMENT ON COLUMN BARS.TMP_LIC.OSTFQ IS '�������� ������� �� ����(���)';
COMMENT ON COLUMN BARS.TMP_LIC.OSTIQ IS '��������� ������� �� ����(���)';
COMMENT ON COLUMN BARS.TMP_LIC.DOSQ IS '���������� �������� ����� �� ���� (��� ����� ����������)';
COMMENT ON COLUMN BARS.TMP_LIC.KOSQ IS '���������� �������� ������ �� ���� (��� ����� ����������)';
COMMENT ON COLUMN BARS.TMP_LIC.DOSPQ IS '���������� �������� ����� �� ������ (��� ����� ����������)';
COMMENT ON COLUMN BARS.TMP_LIC.KOSPQ IS '���������� �������� ������ �� ������ (��� ����� ����������)';
COMMENT ON COLUMN BARS.TMP_LIC.OSTPF IS '�������� ������� �� ������';
COMMENT ON COLUMN BARS.TMP_LIC.OSTPI IS '��������� ������� �� ������';
COMMENT ON COLUMN BARS.TMP_LIC.OSTPFQ IS '�������� ������� �� ������(���)';
COMMENT ON COLUMN BARS.TMP_LIC.OSTPIQ IS '��������� ������� �� ������(���)';
COMMENT ON COLUMN BARS.TMP_LIC.DEB_PERE IS '���������� �����';
COMMENT ON COLUMN BARS.TMP_LIC.CRD_PERE IS '���������� ������';
COMMENT ON COLUMN BARS.TMP_LIC.NMK2 IS '';
COMMENT ON COLUMN BARS.TMP_LIC.NLSKALT IS '';
COMMENT ON COLUMN BARS.TMP_LIC.NLSALT IS '';
COMMENT ON COLUMN BARS.TMP_LIC.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_LIC.PDAT IS '';



PROMPT *** Create  grants  TMP_LIC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LIC         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LIC         to RPBN001;
grant SELECT                                                                 on TMP_LIC         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_LIC         to WR_ALL_RIGHTS;
grant SELECT                                                                 on TMP_LIC         to WR_CREPORTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LIC.sql =========*** End *** =====
PROMPT ===================================================================================== 
