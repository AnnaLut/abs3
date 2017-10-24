

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU23_REZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBU23_REZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU23_REZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBU23_REZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBU23_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBU23_REZ 
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
	REZD NUMBER, 
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
	REZ39 NUMBER, 
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
	EAD NUMBER, 
	EADQ NUMBER, 
	CR NUMBER, 
	CRQ NUMBER, 
	FIN_351 NUMBER, 
	KOL_351 NUMBER, 
	KPZ NUMBER, 
	KL_351 NUMBER, 
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




PROMPT *** ALTER_POLICIES to NBU23_REZ ***
 exec bpa.alter_policies('NBU23_REZ');


COMMENT ON TABLE BARS.NBU23_REZ IS '�������� ������ ��� �� ���-23';
COMMENT ON COLUMN BARS.NBU23_REZ.PD_0 IS '���������� (PD=0)';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_Z IS '���� �����������, ���������� �� ����� ������������� ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.ISTVAL_351 IS '������� ������� ������� ����� � ���������� 351';
COMMENT ON COLUMN BARS.NBU23_REZ.RPB IS 'г���� �������� �����';
COMMENT ON COLUMN BARS.NBU23_REZ.S080 IS '�������� ���.����� �� FIN_351';
COMMENT ON COLUMN BARS.NBU23_REZ.S080_Z IS '�������� ���.����� �� FIN_Z';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_P IS '������������ ���� � ��. �����.';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_D IS '������������ ���� �� ��䳿/������ �������';
COMMENT ON COLUMN BARS.NBU23_REZ.Z IS '������������ ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.PD IS '����. ��������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.KPZ IS '����-� �������� ������������� (���)';
COMMENT ON COLUMN BARS.NBU23_REZ.KL_351 IS '����.�������� ������������ (351)';
COMMENT ON COLUMN BARS.NBU23_REZ.LGD IS '������ � ��� ������� (LGD)';
COMMENT ON COLUMN BARS.NBU23_REZ.OVKR IS '������ �������� ���������� ������';
COMMENT ON COLUMN BARS.NBU23_REZ.P_DEF IS '��䳿 �������';
COMMENT ON COLUMN BARS.NBU23_REZ.OVD IS '������ �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.OPD IS '������ ���������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_351 IS 'г���� ���������� ����� �� ������� ��������� ������������ ���.(CV*k)';
COMMENT ON COLUMN BARS.NBU23_REZ.ZALQ_351 IS 'г���� ���������� ����� �� ������� ��������� ������������ ���.(CV*k)';
COMMENT ON COLUMN BARS.NBU23_REZ.RC IS 'г���� ���������� ����� �� ������� ����� ���������� ���.(RC)';
COMMENT ON COLUMN BARS.NBU23_REZ.RCQ IS 'г���� ���������� ����� �� ������� ����� ���������� ���.(RCQ)';
COMMENT ON COLUMN BARS.NBU23_REZ.CCF IS '���������� �������� ������� (CCF)';
COMMENT ON COLUMN BARS.NBU23_REZ.TIP_351 IS '��� ������ 351 ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.DDD_6B IS 'DDD ��� ����� #6B';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZ_0 IS '���� ������� �� ���.% �����.<30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZ_0 IS 'acc ����� ������� �� ���.% �����.<30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZ_0 IS 'Ob22 ����� ������� �� ���.% �����.<30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.KAT39 IS '��������� ����� �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ39 IS '����� ������� (���.) �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.S250_39 IS '����� ������� ������� �� �������������� ��� ������������ ������';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ23 IS '����� ������� �� 23 ���� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ23 IS '����� ������� �� 23 ���� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.KAT23 IS '��������� ����� �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.S250_23 IS '����� ������� ������� �� �������������� ��� ������������ ������';
COMMENT ON COLUMN BARS.NBU23_REZ.DAT_MI IS '���� �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.BVUQ IS '����������� ���.����.���.';
COMMENT ON COLUMN BARS.NBU23_REZ.BVU IS '����������� ���.����.���.';
COMMENT ON COLUMN BARS.NBU23_REZ.TIPA IS '���.������';
COMMENT ON COLUMN BARS.NBU23_REZ.EAD IS '(BV - SNA) - EAD(���.) ���������� �� ���-��� �� ���� ������';
COMMENT ON COLUMN BARS.NBU23_REZ.EADQ IS '(BVQ - SNAQ) - EADQ(���.) ���������� �� ���-��� �� ���� ������';
COMMENT ON COLUMN BARS.NBU23_REZ.CR IS '��������� ����� CR (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.CRQ IS '��������� ����� CRQ (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_351 IS '������������ ���� (351)';
COMMENT ON COLUMN BARS.NBU23_REZ.KOL_351 IS '�-�� ��� ���������� (351)';
COMMENT ON COLUMN BARS.NBU23_REZ.FDAT IS '��.����(01.11.2012.';
COMMENT ON COLUMN BARS.NBU23_REZ.ID IS '���� ����:���+��';
COMMENT ON COLUMN BARS.NBU23_REZ.RNK IS '��� � ��';
COMMENT ON COLUMN BARS.NBU23_REZ.NBS IS '���.���';
COMMENT ON COLUMN BARS.NBU23_REZ.KV IS '��� ���';
COMMENT ON COLUMN BARS.NBU23_REZ.ND IS '��� ���';
COMMENT ON COLUMN BARS.NBU23_REZ.CC_ID IS '��.���';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC IS '��� ���';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS IS '� ���';
COMMENT ON COLUMN BARS.NBU23_REZ.BRANCH IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN IS '���.����';
COMMENT ON COLUMN BARS.NBU23_REZ.OBS IS '�����.';
COMMENT ON COLUMN BARS.NBU23_REZ.KAT IS '���.�����';
COMMENT ON COLUMN BARS.NBU23_REZ.K IS '���.�����';
COMMENT ON COLUMN BARS.NBU23_REZ.IRR IS '���.% �� �� - ��������������';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL IS '��������.';
COMMENT ON COLUMN BARS.NBU23_REZ.BV IS '���.����';
COMMENT ON COLUMN BARS.NBU23_REZ.PV IS '�����.����';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ IS '���-���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ IS '���-���.';
COMMENT ON COLUMN BARS.NBU23_REZ.DD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.DDD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ZPR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ZPRQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PVQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.RU IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.INN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.NRC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PVZQ IS '��������� (������� ��� ��� �����.����) ������������, ��� � 1.00';
COMMENT ON COLUMN BARS.NBU23_REZ.ZALQ IS '�i��.�����~���~ZALq';
COMMENT ON COLUMN BARS.NBU23_REZ.SDATE IS '���� ������ ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.IR IS '���.% �� �� - �������';
COMMENT ON COLUMN BARS.NBU23_REZ.S031 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.K040 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PROD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.K110 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.BVQ IS '���.���� ������, ��� � 1.00';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ_30 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ_30 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZ_30 IS '���� ������� �� ���.% �����.>30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZ_30 IS 'acc ����� ������� �� ���.% �����.>30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZ_30 IS 'Ob22 ����� ������� �� ���.% �����.>30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.IDR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.WDATE IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.OKPO IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.NMK IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.RZ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PAWN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ISTVAL IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.R013 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.REZN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.REZNQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ARJK IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.REZD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.K070 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.BV_0 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.BVQ_0 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ_0 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ_0 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.K051 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S260 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.R011 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.R012 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S240 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S180 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S580 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PVZ IS '��������� (������� ��� ��� �����.����) ������������, ��� � 1.00';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_SV IS '����������� ������� ������������ (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_SVQ IS '����������� ������� ������������ (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.SUM_IMP IS '������� �� ���������� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.SUMQ_IMP IS '������� �� ���������� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.PV_ZAL IS '�����*�';
COMMENT ON COLUMN BARS.NBU23_REZ.VKR IS '�����.����.�������';
COMMENT ON COLUMN BARS.NBU23_REZ.S_L IS '�����*����.����.-������� �� ����.(���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.SQ_L IS '�����*����.����.-������� �� ����.(���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.GRP IS '����� ������ ������������ ������';
COMMENT ON COLUMN BARS.NBU23_REZ.KOL_SP IS 'ʳ������ ��� ����������';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ39 IS '����� ������� (���.) �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.PVP IS '���� ���������� �������� �������� ������ �� �������� �������� �� �������� ';
COMMENT ON COLUMN BARS.NBU23_REZ.BV_30 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.BVQ_30 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.ND_CP IS '���.�������� ��� ����������� �� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.IR0 IS '���.% �� �� - ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.IRR0 IS '���.% �� �� - ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.S250 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S280_290 IS '��� ���������� ���� ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_BLQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZN IS 'ACC ����� ������� �� ���.� ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZ IS 'OB22 ��� ����� ������� ���.� ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZN IS 'OB22 ��� ����� ������� �� ���.� ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_R IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.DISKONT IS '���� ��������� ��� �� ������� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.TIP IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.SPEC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_BL IS '���� ������ ����������';
COMMENT ON COLUMN BARS.NBU23_REZ.ISP IS '���������� �� ������� ������';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZ IS '���� ��������� ��� �� ������� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZ IS '������� ��� �i�����~���~NLS_REZ';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZN IS '������� ��� �i�����~���(���)~NLS_REZN';




PROMPT *** Create  constraint PK_NBU23REZ_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ ADD CONSTRAINT PK_NBU23REZ_ID PRIMARY KEY (FDAT, ID, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBU23REZ_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBU23REZ_ID ON BARS.NBU23_REZ (FDAT, ID, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_NBU23REZ ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_NBU23REZ ON BARS.NBU23_REZ (FDAT, RNK, ND, KAT, KV, RZ, DDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_NBU23REZ ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_NBU23REZ ON BARS.NBU23_REZ (FDAT, ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_NBU23REZ ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_NBU23REZ ON BARS.NBU23_REZ (FDAT, ACC, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBU23_REZ ***
grant SELECT                                                                 on NBU23_REZ       to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on NBU23_REZ       to BARSUPL;
grant INSERT,SELECT,UPDATE                                                   on NBU23_REZ       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBU23_REZ       to BARS_SUP;
grant SELECT                                                                 on NBU23_REZ       to CIG_LOADER;
grant SELECT                                                                 on NBU23_REZ       to RPBN002;
grant INSERT,SELECT,UPDATE                                                   on NBU23_REZ       to START1;
grant SELECT                                                                 on NBU23_REZ       to UPLD;



PROMPT *** Create SYNONYM  to NBU23_REZ ***

  CREATE OR REPLACE PUBLIC SYNONYM NBU23_REZ_P FOR BARS.NBU23_REZ;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBU23_REZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
