

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INV_CCK_FL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INV_CCK_FL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INV_CCK_FL'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''INV_CCK_FL'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INV_CCK_FL ***
begin 
  execute immediate '
  CREATE TABLE BARS.INV_CCK_FL 
   (	G00 DATE, 
	G01 VARCHAR2(70), 
	G02 VARCHAR2(30), 
	G03 VARCHAR2(30), 
	G04 VARCHAR2(70), 
	G05 VARCHAR2(14), 
	G06 NUMBER, 
	G07 NUMBER(*,0), 
	G08 VARCHAR2(20), 
	G09 CHAR(10), 
	G10 CHAR(10), 
	G11 CHAR(10), 
	G12 CHAR(1), 
	G13 NUMBER, 
	G13A NUMBER, 
	G13B NUMBER, 
	G13V NUMBER, 
	G13G NUMBER, 
	G13D NUMBER, 
	G13E NUMBER, 
	G13J NUMBER, 
	G13Z NUMBER, 
	G13I NUMBER, 
	G14 CHAR(10), 
	G16 CHAR(10), 
	G17 NUMBER, 
	G18 VARCHAR2(250), 
	G19 CHAR(4), 
	G20 VARCHAR2(9), 
	G21 NUMBER, 
	G22 NUMBER, 
	G23 NUMBER, 
	G24 NUMBER(*,0), 
	G25 NUMBER, 
	G26 NUMBER, 
	G28 NUMBER, 
	G29 NUMBER, 
	G30 NUMBER, 
	G31 NUMBER, 
	G32 NUMBER, 
	G33 NUMBER, 
	G34 NUMBER, 
	G35 NUMBER, 
	G36 CHAR(1), 
	G37 CHAR(3), 
	G38 CHAR(10), 
	G39 CHAR(1), 
	G40 CHAR(1), 
	G41 VARCHAR2(30), 
	G42 NUMBER(*,0), 
	G43 NUMBER, 
	G44 NUMBER, 
	G45 NUMBER, 
	G46 NUMBER, 
	G47 NUMBER, 
	G48 NUMBER, 
	G49 NUMBER, 
	G50 NUMBER, 
	G51 CHAR(1), 
	G52 NUMBER, 
	G53 NUMBER, 
	G54 CHAR(1), 
	G55 VARCHAR2(2), 
	G56 CHAR(10), 
	G57 NUMBER, 
	G58 NUMBER, 
	G59 NUMBER, 
	GT NUMBER, 
	GR VARCHAR2(1), 
	ACC NUMBER, 
	RNK NUMBER, 
	ACC2208 NUMBER, 
	ACC9129 NUMBER, 
	G101 NUMBER, 
	G102 NUMBER, 
	G103 VARCHAR2(100), 
	G104 CHAR(10), 
	G105 NUMBER, 
	G106 NUMBER, 
	G107 NUMBER, 
	G27 NUMBER(22,4), 
	G27E NUMBER(22,4), 
	G15 CHAR(10), 
	G60 VARCHAR2(10), 
	G62 NUMBER(1,0), 
	G61 NUMBER
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
  PARTITION BY RANGE (G00) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
 (PARTITION P20100101  VALUES LESS THAN (TO_DATE('' 2010-01-02 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INV_CCK_FL ***
 exec bpa.alter_policies('INV_CCK_FL');


COMMENT ON TABLE BARS.INV_CCK_FL IS '���i ��� ������i���i� ����.������i� �� ����-� ���� ������� �� ��';
COMMENT ON COLUMN BARS.INV_CCK_FL.G49 IS '49 �������� ���������� ���� ������� �� ���-� ������� ������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G50 IS '50 �i�������� ����  �������� ������������ ������� �i� ���� �������������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G51 IS '51 �������i� ��������, ��i ����������� �����i��� ������������� ����������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G52 IS '52 ���� ������������ ������� �� ��������. ����.������i���';
COMMENT ON COLUMN BARS.INV_CCK_FL.G53 IS '53 ���� �������� ������������ ������� �� ��������. ����.������i���';
COMMENT ON COLUMN BARS.INV_CCK_FL.G54 IS '54 ���������i��� �� ����i����i� �����';
COMMENT ON COLUMN BARS.INV_CCK_FL.G55 IS '55 �i����� ����������� ������� (������������ �� ��������, ������� ����i������ �����)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G56 IS '56 ���� �������� ���������i� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G57 IS '57 �� ����� 891, �� ����� ���i��������� ���� �����.�� �������.�����i� �� ��������, �� �� ������ �������i';
COMMENT ON COLUMN BARS.INV_CCK_FL.G58 IS '58 ���� �����.�� �������.�����i� �� ��������, �� �� ������ �������i';
COMMENT ON COLUMN BARS.INV_CCK_FL.G59 IS '59 �������� �������� ����� (��������� ����� � ������)';
COMMENT ON COLUMN BARS.INV_CCK_FL.GT IS '��� ��������� (�������(0)/������(1))';
COMMENT ON COLUMN BARS.INV_CCK_FL.GR IS '������� ���� ������ (������� �� ��� - "C", ������ �� ��� ����������������� - "K", ������ �� ��� ����������� - "R", ������ - "I")';
COMMENT ON COLUMN BARS.INV_CCK_FL.ACC IS 'ACC �����, �� ������� ����������� ������������� (22_2, 22_3, 22_7)';
COMMENT ON COLUMN BARS.INV_CCK_FL.RNK IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL.ACC2208 IS 'ACC ����� ���.%% 22_8 (������ ��� ���! ��� �� ��� ����� �� ����� ������������ ��������� ������� � TMP_INV_ACC2208 (� SN, � SPN,
� SLN))';
COMMENT ON COLUMN BARS.INV_CCK_FL.ACC9129 IS 'ACC 9129';
COMMENT ON COLUMN BARS.INV_CCK_FL.G101 IS '���� ������� ������������� �� ������ �� ������� ����, ���.';
COMMENT ON COLUMN BARS.INV_CCK_FL.G102 IS '���� ������� ������������� �� ��������� �� ������� ����, ���.';
COMMENT ON COLUMN BARS.INV_CCK_FL.G103 IS '��� ���������� ��������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G104 IS '���� ����������� ������������� �� ������������ �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G105 IS '���� ���������� ����� �� ������� � ��������� ����, ���';
COMMENT ON COLUMN BARS.INV_CCK_FL.G106 IS '���� ���������� �������� �� �������� � ��������� ����, ���';
COMMENT ON COLUMN BARS.INV_CCK_FL.G107 IS '������ ������������ ����� �� ����, ���';
COMMENT ON COLUMN BARS.INV_CCK_FL.G15 IS '15 ���� ���������� 1-�� �������.������.������� �� �����.��������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G27E IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL.G60 IS '60 ���� �������� ���������������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G62 IS '62 ������� ���������� ������� (1-������, 2-г����� ���������)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G61 IS '61 �������� ���������� ���� ������� ��� ������������ �������� ����� �� ��������������� �����.(���. 3690), ���';
COMMENT ON COLUMN BARS.INV_CCK_FL.G27 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL.G00 IS '���� ����������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G01 IS '01 ����� ��';
COMMENT ON COLUMN BARS.INV_CCK_FL.G02 IS '02 ��� �������� (�i��i�����)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G03 IS '03 ����� ����';
COMMENT ON COLUMN BARS.INV_CCK_FL.G04 IS '04 �I� ������������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G05 IS '05 I������i���i���� ��� ��';
COMMENT ON COLUMN BARS.INV_CCK_FL.G06 IS '06 ���� ������� �� ������ � ����� �����';
COMMENT ON COLUMN BARS.INV_CCK_FL.G07 IS '07 ������ �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G08 IS '08 � �������� �����';
COMMENT ON COLUMN BARS.INV_CCK_FL.G09 IS '09 ���� ���������� ������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G10 IS '10 ������� ���� ��������� (���������)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G11 IS '11 ����� ���� ��������� � ����������� ���.���������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G12 IS '12 ������ ��������������i� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G13 IS '13 �i��-�� ��i������� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G13A IS '13a �i��-�� ��i������� �����-�i� � ����i�i ���i� �����-�i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G13B IS '13b �i��-�� ��i������� �����-�i� � ����i�i ���i� �����-�i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G13V IS '13v �i��-�� ��i������� �����-�i� � ����i�i ���i� �����-�i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G13G IS '13g �i��-�� ��i������� �����-�i� � ����i�i ���i� �����-�i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G13D IS '13d �i��-�� ��i������� �����-�i� � ����i�i ���i� �����-�i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G13E IS '13e �i��-�� ��i������� �����-�i� � ����i�i ���i� �����-�i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G13J IS '13j �i��-�� ��i������� �����-�i� � ����i�i ���i� �����-�i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G13Z IS '13z �i��-�� ��i������� �����-�i� � ����i�i ���i� �����-�i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G13I IS '13i �i��-�� ��i������� �����-�i� � ����i�i ���i� �����-�i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G14 IS '14 ���� ���������� 1-�� �������.������.������� �� �������� ������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G16 IS '16 ���� �������� �����-�i ������i����';
COMMENT ON COLUMN BARS.INV_CCK_FL.G17 IS '17 ������ i�������� ��i��� KL_K061';
COMMENT ON COLUMN BARS.INV_CCK_FL.G18 IS '18 �i������ ��� ������� ������� i�������� �����';
COMMENT ON COLUMN BARS.INV_CCK_FL.G19 IS '19 ����� ��, �� ����� ���i�������� ������ �� ��i��� ����';
COMMENT ON COLUMN BARS.INV_CCK_FL.G20 IS '20 ������� � ����i������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G21 IS '21 ���� ������� �� ��i��� ���� � �����i �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G22 IS '22 ���� ������� �� ��i��� ���� � ���.�����i';
COMMENT ON COLUMN BARS.INV_CCK_FL.G23 IS '23 ���� ���������������� ��������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G24 IS '24 ��� ���i�� �������������i �� ��';
COMMENT ON COLUMN BARS.INV_CCK_FL.G25 IS '25 ���� �������.�����"����� �����������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G26 IS '26 ���� �������.�����"����� ���������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G28 IS '28 �����. �������. ����������. ������ (���.���� ������� ��� ������������<180 ��i�)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G29 IS '29 �����. �������. ����������. ������ (���.���� ������������>180 ��i�)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G30 IS '30 �����. ��������. �� 31 ��� ������ (���.���� ������� ��� ������������<180 ��i�)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G31 IS '31 �����. ��������. �� 31 ��� ������ (���.���� ������������>180 ��i�)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G32 IS '32 �����. ��������. �i� 32 �� 60 ��i� ������ (���.���� ������� ��� ������������<180 ��i�)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G33 IS '33 �����. ��������. �i� 32 �� 60 ��i� ������ (���.���� ������������>180 ��i�)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G34 IS '34 ���������� ��������� ������ ����� 60 ���';
COMMENT ON COLUMN BARS.INV_CCK_FL.G35 IS '35 ���� ������������ �� ����� ���� � ������ ������, ���.';
COMMENT ON COLUMN BARS.INV_CCK_FL.G36 IS '36 ��i��� �i�.����� ������������ (����)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G37 IS '37 �����i��i� ��������� ������� ������������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G38 IS '38 ���� �������� ������ ���.�����';
COMMENT ON COLUMN BARS.INV_CCK_FL.G39 IS '39 �������i� ������ �������� ������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL.G40 IS '40 �������������� ����� �������������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G41 IS '41 ��� ������������  (��. KL_S031)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G42 IS '42 ���������� ��� �������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G43 IS '43 �������� ���� ������������ �� ����� ���� ��� ���������� ������, ���.';
COMMENT ON COLUMN BARS.INV_CCK_FL.G44 IS '44 ���� ������������, �� �������� �� ���������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G45 IS '45 ���� �������������i, �� �������� �� ���������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL.G46 IS '46 ����i�i��� ������������ �� �������� ������ (%)';
COMMENT ON COLUMN BARS.INV_CCK_FL.G47 IS '47 ������������ ���� �������, ���.';
COMMENT ON COLUMN BARS.INV_CCK_FL.G48 IS '48 �������� ���������� ���� ������� �� ���-� ��������';




PROMPT *** Create  constraint PK_INVCCKFL ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL ADD CONSTRAINT PK_INVCCKFL PRIMARY KEY (G00, GT, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION P20100101 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI )  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL MODIFY (ACC CONSTRAINT CC_INVCCKFL_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL_GR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL MODIFY (GR CONSTRAINT CC_INVCCKFL_GR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL_GT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL MODIFY (GT CONSTRAINT CC_INVCCKFL_GT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL_G00_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL MODIFY (G00 CONSTRAINT CC_INVCCKFL_G00_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INVCCKFL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INVCCKFL ON BARS.INV_CCK_FL (G00, GT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION P20100101 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INV_CCK_FL ***
grant SELECT                                                                 on INV_CCK_FL      to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on INV_CCK_FL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INV_CCK_FL      to RCC_DEAL;



PROMPT *** Create SYNONYM  to INV_CCK_FL ***

  CREATE OR REPLACE SYNONYM BARSDWH_ACCESS_USER.INV_CCK_FL FOR BARS.INV_CCK_FL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INV_CCK_FL.sql =========*** End *** ==
PROMPT ===================================================================================== 
