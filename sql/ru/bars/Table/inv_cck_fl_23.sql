

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INV_CCK_FL_23.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INV_CCK_FL_23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INV_CCK_FL_23'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INV_CCK_FL_23'', ''WHOLE''  , null, null, null, null);
           end; 
          '; 
END; 
/

PROMPT *** Create  table INV_CCK_FL_23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.INV_CCK_FL_23 
   (	G00 DATE, 
	G01 VARCHAR2(70), 
	G02 VARCHAR2(30), 
	G03 VARCHAR2(30), 
	G04 VARCHAR2(70), 
	G05 VARCHAR2(9), 
	G05I VARCHAR2(14), 
	G06 NUMBER, 
	G07 NUMBER(38,0), 
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
	G15 CHAR(10), 
	G16 CHAR(10), 
	G17 NUMBER, 
	G18 VARCHAR2(250), 
	G19 CHAR(4), 
	G20 VARCHAR2(9), 
	G21 NUMBER, 
	G22 NUMBER, 
	G23 NUMBER, 
	G24 NUMBER(38,0), 
	G25 NUMBER, 
	G26 NUMBER, 
	G27 NUMBER(22,4), 
	G28 NUMBER(22,4), 
	G29 NUMBER, 
	G30 NUMBER, 
	G31 NUMBER, 
	G32 CHAR(1), 
	G33 CHAR(3), 
	G34 CHAR(10), 
	G35 CHAR(1), 
	G36 CHAR(1), 
	G37 VARCHAR2(30), 
	G38 CHAR(10), 
	G39 NUMBER, 
	G40 NUMBER, 
	G41 NUMBER(22,3), 
	G42 NUMBER, 
	G43 NUMBER, 
	G44 NUMBER, 
	G45 NUMBER, 
	G46 CHAR(1), 
	G47 CHAR(1), 
	G48 VARCHAR2(2), 
	G49 CHAR(10), 
	G50 NUMBER, 
	G51 NUMBER, 
	G52 NUMBER, 
	G53 VARCHAR2(10), 
	G54 NUMBER, 
	G55 NUMBER(1,0), 
	G56 NUMBER, 
	G57 NUMBER, 
	G58 VARCHAR2(30), 
	G59 NUMBER, 
	G60 VARCHAR2(30), 
	G61 NUMBER, 
	G62 VARCHAR2(30), 
	G63 NUMBER, 
	G64 VARCHAR2(300), 
	G65 NUMBER, 
	GT NUMBER, 
	GR VARCHAR2(1), 
	ACC NUMBER, 
	RNK NUMBER, 
	ACC2208 NUMBER, 
	ACC2209 NUMBER, 
	ACC9129 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INV_CCK_FL_23 ***
 exec bpa.alter_policies('INV_CCK_FL_23');


COMMENT ON TABLE BARS.INV_CCK_FL_23 IS '���i ��� ������i���i� ����.������i� �� ����-� ���� ������� �� �� - 23 ���������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G07 IS '07 ������ �������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G08 IS '08 � �������� �����';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G09 IS '09 ���� ���������� ������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G10 IS '10 ������� ���� ��������� (���������)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G11 IS '11 ����� ���� ��������� � ����������� ���.���������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G12 IS '12 ������ ��������������i� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13 IS '13 �i��-�� ��i������� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13A IS '13a �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13B IS '13b �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13V IS '13v �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13G IS '13g �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13D IS '13d �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13E IS '13e �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13J IS '13j �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13Z IS '13z �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13I IS '13i �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G14 IS '14 ���� ���������� ������� ������������ �� ����� ���� ������� �� ���.������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G15 IS '15 ���� ���������� ������� ������������ �� ����� ���� ������� �� �����.%%';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G16 IS '16 ���� �������� ������� ���������� �� ��';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G17 IS '17 ������ i�������� ��i��� ������i������ KL_K061';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G18 IS '18 �i������ ��� ������� ������� i�������� �����';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G19 IS '19 ����� ��, �� ����� ���i�������� ������ �� ��i��� ����';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G20 IS '20 ������� � ����i������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G21 IS '21 ���� ������� �� ��i��� ���� � �����i ������� ';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G22 IS '22 ���� ������� � ���.�����i';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G23 IS '23 ���� ���������������� ��������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G24 IS '24 ��� ���i�� �������������i �� ���������� ��������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G25 IS '25 ���� �������.�����"����� �����������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G26 IS '26 ���� �������.�����"����� ���������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G27 IS '27 �i��� % ������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G28 IS '28 ��������� % ������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G29 IS '29 ������������ �����.������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G30 IS '30 ���������� �����.������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G31 IS '31 ���� ������������ �� ����� ���� � ������ ������ (34 ��� ����� ������������� ��� KL_S031), ���';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G32 IS '32 ��i��� �i��������� ����� ������������ (����)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G33 IS '33 �����i��i� ��������� ������� ������������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G34 IS '34 ���� �������� ������ ���.�����';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G35 IS '35 �������i� ����� �������� ������i�';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G36 IS '36 �������������� ����� �������������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G37 IS '37 ��� ������������  (��.� ������i������� KL_S031)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G38 IS '38 ���� ��������� �� 5 ������� ����� ';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G39 IS '39 ����������� �������� �������, ���';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G40 IS '40 ���� ���������� �� ���������� ������� ������������, ���';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G41 IS '41 �������� ��������� ������ �� ����.���������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G42 IS '42 ������������ ���� �������, ���.';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G43 IS '43 �������� ���������� ���� �������, ���., �� ���������, �� �� �������� � ��';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G44 IS '44 �������� ���������� ���� �������, ���., �� ���������, �� �������� � ��';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G45 IS '45 �i�������� ����  �������� ������������ ������� �i� ���� �������������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G46 IS '46 �������i� ��������, ��i ����������� �����i��� ������������� ����������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G47 IS '47 ���������i��� �� ����i����i� �����';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G48 IS '48 �i����� ����������� ������� (������������ �� ��������, ������� ����i������ �����)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G49 IS '49 ���� �������� ���������i� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G50 IS '50 �� ����� 891, �� ����� ���i��������� ���� �����.�� �������.�����i� �� ��������, �� �� ������ �������i';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G51 IS '51 ���� �����.�� �������.�����i� �� ��������, �� �� ������ �������i';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G52 IS '52 �������� ��������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G53 IS '53 ���� �������� ���������������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G54 IS '54 �������� ���������� ���� ������� ��� ������������ �������� ����� �� ��������������� ������������� (���. 3690), ���';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G55 IS '55 ������� ���������� ������� (1-������, 2-г����� ���������)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G56 IS '56 ��������� ������� �������, ���.';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G57 IS '57 �������� ������� ...';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G58 IS '58 ����������� 40-45���� ������������ - ��� ������������  (��.� ������i������� KL_S031)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G59 IS '59 ����������� 40-45���� ������������ - ���� ������������ �� ����� ����, ���.';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G60 IS '60 ����������� 40-45���� ������������ - ��� ������������  (��.� ������i������� KL_S031)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G61 IS '61 ����������� 40-45���� ������������ - ���� ������������ �� ����� ����, ���.';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G62 IS '62 ����������� 40-45���� ������������ - ��� ������������  (��.� ������i������� KL_S031)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G63 IS '63 ����������� 40-45���� ������������ - ���� ������������ �� ����� ����, ���.';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G64 IS '64 �������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G65 IS '65 ��� - ���������������� ���������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.GT IS '��� ��������� (�������(0)/������(1)) ';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.GR IS '������� ���� ������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.ACC IS 'ACC �����, �� ������� ����������� �������������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.RNK IS '��� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.ACC2208 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.ACC2209 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.ACC9129 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G00 IS '���� ����������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G01 IS '01 ����� ��';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G02 IS '02 ��� �������� (�i��i�����)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G03 IS '03 ����� ����';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G04 IS '04 �I� ������������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G05 IS '05 ������������ ����� ������� ������ �������� �������';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G05I IS '05I I������i���i���� ��� ��';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G06 IS '06 ���� ������� �� ������ � �����i �����';


begin 
  execute immediate 'alter table INV_CCK_FL_23 add kf VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')';
