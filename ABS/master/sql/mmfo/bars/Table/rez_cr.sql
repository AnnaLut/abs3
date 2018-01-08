

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_CR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_CR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_CR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_CR'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_CR ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_CR 
   (	FDAT DATE, 
	RNK NUMBER(*,0), 
	CUSTTYPE NUMBER(1,0), 
	ACC NUMBER(*,0), 
	KV NUMBER(3,0), 
	NBS VARCHAR2(4), 
	TIP CHAR(3), 
	NLS VARCHAR2(15), 
	ND NUMBER, 
	VIDD NUMBER(*,0), 
	FIN NUMBER(*,0), 
	FINP NUMBER(*,0), 
	FINV NUMBER(*,0), 
	VKR VARCHAR2(3), 
	BV NUMBER, 
	BVQ NUMBER, 
	BV02 NUMBER, 
	BV02Q NUMBER, 
	EAD NUMBER, 
	EADQ NUMBER, 
	IDF NUMBER(*,0), 
	PD NUMBER, 
	CR NUMBER, 
	CRQ NUMBER, 
	CR_LGD NUMBER, 
	KOL NUMBER, 
	FIN23 NUMBER, 
	CCF NUMBER, 
	PAWN NUMBER(*,0), 
	TIP_ZAL NUMBER(*,0), 
	KPZ NUMBER, 
	KL_351 NUMBER, 
	ZAL NUMBER, 
	ZALQ NUMBER, 
	ZAL_BV NUMBER, 
	ZAL_BVQ NUMBER, 
	LGD NUMBER, 
	RZ NUMBER, 
	TEXT VARCHAR2(250), 
	NMK VARCHAR2(70), 
	PRINSIDER NUMBER(*,0), 
	COUNTRY NUMBER(3,0), 
	ISE CHAR(5), 
	SDATE DATE, 
	DATE_V DATE, 
	WDATE DATE, 
	S250 NUMBER, 
	ISTVAL NUMBER(1,0), 
	RC NUMBER, 
	RCQ NUMBER, 
	FAKTOR NUMBER, 
	K_FAKTOR NUMBER, 
	K_DEFOLT NUMBER, 
	DV NUMBER, 
	FIN_KOR NUMBER(*,0), 
	TIPA NUMBER(*,0), 
	OVKR VARCHAR2(50), 
	P_DEF VARCHAR2(50), 
	OVD VARCHAR2(50), 
	OPD VARCHAR2(50), 
	KOL23 VARCHAR2(500), 
	KOL24 VARCHAR2(500), 
	KOL25 VARCHAR2(500), 
	KOL26 VARCHAR2(500), 
	KOL27 VARCHAR2(500), 
	KOL28 VARCHAR2(500), 
	KOL29 VARCHAR2(500), 
	FIN_Z NUMBER(*,0), 
	PD_0 NUMBER(*,0), 
	CC_ID VARCHAR2(50), 
	KOL17 VARCHAR2(50), 
	KOL31 VARCHAR2(100), 
	S180 VARCHAR2(1), 
	T4 NUMBER(1,0), 
	RPB NUMBER, 
	GRP NUMBER(*,0), 
	OB22 CHAR(2), 
	KOL30 VARCHAR2(500), 
	S080 VARCHAR2(1), 
	S080_Z VARCHAR2(1), 
	TIP_FIN NUMBER(*,0), 
	DDD_6B CHAR(3), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	LGD_LONG NUMBER, 
	Z NUMBER, 
	FIN_KOL NUMBER(*,0), 
	RNK_SK NUMBER(*,0), 
	FIN_SK NUMBER(*,0), 
	FIN_PK NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_CR ***
 exec bpa.alter_policies('REZ_CR');


COMMENT ON TABLE BARS.REZ_CR IS '��������� ����� �� ��������� ����������� ����������';
COMMENT ON COLUMN BARS.REZ_CR.LGD_LONG IS '';
COMMENT ON COLUMN BARS.REZ_CR.Z IS '������������ ��������';
COMMENT ON COLUMN BARS.REZ_CR.FIN_KOL IS '���� ��������-�������� ����� (���������� �� ������ ������ ����������� �����) � ����������� ���������� ������ ��� �����';
COMMENT ON COLUMN BARS.REZ_CR.RNK_SK IS '������� �������� �� ����� ��������� ��� �� ������� ���������';
COMMENT ON COLUMN BARS.REZ_CR.FIN_SK IS '������������ ���� �������� � ����������� ��������� �� ����� �� ������� ����������';
COMMENT ON COLUMN BARS.REZ_CR.FIN_PK IS '������������ ���� �������� � ����������� ��������� �� ����� ��������� �� ����� ���"������ �����������';
COMMENT ON COLUMN BARS.REZ_CR.FDAT IS '����� ����';
COMMENT ON COLUMN BARS.REZ_CR.RNK IS '��� (�����) �����������';
COMMENT ON COLUMN BARS.REZ_CR.CUSTTYPE IS '��� �����������';
COMMENT ON COLUMN BARS.REZ_CR.ACC IS '��. ����� ���.';
COMMENT ON COLUMN BARS.REZ_CR.KV IS '��� ������';
COMMENT ON COLUMN BARS.REZ_CR.NBS IS '���. �������';
COMMENT ON COLUMN BARS.REZ_CR.TIP IS '��� �������';
COMMENT ON COLUMN BARS.REZ_CR.NLS IS '����� �������';
COMMENT ON COLUMN BARS.REZ_CR.ND IS '����� ��������';
COMMENT ON COLUMN BARS.REZ_CR.VIDD IS '��� ��������';
COMMENT ON COLUMN BARS.REZ_CR.FIN IS 'PD :���� ��������, ���������� �� ������ ������ ����������� �����';
COMMENT ON COLUMN BARS.REZ_CR.FINP IS '';
COMMENT ON COLUMN BARS.REZ_CR.FINV IS '';
COMMENT ON COLUMN BARS.REZ_CR.VKR IS '���������� ��������� �������';
COMMENT ON COLUMN BARS.REZ_CR.BV IS 'BV - ��������� ������� (���.)-SNA-SDI';
COMMENT ON COLUMN BARS.REZ_CR.BVQ IS 'BV - ��������� ������� (���.)-SNA-SDI';
COMMENT ON COLUMN BARS.REZ_CR.BV02 IS 'BV - ��������� ������� (���.)�� �������';
COMMENT ON COLUMN BARS.REZ_CR.BV02Q IS 'BV - ��������� ������� (���.)�� �������';
COMMENT ON COLUMN BARS.REZ_CR.EAD IS '(BV - SNA) - EAD(���.) ���������� �� ���-���(EAD �� ���.������.,��� ���.���.�����"�����/EAD*CCF �� ���. ���-���� �����.) �� ���� ������';
COMMENT ON COLUMN BARS.REZ_CR.EADQ IS '(BVQ- SNAQ)- EAD(���.) ���������� �� ���-���(EAD �� ���.������.,��� ���.���.�����"�����/EAD*CCF �� ���. ���-���� �����.) �� ���� ������';
COMMENT ON COLUMN BARS.REZ_CR.IDF IS '��� ��� ����������� PD';
COMMENT ON COLUMN BARS.REZ_CR.PD IS 'PD :�������� ����������� PD, ����������� ��� ���������� ���������� ������';
COMMENT ON COLUMN BARS.REZ_CR.CR IS 'CR :������ (���.) - ����� ���������� ������ �� �������';
COMMENT ON COLUMN BARS.REZ_CR.CRQ IS 'CR :������ (���.) - ����� ���������� ������ �� �������';
COMMENT ON COLUMN BARS.REZ_CR.CR_LGD IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL IS '';
COMMENT ON COLUMN BARS.REZ_CR.FIN23 IS '';
COMMENT ON COLUMN BARS.REZ_CR.CCF IS '';
COMMENT ON COLUMN BARS.REZ_CR.PAWN IS 'LGD:��� ���� �������-�����';
COMMENT ON COLUMN BARS.REZ_CR.TIP_ZAL IS 'LGD:��� �������-�����';
COMMENT ON COLUMN BARS.REZ_CR.KPZ IS 'LGD:���������� �������� �������������';
COMMENT ON COLUMN BARS.REZ_CR.KL_351 IS '���������� �������� ������������';
COMMENT ON COLUMN BARS.REZ_CR.ZAL IS 'LGD:���� �����-������� (CV*k) ���.';
COMMENT ON COLUMN BARS.REZ_CR.ZALQ IS 'LGD:���� �����-������� (CV*k) ���.';
COMMENT ON COLUMN BARS.REZ_CR.ZAL_BV IS 'LGD:���� �����-������� (CV) ���.';
COMMENT ON COLUMN BARS.REZ_CR.ZAL_BVQ IS 'LGD:���� �����-������� (CV) ���.';
COMMENT ON COLUMN BARS.REZ_CR.LGD IS 'LGD:�������� ����������� LGD (1-RR)';
COMMENT ON COLUMN BARS.REZ_CR.RZ IS '';
COMMENT ON COLUMN BARS.REZ_CR.TEXT IS '';
COMMENT ON COLUMN BARS.REZ_CR.NMK IS '�������-����� �����������';
COMMENT ON COLUMN BARS.REZ_CR.PRINSIDER IS '��� ���� ���"����� � ������ �����';
COMMENT ON COLUMN BARS.REZ_CR.COUNTRY IS '��� ����� ������-�����';
COMMENT ON COLUMN BARS.REZ_CR.ISE IS '��� �������-������� ������� ��������';
COMMENT ON COLUMN BARS.REZ_CR.SDATE IS '���� ��������';
COMMENT ON COLUMN BARS.REZ_CR.DATE_V IS '���� ���������� �����/������� ���������� �����"�����';
COMMENT ON COLUMN BARS.REZ_CR.WDATE IS '���� ��������� �����/������� ���������� �����"�����';
COMMENT ON COLUMN BARS.REZ_CR.S250 IS '';
COMMENT ON COLUMN BARS.REZ_CR.ISTVAL IS '';
COMMENT ON COLUMN BARS.REZ_CR.RC IS 'LGD:���� ������-�����  (R�)';
COMMENT ON COLUMN BARS.REZ_CR.RCQ IS '';
COMMENT ON COLUMN BARS.REZ_CR.FAKTOR IS 'PD :���������� ��� �������� �������, �� ���������� ����������� ����� ��������';
COMMENT ON COLUMN BARS.REZ_CR.K_FAKTOR IS 'PD :��� �������, �� ������ ����� ������������ ���� ��������';
COMMENT ON COLUMN BARS.REZ_CR.K_DEFOLT IS 'PD :��� ������ ������� �������� ���� ��� ���� ���� ��������� �������';
COMMENT ON COLUMN BARS.REZ_CR.DV IS '';
COMMENT ON COLUMN BARS.REZ_CR.FIN_KOR IS 'PD :���� �������� � ����������� ���������� �������, �� ������������ ��� ���������� ���������� ������';
COMMENT ON COLUMN BARS.REZ_CR.TIPA IS '��� ������';
COMMENT ON COLUMN BARS.REZ_CR.OVKR IS '';
COMMENT ON COLUMN BARS.REZ_CR.P_DEF IS '';
COMMENT ON COLUMN BARS.REZ_CR.OVD IS '';
COMMENT ON COLUMN BARS.REZ_CR.OPD IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL23 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL24 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL25 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL26 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL27 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL28 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL29 IS '';
COMMENT ON COLUMN BARS.REZ_CR.FIN_Z IS '';
COMMENT ON COLUMN BARS.REZ_CR.PD_0 IS '';
COMMENT ON COLUMN BARS.REZ_CR.CC_ID IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL17 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL31 IS '';
COMMENT ON COLUMN BARS.REZ_CR.S180 IS '';
COMMENT ON COLUMN BARS.REZ_CR.T4 IS '';
COMMENT ON COLUMN BARS.REZ_CR.RPB IS '����� ���������� ������';
COMMENT ON COLUMN BARS.REZ_CR.GRP IS '';
COMMENT ON COLUMN BARS.REZ_CR.OB22 IS '��22 �������';
COMMENT ON COLUMN BARS.REZ_CR.KOL30 IS '';
COMMENT ON COLUMN BARS.REZ_CR.S080 IS '�������� ���.����� �� FIN_351';
COMMENT ON COLUMN BARS.REZ_CR.S080_Z IS '�������� ���.����� �� FIN_Z';
COMMENT ON COLUMN BARS.REZ_CR.TIP_FIN IS '��� ���.�����: 0 -> 1-2, 1 -> 1-5, 2 -> 1-10';
COMMENT ON COLUMN BARS.REZ_CR.DDD_6B IS 'DDD �� kl_f3_29 �� kf="6B"';
COMMENT ON COLUMN BARS.REZ_CR.KF IS '';




PROMPT *** Create  constraint CC_REZCR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_CR MODIFY (KF CONSTRAINT CC_REZCR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_REZ_CR_FDAT_RNK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_REZ_CR_FDAT_RNK ON BARS.REZ_CR (FDAT, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_REZ_CR_FDAT_ND ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_REZ_CR_FDAT_ND ON BARS.REZ_CR (FDAT, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_REZ_CR_FDAT_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_REZ_CR_FDAT_ACC ON BARS.REZ_CR (FDAT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_CR ***
grant SELECT                                                                 on REZ_CR          to BARSREADER_ROLE;
grant SELECT                                                                 on REZ_CR          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_CR          to RCC_DEAL;
grant SELECT                                                                 on REZ_CR          to START1;
grant SELECT                                                                 on REZ_CR          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_CR.sql =========*** End *** ======
PROMPT ===================================================================================== 
