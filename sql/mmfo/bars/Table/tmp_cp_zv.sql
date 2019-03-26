

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CP_ZV.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CP_ZV ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CP_ZV ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CP_ZV 
   (	G001 VARCHAR2(4), 
	G002 VARCHAR2(3), 
	G003 VARCHAR2(1), 
	G004 VARCHAR2(4), 
	G005 VARCHAR2(1), 
	G006 VARCHAR2(50), 
	G007 VARCHAR2(50), 
	G008 VARCHAR2(50), 
	G009 VARCHAR2(3), 
	G010 VARCHAR2(50), 
	G011 VARCHAR2(50), 
	G012 VARCHAR2(20), 
	G013 VARCHAR2(20), 
	G014 DATE, 
	G015 VARCHAR2(50), 
	G016 NUMBER, 
	G017 NUMBER, 
	G018 NUMBER, 
	G019 NUMBER, 
	G020 NUMBER, 
	G021 NUMBER, 
	G022 NUMBER, 
	G023 NUMBER, 
	G024 NUMBER, 
	G025 NUMBER, 
	G026 NUMBER, 
	G027 NUMBER, 
	G028 NUMBER, 
	G029 NUMBER, 
	G030 NUMBER, 
	G031 NUMBER, 
	G032 NUMBER, 
	G033 NUMBER, 
	G034 NUMBER, 
	G035 VARCHAR2(1), 
	G036 DATE, 
	G037 VARCHAR2(50), 
	G038 NUMBER, 
	G039 NUMBER, 
	G040 NUMBER, 
	G041 NUMBER, 
	G042 VARCHAR2(1), 
	G043 DATE, 
	G044 VARCHAR2(50), 
	G045 VARCHAR2(50), 
	G046 VARCHAR2(50), 
	G047 VARCHAR2(50), 
	G048 VARCHAR2(50), 
	G049 DATE, 
	G050 DATE, 
	G051 DATE, 
	G052 NUMBER, 
	G053 NUMBER, 
	G054 NUMBER, 
	G055 NUMBER, 
	G056 NUMBER, 
	G057 NUMBER, 
	G058 NUMBER, 
	G059 NUMBER, 
	G060 NUMBER, 
	G061 NUMBER, 
	G062 NUMBER, 
	G063 NUMBER, 
	G064 NUMBER, 
	G065 NUMBER, 
	G066 NUMBER, 
	G067 NUMBER, 
	G068 NUMBER, 
	G069 NUMBER, 
	G070 NUMBER, 
	G071 NUMBER, 
	G072 VARCHAR2(50), 
	G073 DATE, 
	G074 VARCHAR2(3), 
	G075 VARCHAR2(50), 
	G076 VARCHAR2(50), 
	G077 VARCHAR2(50), 
	G078 DATE, 
	G079 VARCHAR2(50), 
	G080 VARCHAR2(50), 
	G081 VARCHAR2(14), 
	G082 DATE, 
	G083 NUMBER, 
	G084 VARCHAR2(50), 
	G085 NUMBER, 
	G086 NUMBER, 
	G087 VARCHAR2(1), 
	G088 NUMBER, 
	G089 NUMBER, 
	ID NUMBER(*,0), 
	ISIN VARCHAR2(20), 
	NBS_OLD NUMBER(4,0), 
	KV NUMBER(*,0), 
	REPO VARCHAR2(5), 
	D_K VARCHAR2(1), 
	PF_OLD NUMBER(*,0), 
	EMI VARCHAR2(50), 
	OKPO VARCHAR2(8), 
	AUKCION VARCHAR2(15), 
	DAT_K DATE, 
	NM_PROD VARCHAR2(50), 
	BV1 NUMBER, 
	CENA0 NUMBER, 
	KL1 NUMBER, 
	N1 NUMBER, 
	R1 NUMBER, 
	D1 NUMBER, 
	P1 NUMBER, 
	Z1 NUMBER, 
	S1 NUMBER, 
	CF008_019 NUMBER(1,0), 
	N2 NUMBER, 
	KL2 NUMBER, 
	KL_K2 NUMBER, 
	CENA_K2 NUMBER, 
	CF008_023 VARCHAR2(1), 
	DAT_K2 DATE, 
	NM_PROD2 VARCHAR2(50), 
	N2_P NUMBER, 
	KL2_P NUMBER, 
	CF008_028 VARCHAR2(1), 
	DAT_P2 DATE, 
	NM_POK VARCHAR2(50), 
	CENA_P2 NUMBER, 
	R2 NUMBER, 
	S2 NUMBER, 
	TR1_31 NUMBER, 
	KL31 NUMBER, 
	N31 NUMBER, 
	R31 NUMBER, 
	D31 NUMBER, 
	P31 NUMBER, 
	S31 NUMBER, 
	Z31 NUMBER, 
	IR31 NUMBER, 
	DAT_PG DATE, 
	CF008_042 DATE, 
	DAT_IR DATE, 
	KOT31 NUMBER, 
	CF008_045 VARCHAR2(30), 
	DAT_KOT DATE, 
	DAT_P4 DATE, 
	SUMB4 NUMBER, 
	NM_POK4 VARCHAR2(50), 
	KL_P4 NUMBER, 
	CENA_P4 NUMBER, 
	N4 NUMBER, 
	BV31 NUMBER, 
	PV31 NUMBER, 
	CF008_055 VARCHAR2(5), 
	CF008_056 NUMBER(1,0), 
	CF008_057 NUMBER, 
	CF008_058 NUMBER, 
	CF008_059 VARCHAR2(3), 
	CF008_060 NUMBER, 
	CF008_061 VARCHAR2(3), 
	CF008_062 VARCHAR2(20), 
	CF008_063 NUMBER(1,0), 
	DNK DATE, 
	CF008_065 VARCHAR2(14), 
	CF008_066 VARCHAR2(50), 
	DAT_R DATE, 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(38), 
	REF NUMBER(*,0), 
	REF2 NUMBER(*,0), 
	VID_R CHAR(2), 
	CENA_START NUMBER, 
	IR NUMBER, 
	OST_V NUMBER, 
	FL NUMBER(*,0), 
	USERID NUMBER(*,0), 
	NLS_S VARCHAR2(15), 
	D2 NUMBER, 
	P2 NUMBER, 
	S_D NUMBER, 
	S_C NUMBER, 
	NLS_P VARCHAR2(15), 
	S_DP NUMBER, 
	S_CP NUMBER, 
	OST_I NUMBER, 
	S_DK NUMBER, 
	S_CK NUMBER, 
	OST_P NUMBER, 
	NLS_P1 VARCHAR2(15), 
	DAT_P DATE, 
	S_DP_NEW NUMBER, 
	S_CP_NEW NUMBER, 
	PAP NUMBER(*,0), 
	S_DK_NEW NUMBER, 
	S_CK_NEW NUMBER, 
	OST_PQ NUMBER, 
	OST_VQ NUMBER, 
	S_DQ NUMBER, 
	S_CQ NUMBER, 
	S_DKQ NUMBER, 
	S_CKQ NUMBER, 
	S_DPQ NUMBER, 
	S_CPQ NUMBER, 
	S_DPQ_NEW NUMBER, 
	S_CPQ_NEW NUMBER, 
	S_DKQ_NEW NUMBER, 
	S_CKQ_NEW NUMBER, 
	NBS_NEW NUMBER(4,0), 
	PF_NEW NUMBER(*,0), 
	OST_VT NUMBER, 
	OST_V31 NUMBER, 
	CENA NUMBER, 
	CENA4 NUMBER, 
	N0 NUMBER, 
	D0 NUMBER, 
	P0 NUMBER, 
	R0 NUMBER, 
	S0 NUMBER, 
	D4 NUMBER, 
	P4 NUMBER, 
	R4 NUMBER, 
	S4 NUMBER, 
	Z4 NUMBER, 
	KL0 NUMBER, 
	KL4 NUMBER, 
	DAT_4 DATE, 
	FRM VARCHAR2(3), 
	PERIOD VARCHAR2(3), 
	DAT_BAY DATE, 
	INIT_REF NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CP_ZV ***
 exec bpa.alter_policies('TMP_CP_ZV');


COMMENT ON TABLE BARS.TMP_CP_ZV IS 'TMP-������� ��� ���� DGP �� ��';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_DK_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_CK_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.OST_PQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.OST_VQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_DQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_CQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_DKQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_CKQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_DPQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_CPQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_DPQ_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_CPQ_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_DKQ_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_CKQ_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NBS_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.PF_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.OST_VT IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.OST_V31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CENA IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CENA4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.N0 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.D0 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.P0 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.R0 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S0 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.D4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.P4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.R4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.Z4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.KL0 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.KL4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.FRM IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.PERIOD IS '���?�� Y/H/Q/M/D';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_BAY IS '���� ���������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.INIT_REF IS '���-� ���������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G051 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G052 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G053 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G054 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G055 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G056 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G057 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G058 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G059 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G060 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G061 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G062 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G063 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G064 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G065 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G066 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G067 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G068 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G069 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G070 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G071 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G072 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G073 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G074 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G075 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G076 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G077 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G078 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G079 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G080 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G081 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G082 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G083 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G084 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G085 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G086 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G087 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G088 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G089 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.ID IS '�����. ��� ��';
COMMENT ON COLUMN BARS.TMP_CP_ZV.ISIN IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NBS_OLD IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.KV IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.REPO IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.D_K IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.PF_OLD IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.EMI IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.AUKCION IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_K IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NM_PROD IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.BV1 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CENA0 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.KL1 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.N1 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.R1 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.D1 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.P1 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.Z1 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S1 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_019 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.N2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.KL2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.KL_K2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CENA_K2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_023 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_K2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NM_PROD2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.N2_P IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.KL2_P IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_028 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_P2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NM_POK IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CENA_P2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.R2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.TR1_31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.KL31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.N31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.R31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.D31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.P31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.Z31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.IR31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_PG IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_042 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_IR IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.KOT31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_045 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_KOT IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_P4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.SUMB4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NM_POK4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.KL_P4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CENA_P4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.N4 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.BV31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.PV31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_055 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_056 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_057 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_058 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_059 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_060 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_061 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_062 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_063 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DNK IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_065 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CF008_066 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_R IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NLS IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NMS IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.REF IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.REF2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.VID_R IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.CENA_START IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.IR IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.OST_V IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.FL IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.USERID IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NLS_S IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.D2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.P2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_D IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_C IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NLS_P IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_DP IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_CP IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.OST_I IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_DK IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_CK IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.OST_P IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.NLS_P1 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.DAT_P IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_DP_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.S_CP_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.PAP IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G001 IS 'г���� �� �������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G002 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G003 IS '��� ���';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G004 IS '������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G005 IS '�� �� ��';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G006 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G007 IS '����� �������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G008 IS '��� ������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G009 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G010 IS '����';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G011 IS '� ��������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G012 IS 'ISIN-���';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G013 IS '������ ������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G014 IS '���� ���������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G015 IS '����� ��������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G016 IS '%-������ �� �������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G017 IS '���� ��������� 1 ��.';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G018 IS 'ʳ������ �� �������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G019 IS '���. ����. �� �������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G020 IS '�/� �� �������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G021 IS '����� �����. �� �������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G022 IS '��������� ��� �� �������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G023 IS '���� ������� �� �������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G024 IS '������ �� ���� 39';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G025 IS '���� ���������� �� �������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G026 IS '���� ���������� �� ����';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G027 IS '���/�������';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G028 IS '���/������� ����� ����';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G029 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G030 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G031 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G032 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G033 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G034 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G035 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G036 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G037 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G038 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G039 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G040 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G041 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G042 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G043 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G044 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G045 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G046 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G047 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G048 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G049 IS '';
COMMENT ON COLUMN BARS.TMP_CP_ZV.G050 IS '';




PROMPT *** Create  index XAK_TMPCPZV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XAK_TMPCPZV ON BARS.TMP_CP_ZV (ID, REF, NLS, USERID, FRM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CP_ZV ***
grant SELECT                                                                 on TMP_CP_ZV       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CP_ZV       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_CP_ZV       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CP_ZV       to START1;
grant SELECT                                                                 on TMP_CP_ZV       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CP_ZV.sql =========*** End *** ===
PROMPT ===================================================================================== 