exception when others then 
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/


PROMPT *** Create  constraint PK_INVCCKFL23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 ADD CONSTRAINT PK_INVCCKFL23 PRIMARY KEY (G00, GT, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index I1_INVCCKFL23 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_INVCCKFL23 ON BARS.INV_CCK_FL_23 (G00, GT, ACC2208) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I2_INVCCKFL23 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_INVCCKFL23 ON BARS.INV_CCK_FL_23 (G00, GT, ACC2209) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
PROMPT *** Create  index I3_INVCCKFL23 ***
begin   
 execute immediate '
  CREATE  INDEX BARS.I3_INVCCKFL23 ON BARS.INV_CCK_FL_23 (G00, GT, ACC9129) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint CC_INVCCKFL23_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 MODIFY (ACC CONSTRAINT CC_INVCCKFL23_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL23_GR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 MODIFY (GR CONSTRAINT CC_INVCCKFL23_GR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL23_GT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 MODIFY (GT CONSTRAINT CC_INVCCKFL23_GT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL23_G00_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 MODIFY (G00 CONSTRAINT CC_INVCCKFL23_G00_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INVCCKFL23 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INVCCKFL23 ON BARS.INV_CCK_FL_23 (G00, GT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INV_CCK_FL_23 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INV_CCK_FL_23   to BARSDWH_ACCESS_USER;
grant DELETE,INSERT,SELECT,UPDATE                                            on INV_CCK_FL_23   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on INV_CCK_FL_23   to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INV_CCK_FL_23.sql =========*** End ***
PROMPT ===================================================================================== 
