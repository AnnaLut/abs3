

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU23_REZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBU23_REZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU23_REZ'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
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
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
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
	PVP NUMBER, 
	BV_30 NUMBER, 
	BVQ_30 NUMBER, 
	REZ_30 NUMBER, 
	REZQ_30 NUMBER, 
	NLS_REZ_30 VARCHAR2(15), 
	ACC_REZ_30 NUMBER, 
	BV_0 NUMBER, 
	BVQ_0 NUMBER, 
	REZ_0 NUMBER, 
	REZQ_0 NUMBER, 
	NLS_REZ_0 VARCHAR2(15), 
	ACC_REZ_0 NUMBER, 
	REZ39 NUMBER, 
	S250_23 VARCHAR2(1), 
	KAT39 NUMBER, 
	REZQ39 NUMBER, 
	S250_39 VARCHAR2(1), 
	REZ23 NUMBER, 
	REZQ23 NUMBER, 
	KAT23 NUMBER, 
	DAT_MI DATE, 
	OB22_REZ_30 CHAR(2), 
	OB22_REZ_0 CHAR(2), 
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
   ) PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC 
  TABLESPACE BRSBIGD 
  PARTITION BY RANGE (FDAT) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
  SUBPARTITION BY LIST (KF) 
  SUBPARTITION TEMPLATE ( 
    SUBPARTITION SP_300465 VALUES ( ''300465'' ), 
    SUBPARTITION SP_302076 VALUES ( ''302076'' ), 
    SUBPARTITION SP_303398 VALUES ( ''303398'' ), 
    SUBPARTITION SP_304665 VALUES ( ''304665'' ), 
    SUBPARTITION SP_305482 VALUES ( ''305482'' ), 
    SUBPARTITION SP_311647 VALUES ( ''311647'' ), 
    SUBPARTITION SP_312356 VALUES ( ''312356'' ), 
    SUBPARTITION SP_313957 VALUES ( ''313957'' ), 
    SUBPARTITION SP_315784 VALUES ( ''315784'' ), 
    SUBPARTITION SP_322669 VALUES ( ''322669'' ), 
    SUBPARTITION SP_323475 VALUES ( ''323475'' ), 
    SUBPARTITION SP_324805 VALUES ( ''324805'' ), 
    SUBPARTITION SP_325796 VALUES ( ''325796'' ), 
    SUBPARTITION SP_326461 VALUES ( ''326461'' ), 
    SUBPARTITION SP_328845 VALUES ( ''328845'' ), 
    SUBPARTITION SP_331467 VALUES ( ''331467'' ), 
    SUBPARTITION SP_333368 VALUES ( ''333368'' ), 
    SUBPARTITION SP_335106 VALUES ( ''335106'' ), 
    SUBPARTITION SP_336503 VALUES ( ''336503'' ), 
    SUBPARTITION SP_337568 VALUES ( ''337568'' ), 
    SUBPARTITION SP_338545 VALUES ( ''338545'' ), 
    SUBPARTITION SP_351823 VALUES ( ''351823'' ), 
    SUBPARTITION SP_352457 VALUES ( ''352457'' ), 
    SUBPARTITION SP_353553 VALUES ( ''353553'' ), 
    SUBPARTITION SP_354507 VALUES ( ''354507'' ), 
    SUBPARTITION SP_356334 VALUES ( ''356334'' ) ) 
 (PARTITION P_MINVALUE  VALUES LESS THAN (TO_DATE('' 2015-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) 
PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
 COMPRESS BASIC ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBU23_REZ ***
 exec bpa.alter_policies('NBU23_REZ');


COMMENT ON TABLE BARS.NBU23_REZ IS '������� ���������� ������� (��������� 23)';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_D IS '������������ ���� �� ��䳿/������ �������';
COMMENT ON COLUMN BARS.NBU23_REZ.Z IS '������������ ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.PD IS '����. ��������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_P IS '������������ ���� � ��. �����.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZN IS '������ ���. (�� ����������� � ����������� ���.) ';
COMMENT ON COLUMN BARS.NBU23_REZ.REZNQ IS '������ ���. (�� ����������� � ����������� ���.) ';
COMMENT ON COLUMN BARS.NBU23_REZ.ARJK IS '��������� �� ���� ����';
COMMENT ON COLUMN BARS.NBU23_REZ.PVZ IS '��������� (������� ��� ��� �����.����) ������������, ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.PVZQ IS '��������� (������� ��� ��� �����.����) ������������, ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.ZALQ IS '�i����� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.ZPR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ZPRQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PVQ IS '�������� ������� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.RU IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.INN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.NRC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.SDATE IS '���� ������� 䳿 ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.IR IS '���.% �� �� - ����';
COMMENT ON COLUMN BARS.NBU23_REZ.S031 IS 'S031 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.K040 IS 'K040 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.PROD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.K110 IS 'K110 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.K070 IS 'K070 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.K051 IS 'K051 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.S260 IS 'S260 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.R011 IS 'R011 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.R012 IS 'R012 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.S240 IS 'S240 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.S180 IS 'S180 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.S580 IS 'S580 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZ IS '������� ������� ����. � �����������';
COMMENT ON COLUMN BARS.NBU23_REZ.ISTVAL IS '������� ������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.R013 IS 'R013 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22 IS 'OB22 ��� ������� ������';
COMMENT ON COLUMN BARS.NBU23_REZ.TIP IS '��� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.SPEC IS '����.������';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_BL IS '��������� ���� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.S280_290 IS '��� ���������� ���� ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_BLQ IS '��������� ���� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZN IS '�������� ����� ������� ������� �� ����. � �����������';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZ IS 'OB22 ��� ������� ������� ����.� �����������';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZN IS 'OB22 ��� ������� ������� �� ����.� �����������';
COMMENT ON COLUMN BARS.NBU23_REZ.IR0 IS '���.% ������ ���. - ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.IRR0 IS '���.% ������ �� - ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.ND_CP IS '���.�������� ��� ����������� �� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZ_0 IS 'acc ����� ������� �� ���.% �����.<30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ39 IS '����� ������� (���.) �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.S250_23 IS '����� ������� ������� �� �������������� ��� ������������ ������';
COMMENT ON COLUMN BARS.NBU23_REZ.KAT39 IS '��������� ����� �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ39 IS '����� ������� (���.) �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.S250_39 IS '����� ������� ������� �� �������������� ��� ������������ ������';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ23 IS '����� ������� �� 23 ���� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ23 IS '����� ������� �� 23 ���� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.KAT23 IS '��������� ����� �� FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.DAT_MI IS '���� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZ_30 IS 'Ob22 ����� ������� �� ���.% �����.>30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZ_0 IS 'Ob22 ����� ������� �� ���.% �����.<30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.TIPA IS '���.������';
COMMENT ON COLUMN BARS.NBU23_REZ.BVUQ IS '����������� ���.����.���.';
COMMENT ON COLUMN BARS.NBU23_REZ.BVU IS '����������� ���.����.���.';
COMMENT ON COLUMN BARS.NBU23_REZ.EAD IS '(BV - SNA) = EAD(���.) ���������� �� ���-��� �� ���� ������';
COMMENT ON COLUMN BARS.NBU23_REZ.EADQ IS '(BVQ - SNAQ) = EADQ(���.) ���������� �� ���-��� �� ���� ������';
COMMENT ON COLUMN BARS.NBU23_REZ.CR IS '��������� ����� CR (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.CRQ IS '��������� ����� CRQ (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_351 IS '������������ ���� (351)';
COMMENT ON COLUMN BARS.NBU23_REZ.KOL_351 IS '�-�� ��� ���������� (351)';
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
COMMENT ON COLUMN BARS.NBU23_REZ.PD_0 IS '���������� (PD=0)';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_Z IS '���� �����������, ���������� �� ����� ������������� ���������';
COMMENT ON COLUMN BARS.NBU23_REZ.ISTVAL_351 IS '������� ������� ������� ����� � ���������� 351';
COMMENT ON COLUMN BARS.NBU23_REZ.RPB IS 'г���� �������� �����';
COMMENT ON COLUMN BARS.NBU23_REZ.S080 IS '�������� ���.����� �� FIN_351';
COMMENT ON COLUMN BARS.NBU23_REZ.S080_Z IS '�������� ���.����� �� FIN_Z';
COMMENT ON COLUMN BARS.NBU23_REZ.DDD_6B IS 'DDD ��� ����� #6B';
COMMENT ON COLUMN BARS.NBU23_REZ.FDAT IS '����� ���� (01.MM.DDDD)';
COMMENT ON COLUMN BARS.NBU23_REZ.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.NBU23_REZ.ID IS '���� ����:���+��';
COMMENT ON COLUMN BARS.NBU23_REZ.RNK IS '���. � ��';
COMMENT ON COLUMN BARS.NBU23_REZ.NBS IS '���.���.';
COMMENT ON COLUMN BARS.NBU23_REZ.KV IS '���. �������';
COMMENT ON COLUMN BARS.NBU23_REZ.ND IS '���. ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.CC_ID IS '����� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC IS '�������� ����� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS IS '����� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.BRANCH IS '����� �������� �����';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN IS 'Գ�������� ���� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.OBS IS '�������������� �����';
COMMENT ON COLUMN BARS.NBU23_REZ.KAT IS '��������.�����';
COMMENT ON COLUMN BARS.NBU23_REZ.K IS '�������� ������';
COMMENT ON COLUMN BARS.NBU23_REZ.IRR IS '���.% ������ �� - ��������������';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL IS '�i����� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.BV IS '��������� ������� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.PV IS '�������� ������� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ IS '������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ IS '������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.DD IS '��������� ������� 2-��,3-��';
COMMENT ON COLUMN BARS.NBU23_REZ.DDD IS '��� ���������� ������� (�������)';
COMMENT ON COLUMN BARS.NBU23_REZ.BVQ IS '���.���� ������� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.CUSTTYPE IS '��� �볺���';
COMMENT ON COLUMN BARS.NBU23_REZ.IDR IS '������.�������';
COMMENT ON COLUMN BARS.NBU23_REZ.WDATE IS '���� ��������� 䳿 ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.OKPO IS '���� �볺���';
COMMENT ON COLUMN BARS.NBU23_REZ.NMK IS '����� �볺���';
COMMENT ON COLUMN BARS.NBU23_REZ.RZ IS '������������';
COMMENT ON COLUMN BARS.NBU23_REZ.PAWN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S250 IS 'S250 - �������� �������';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZ IS '�������� ����� ������� ������� ����. � �����������';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_R IS 'Գ�.���� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.DISKONT IS '���� ��������� ��� �� ������� ��������';
COMMENT ON COLUMN BARS.NBU23_REZ.ISP IS '���������� �� ������� ������';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZN IS '������� ������� �� ����. � �����������';
COMMENT ON COLUMN BARS.NBU23_REZ.SUM_IMP IS '������� �� ���������� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.SUMQ_IMP IS '������� �� ���������� (���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.PV_ZAL IS '�����*�';
COMMENT ON COLUMN BARS.NBU23_REZ.VKR IS '�����.����.�������';
COMMENT ON COLUMN BARS.NBU23_REZ.S_L IS '�����*����.����.-������� �� ����.(���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.SQ_L IS '�����*����.����.-������� �� ����.(���.)';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_SV IS '����������� ������� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_SVQ IS '����������� ������� ������������ ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.GRP IS '����� ������ ������������ ������';
COMMENT ON COLUMN BARS.NBU23_REZ.KOL_SP IS 'ʳ������ ��� ����������';
COMMENT ON COLUMN BARS.NBU23_REZ.PVP IS '���� ���������� �������� �������� ������ �� �������� �������� �� �������� ';
COMMENT ON COLUMN BARS.NBU23_REZ.BV_30 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.BVQ_30 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ_30 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ_30 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZ_30 IS '���� ������� �� ���.% �����.>30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZ_30 IS 'acc ����� ������� �� ���.% �����.>30 ����';
COMMENT ON COLUMN BARS.NBU23_REZ.BV_0 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.BVQ_0 IS '���������� ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ_0 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ_0 IS '������ ����� 30 ���� ���.';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZ_0 IS '���� ������� �� ���.% �����.<30 ����';




PROMPT *** Create  constraint CC_NBU23REZ_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ MODIFY (KF CONSTRAINT CC_NBU23REZ_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBU23REZ_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ MODIFY (FDAT CONSTRAINT CC_NBU23REZ_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBU23REZ_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ MODIFY (ID CONSTRAINT CC_NBU23REZ_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_NBU23REZ_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ MODIFY (KV CONSTRAINT CC_NBU23REZ_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index UK_NBU23REZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBU23REZ ON BARS.NBU23_REZ (FDAT, KF, ID, KV) 
  TABLESPACE BRSBIGI  LOCAL
  ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_NBU23REZ_ND ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_NBU23REZ_ND ON BARS.NBU23_REZ (FDAT, KF, ND) 
  TABLESPACE BRSBIGI  LOCAL
 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_NBU23REZ_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_NBU23REZ_ACC ON BARS.NBU23_REZ (FDAT, KF, ACC) 
  TABLESPACE BRSBIGI  LOCAL
 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_NBU23REZ_RNK ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_NBU23REZ_RNK ON BARS.NBU23_REZ (FDAT, KF, RNK) 
  TABLESPACE BRSBIGI  LOCAL
';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_NBU23REZ_NBS ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_NBU23REZ_NBS ON BARS.NBU23_REZ (FDAT, NBS, TIPA,CUSTTYPE) 
  TABLESPACE BRSBIGI  LOCAL';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin
 execute immediate   'alter table NBU23_REZ add (OKPO_GCIF varchar2(30)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN NBU23_REZ.OKPO  IS '����-GCIF';


PROMPT *** Create  grants  NBU23_REZ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NBU23_REZ       to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on NBU23_REZ       to BARSREADER_ROLE;
grant SELECT                                                                 on NBU23_REZ       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBU23_REZ       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBU23_REZ       to BARS_DM;
grant SELECT                                                                 on NBU23_REZ       to CIG_LOADER;
grant SELECT                                                                 on NBU23_REZ       to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBU23_REZ       to START1;
grant SELECT                                                                 on NBU23_REZ       to UPLD;



PROMPT *** Create SYNONYM  to NBU23_REZ ***

  CREATE OR REPLACE PUBLIC SYNONYM NBU23_REZ FOR BARS.NBU23_REZ;


PROMPT *** Create SYNONYM  to NBU23_REZ ***

  CREATE OR REPLACE PUBLIC SYNONYM NBU23_REZ_P FOR BARS.NBU23_REZ;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBU23_REZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
