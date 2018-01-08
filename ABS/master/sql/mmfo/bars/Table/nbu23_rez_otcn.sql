

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU23_REZ_OTCN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBU23_REZ_OTCN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU23_REZ_OTCN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NBU23_REZ_OTCN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBU23_REZ_OTCN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBU23_REZ_OTCN ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBU23_REZ_OTCN 
   (	FDAT DATE, 
	ID VARCHAR2(50), 
	RNK NUMBER, 
	NBS CHAR(4), 
	KV NUMBER, 
	ND NUMBER, 
	CC_ID VARCHAR2(50), 
	ACC NUMBER, 
	NLS VARCHAR2(20), 
	BRANCH VARCHAR2(30), 
	FIN NUMBER, 
	OBS NUMBER, 
	KAT NUMBER, 
	K NUMBER, 
	IRR NUMBER, 
	ZAL NUMBER, 
	BV NUMBER, 
	PV NUMBER, 
	REZ NUMBER, 
	REZQ NUMBER, 
	DD CHAR(1), 
	DDD CHAR(3), 
	BVQ NUMBER, 
	CUSTTYPE NUMBER, 
	IDR NUMBER, 
	WDATE DATE, 
	OKPO NUMBER, 
	NMK VARCHAR2(35), 
	RZ NUMBER, 
	PAWN NUMBER, 
	ISTVAL NUMBER, 
	R013 CHAR(1), 
	REZN NUMBER, 
	REZNQ NUMBER, 
	ARJK NUMBER, 
	PVZ NUMBER, 
	PVZQ NUMBER, 
	ZALQ NUMBER, 
	ZPR NUMBER, 
	ZPRQ NUMBER, 
	PVQ NUMBER, 
	RU VARCHAR2(70), 
	INN VARCHAR2(20), 
	NRC VARCHAR2(70), 
	SDATE DATE, 
	IR NUMBER, 
	S031 VARCHAR2(2), 
	K040 VARCHAR2(3), 
	PROD VARCHAR2(50), 
	K110 VARCHAR2(5), 
	K070 VARCHAR2(5), 
	K051 VARCHAR2(2), 
	S260 VARCHAR2(2), 
	R011 VARCHAR2(1), 
	R012 VARCHAR2(1), 
	S240 VARCHAR2(1), 
	S180 VARCHAR2(1), 
	S580 VARCHAR2(1), 
	NLS_REZ VARCHAR2(15), 
	NLS_REZN VARCHAR2(15), 
	S250 CHAR(1), 
	ACC_REZ NUMBER, 
	FIN_R NUMBER(*,0), 
	DISKONT NUMBER, 
	ISP NUMBER(*,0), 
	OB22 CHAR(2), 
	TIP CHAR(3), 
	SPEC CHAR(1), 
	ZAL_BL NUMBER, 
	S280_290 CHAR(1), 
	ZAL_BLQ NUMBER, 
	REZD NUMBER, 
	ACC_REZN NUMBER, 
	OB22_REZ CHAR(2), 
	OB22_REZN CHAR(2), 
	IR0 NUMBER, 
	IRR0 NUMBER, 
	ND_CP VARCHAR2(40), 
	SUM_IMP NUMBER, 
	SUMQ_IMP NUMBER, 
	PV_ZAL NUMBER, 
	VKR VARCHAR2(10), 
	S_L NUMBER, 
	SQ_L NUMBER, 
	ZAL_SV NUMBER, 
	ZAL_SVQ NUMBER, 
	GRP NUMBER(*,0), 
	KOL_SP NUMBER(*,0), 
	REF NUMBER(*,0), 
	PVP NUMBER, 
	BV_30 NUMBER, 
	BVQ_30 NUMBER, 
	REZ_30 NUMBER, 
	REZQ_30 NUMBER, 
	NLS_REZ_30 VARCHAR2(15), 
	ACC_REZ_30 NUMBER, 
	OB22_REZ_30 CHAR(2), 
	BV_0 NUMBER, 
	BVQ_0 NUMBER, 
	REZ_0 NUMBER, 
	REZQ_0 NUMBER, 
	NLS_REZ_0 VARCHAR2(15), 
	ACC_REZ_0 NUMBER, 
	OB22_REZ_0 CHAR(2), 
	KAT39 NUMBER, 
	REZ39 NUMBER, 
	REZQ39 NUMBER, 
	S250_39 VARCHAR2(1), 
	REZ23 NUMBER, 
	REZQ23 NUMBER, 
	KAT23 NUMBER, 
	S250_23 VARCHAR2(1), 
	DAT_MI DATE, 
	TIPA NUMBER(*,0), 
	BVUQ NUMBER, 
	BVU NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	KL_351 NUMBER, 
	EAD NUMBER, 
	EADQ NUMBER, 
	CR NUMBER, 
	CRQ NUMBER, 
	FIN_351 NUMBER, 
	KOL_351 NUMBER, 
	KPZ NUMBER, 
	LGD NUMBER, 
	OVKR VARCHAR2(50), 
	P_DEF VARCHAR2(50), 
	OVD VARCHAR2(50), 
	OPD VARCHAR2(50), 
	ZAL_351 NUMBER, 
	ZALQ_351 NUMBER, 
	RC NUMBER, 
	RCQ NUMBER, 
	CCF NUMBER, 
	TIP_351 NUMBER, 
	PD_0 NUMBER, 
	FIN_Z NUMBER, 
	ISTVAL_351 NUMBER(1,0), 
	RPB NUMBER, 
	S080 VARCHAR2(1), 
	S080_Z VARCHAR2(1), 
	DDD_6B CHAR(3), 
	FIN_P NUMBER(*,0), 
	FIN_D NUMBER(*,0), 
	Z NUMBER, 
	PD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBU23_REZ_OTCN ***
 exec bpa.alter_policies('NBU23_REZ_OTCN');


COMMENT ON TABLE BARS.NBU23_REZ_OTCN IS '������� ���������� ������� (��������� 23)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.FIN_P IS '������������ ���� � ��. �����.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.FIN_D IS '������������ ���� �� ��䳿/������ �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.KL_351 IS '����.�������� ������������ (351)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.BVUQ IS '����������� ���.����.���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.EAD IS '(BV - SNA) = EAD(���.) ���������� �� ���-��� �� ���� ������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.EADQ IS '(BVQ - SNAQ) = EADQ(���.) ���������� �� ���-��� �� ���� ������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.CR IS '��������� ����� CR (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.CRQ IS '��������� ����� CRQ (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.FIN_351 IS '������������ ���� (351)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.KOL_351 IS '�-�� ��� ���������� (351)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.KPZ IS '����-� �������� ������������� (���)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.LGD IS '������ � ��� ������� (LGD)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.OVKR IS '������ �������� ���������� ������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.P_DEF IS '��䳿 �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.OVD IS '������ �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.OPD IS '������ ���������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ZAL_351 IS 'г���� ���������� ����� �� ������� ��������� ������������ ���.(CV*k)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ZALQ_351 IS 'г���� ���������� ����� �� ������� ��������� ������������ ���.(CV*k)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.RC IS 'г���� ���������� ����� �� ������� ����� ���������� ���.(RC)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.RCQ IS 'г���� ���������� ����� �� ������� ����� ���������� ���.(RCQ)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.CCF IS '���������� �������� ������� (CCF)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.TIP_351 IS '��� ������ 351 ���������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.PD_0 IS '���������� (PD=0)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.FIN_Z IS '���� �����������, ���������� �� ����� ������������� ���������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ISTVAL_351 IS '������� ������� ������� ����� � ���������� 351';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.RPB IS 'г���� �������� �����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S080 IS '�������� ���.����� �� FIN_351';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S080_Z IS '�������� ���.����� �� FIN_Z';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.DDD_6B IS 'DDD ��� ����� #6B';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.Z IS '������������ ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.PD IS '����. ��������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.BVU IS '����������� ���.����.���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.KF IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.FDAT IS '����� ���� (01.MM.DDDD)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ID IS '���� ����:���+��';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.RNK IS '���. � ��';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.NBS IS '���.���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.KV IS '���. �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ND IS '���. ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.CC_ID IS '����� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ACC IS '�������� ����� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.NLS IS '����� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.BRANCH IS '����� �������� �����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.FIN IS 'Գ�������� ���� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.OBS IS '�������������� �����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.KAT IS '��������.�����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.K IS '�������� ������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.IRR IS '���.% ������ �� - ��������������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ZAL IS '�i����� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.BV IS '��������� ������� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.PV IS '�������� ������� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZ IS '������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZQ IS '������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.DD IS '��������� ������� 2-��,3-��';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.DDD IS '��� ���������� ������� (�������)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.BVQ IS '���.���� ������� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.CUSTTYPE IS '��� �볺���';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.IDR IS '������.�������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.WDATE IS '���� ��������� 䳿 ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.OKPO IS '���� �볺���';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.NMK IS '����� �볺���';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.RZ IS '������������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.PAWN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ISTVAL IS '������� ������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.R013 IS 'R013 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZN IS '������ ���. (�� ����������� � ����������� ���.) ';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZNQ IS '������ ���. (�� ����������� � ����������� ���.) ';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ARJK IS '��������� �� ���� ����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.PVZ IS '��������� (������� ��� ��� �����.����) ������������, ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.PVZQ IS '��������� (������� ��� ��� �����.����) ������������, ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ZALQ IS '�i����� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ZPR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ZPRQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.PVQ IS '�������� ������� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.RU IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.INN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.NRC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.SDATE IS '���� ������� 䳿 ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.IR IS '���.% �� �� - ����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S031 IS 'S031 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.K040 IS 'K040 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.PROD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.K110 IS 'K110 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.K070 IS 'K070 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.K051 IS 'K051 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S260 IS 'S260 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.R011 IS 'R011 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.R012 IS 'R012 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S240 IS 'S240 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S180 IS 'S180 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S580 IS 'S580 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.NLS_REZ IS '������� ������� ����. � �����������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.NLS_REZN IS '������� ������� �� ����. � �����������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S250 IS 'S250 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ACC_REZ IS '�������� ����� ������� ������� ����. � �����������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.FIN_R IS 'Գ�.���� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.DISKONT IS '���� ��������� ��� �� ������� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ISP IS '���������� �� ������� ������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.OB22 IS 'OB22 ��� ������� ������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.TIP IS '��� �������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.SPEC IS '����.������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ZAL_BL IS '��������� ���� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S280_290 IS '��� ���������� ���� ���������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ZAL_BLQ IS '��������� ���� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ACC_REZN IS '�������� ����� ������� ������� �� ����. � �����������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.OB22_REZ IS 'OB22 ��� ������� ������� ����.� �����������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.OB22_REZN IS 'OB22 ��� ������� ������� �� ����.� �����������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.IR0 IS '���.% ������ ���. - ���������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.IRR0 IS '���.% ������ �� - ���������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ND_CP IS '���.�������� ��� ����������� �� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.SUM_IMP IS '������� �� ���������� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.SUMQ_IMP IS '������� �� ���������� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.PV_ZAL IS '�����*�';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.VKR IS '�����.����.�������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S_L IS '�����*����.����.-������� �� ����.(���.)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.SQ_L IS '�����*����.����.-������� �� ����.(���.)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ZAL_SV IS '����������� ������� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ZAL_SVQ IS '����������� ������� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.GRP IS '����� ������ ������������ ������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.KOL_SP IS 'ʳ������ ��� ����������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REF IS '���. ���������� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.PVP IS '���� ���������� �������� �������� ������ �� �������� �������� �� �������� ';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.BV_30 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.BVQ_30 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZ_30 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZQ_30 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.NLS_REZ_30 IS '���� ������� �� ���.% �����.>30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ACC_REZ_30 IS 'acc ����� ������� �� ���.% �����.>30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.OB22_REZ_30 IS 'Ob22 ����� ������� �� ���.% �����.>30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.BV_0 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.BVQ_0 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZ_0 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZQ_0 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.NLS_REZ_0 IS '���� ������� �� ���.% �����.<30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.ACC_REZ_0 IS 'acc ����� ������� �� ���.% �����.<30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.OB22_REZ_0 IS 'Ob22 ����� ������� �� ���.% �����.<30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.KAT39 IS '��������� ����� �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZ39 IS '����� ������� (���.) �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZQ39 IS '����� ������� (���.) �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S250_39 IS '����� ������� ������� �� �������������� ��� ������������ ������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZ23 IS '����� ������� �� 23 ���� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.REZQ23 IS '����� ������� �� 23 ���� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.KAT23 IS '��������� ����� �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.S250_23 IS '����� ������� ������� �� �������������� ��� ������������ ������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.DAT_MI IS '���� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ_OTCN.TIPA IS '���.������';




PROMPT *** Create  constraint CC_NBU23REZOTCN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ_OTCN MODIFY (KF CONSTRAINT CC_NBU23REZOTCN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBU23_REZ_OTCN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NBU23_REZ_OTCN  to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on NBU23_REZ_OTCN  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBU23_REZ_OTCN  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBU23_REZ_OTCN  to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBU23_REZ_OTCN  to START1;
grant SELECT                                                                 on NBU23_REZ_OTCN  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBU23_REZ_OTCN.sql =========*** End **
PROMPT ===================================================================================== 
