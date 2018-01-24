

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_F503.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_F503 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_F503'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F503'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_F503 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_F503 
   (	F503_ID NUMBER, 
	CONTR_ID NUMBER, 
	P_DATE_TO DATE DEFAULT sysdate, 
	DATE_REG DATE DEFAULT sysdate, 
	USER_REG VARCHAR2(30), 
	DATE_CH DATE, 
	USER_CH VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	P1000 VARCHAR2(27), 
	Z VARCHAR2(10), 
	P0100 NUMBER, 
	P1300 VARCHAR2(54), 
	P0300 VARCHAR2(3), 
	P1400 NUMBER(2,0), 
	P1900 NUMBER(2,0), 
	PVAL VARCHAR2(3), 
	P1500 NUMBER(2,0), 
	M NUMBER(2,0), 
	P1600 NUMBER(2,0), 
	P9800 VARCHAR2(2), 
	P1700 NUMBER(2,0), 
	P0200 VARCHAR2(4), 
	R_AGREE_NO VARCHAR2(5), 
	P1200 DATE, 
	P1800 NUMBER(2,0), 
	T VARCHAR2(2) DEFAULT ''0'', 
	P9500 NUMBER(5,3), 
	P9600 NUMBER(2,0), 
	P3100 DATE, 
	P9900 VARCHAR2(108), 
	P0400 NUMBER(2,0), 
	P0800_1 VARCHAR2(10), 
	P0800_2 VARCHAR2(3), 
	P0800_3 VARCHAR2(3), 
	P0700 NUMBER(6,4), 
	P0900 NUMBER, 
	P0500 VARCHAR2(16), 
	P0600 DATE, 
	P2010 NUMBER, 
	P2011 NUMBER, 
	P2012 NUMBER, 
	P2013 NUMBER, 
	P2014 NUMBER, 
	P2016 NUMBER, 
	P2017 NUMBER, 
	P2018 NUMBER, 
	P2020 NUMBER, 
	P2021 NUMBER, 
	P2022 NUMBER, 
	P2023 NUMBER, 
	P2024 NUMBER, 
	P2025 NUMBER, 
	P2026 NUMBER, 
	P2027 NUMBER, 
	P2028 NUMBER, 
	P2029 NUMBER, 
	P2030 NUMBER, 
	P2031 NUMBER, 
	P2032 NUMBER, 
	P2033 NUMBER, 
	P2034 NUMBER, 
	P2035 NUMBER, 
	P2036 NUMBER, 
	P2037 NUMBER, 
	P2038 NUMBER, 
	P2042 NUMBER, 
	P3000 NUMBER(2,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_F503 ***
 exec bpa.alter_policies('CIM_F503');


COMMENT ON TABLE BARS.CIM_F503 IS '��� ��� ���� f503';
COMMENT ON COLUMN BARS.CIM_F503.F503_ID IS '������������� ���������';
COMMENT ON COLUMN BARS.CIM_F503.CONTR_ID IS '�������� ��� ���������';
COMMENT ON COLUMN BARS.CIM_F503.P_DATE_TO IS '��� ����������� �� ����';
COMMENT ON COLUMN BARS.CIM_F503.DATE_REG IS '������ � ���';
COMMENT ON COLUMN BARS.CIM_F503.USER_REG IS '���������� ����� � ���';
COMMENT ON COLUMN BARS.CIM_F503.DATE_CH IS '������� �����������';
COMMENT ON COLUMN BARS.CIM_F503.USER_CH IS '���������� �����������';
COMMENT ON COLUMN BARS.CIM_F503.BRANCH IS '����� �������';
COMMENT ON COLUMN BARS.CIM_F503.KF IS '���';
COMMENT ON COLUMN BARS.CIM_F503.P1000 IS '������������ ������������';
COMMENT ON COLUMN BARS.CIM_F503.Z IS '��� ������������';
COMMENT ON COLUMN BARS.CIM_F503.P0100 IS '��� ������������';
COMMENT ON COLUMN BARS.CIM_F503.P1300 IS '����� �����������-���������';
COMMENT ON COLUMN BARS.CIM_F503.P0300 IS '��� ����� ���������';
COMMENT ON COLUMN BARS.CIM_F503.P1400 IS '��� ���������';
COMMENT ON COLUMN BARS.CIM_F503.P1900 IS '���������� �������';
COMMENT ON COLUMN BARS.CIM_F503.PVAL IS '��� ������';
COMMENT ON COLUMN BARS.CIM_F503.P1500 IS '��� �������';
COMMENT ON COLUMN BARS.CIM_F503.M IS '������ �������';
COMMENT ON COLUMN BARS.CIM_F503.P1600 IS '���������� ���������';
COMMENT ON COLUMN BARS.CIM_F503.P9800 IS '���� ���������� �������';
COMMENT ON COLUMN BARS.CIM_F503.P1700 IS '��� ����������� ��������� �������';
COMMENT ON COLUMN BARS.CIM_F503.P0200 IS '����� ����������� �������';
COMMENT ON COLUMN BARS.CIM_F503.R_AGREE_NO IS '����� ��������� ��������(��������)';
COMMENT ON COLUMN BARS.CIM_F503.P1200 IS '���� ������������� ��������';
COMMENT ON COLUMN BARS.CIM_F503.P1800 IS 'ϳ������ ������� ����';
COMMENT ON COLUMN BARS.CIM_F503.T IS '����� ������(���� ���� ������)';
COMMENT ON COLUMN BARS.CIM_F503.P9500 IS '�������� ��������� ������';
COMMENT ON COLUMN BARS.CIM_F503.P9600 IS 'ֳ� ������������ �������';
COMMENT ON COLUMN BARS.CIM_F503.P3100 IS '����� ��������� �������';
COMMENT ON COLUMN BARS.CIM_F503.P9900 IS '�������';
COMMENT ON COLUMN BARS.CIM_F503.P0400 IS '��� ��������� ������';
COMMENT ON COLUMN BARS.CIM_F503.P0800_1 IS '���� �������� ��������� ������(1��3)';
COMMENT ON COLUMN BARS.CIM_F503.P0800_2 IS '���� �������� ��������� ������(2��3)';
COMMENT ON COLUMN BARS.CIM_F503.P0800_3 IS '���� �������� ��������� ������(3��3)';
COMMENT ON COLUMN BARS.CIM_F503.P0700 IS '����� ���� ��������� ������';
COMMENT ON COLUMN BARS.CIM_F503.P0900 IS '�������� ���� �������';
COMMENT ON COLUMN BARS.CIM_F503.P0500 IS '����� �������� �����';
COMMENT ON COLUMN BARS.CIM_F503.P0600 IS '���� �������� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2010 IS '���� ������������� �� ���������, ��� �� �� ��������� ��������';
COMMENT ON COLUMN BARS.CIM_F503.P2011 IS '����������� ������������� �� �������� ����� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2012 IS '���������� �������� ������';
COMMENT ON COLUMN BARS.CIM_F503.P2013 IS '���������� ������ �� ���� ������';
COMMENT ON COLUMN BARS.CIM_F503.P2014 IS '���������� ���� �� ���������� ������';
COMMENT ON COLUMN BARS.CIM_F503.P2016 IS '�������� ���� �������';
COMMENT ON COLUMN BARS.CIM_F503.P2017 IS '������ ������ � ������� ��������� ������� ���� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2018 IS '������ �������� ������';
COMMENT ON COLUMN BARS.CIM_F503.P2020 IS '������ ������ �� ���� ������';
COMMENT ON COLUMN BARS.CIM_F503.P2021 IS '���� �� ���������� ������, �� �������� ����� � ������� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2022 IS '�������� �������� ������� � ������� ��������� ������� ���� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2023 IS '���������� �������� ������� � ������� ��������� ������� ���� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2024 IS '����������� ������������� �������� ������� � ������� ��������� ������� ���� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2025 IS '������������� ������� � ������� ��������� ������� ���� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2026 IS '������������� ������ ��������� ������ ��������� � ���������� ������ ������������';
COMMENT ON COLUMN BARS.CIM_F503.P2027 IS '������������� �������� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2028 IS '������������� ������ ����������';
COMMENT ON COLUMN BARS.CIM_F503.P2029 IS '�������� �������� ��������';
COMMENT ON COLUMN BARS.CIM_F503.P2030 IS '���������� �������� ��������';
COMMENT ON COLUMN BARS.CIM_F503.P2031 IS '�������� �������� ����������� ������������� � ���������';
COMMENT ON COLUMN BARS.CIM_F503.P2032 IS '������������� ������� � ������� ��������� ��������';
COMMENT ON COLUMN BARS.CIM_F503.P2033 IS '������������� ������� ������ ��������� ������ ��������� � ���������� ������ ������������';
COMMENT ON COLUMN BARS.CIM_F503.P2034 IS '������������� ������ �������� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2035 IS '������������� ������ ����������';
COMMENT ON COLUMN BARS.CIM_F503.P2036 IS '�������� �������� �������� �� ����� �������';
COMMENT ON COLUMN BARS.CIM_F503.P2037 IS '�������� �������� ��� �� ���������� ������';
COMMENT ON COLUMN BARS.CIM_F503.P2038 IS '����������� ������������� �� �������� ����� �����';
COMMENT ON COLUMN BARS.CIM_F503.P2042 IS '���������� �������� ������';
COMMENT ON COLUMN BARS.CIM_F503.P3000 IS '��� ����� ���������� �� ��������';




PROMPT *** Create  constraint PK_F503_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F503 ADD CONSTRAINT PK_F503_ID PRIMARY KEY (F503_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_F503_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_F503_ID ON BARS.CIM_F503 (F503_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



begin
    execute immediate 'alter table bars.cim_f503 add (p3200  number(1))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f503.p3200 IS '��� ���� ������������';

begin
    execute immediate 'alter table bars.cim_f503 add (p3300  VARCHAR2(3))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f503.p3300 IS '��� ������ ����������';



PROMPT *** Create  grants  CIM_F503 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F503        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_F503        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_F503.sql =========*** End *** ====
PROMPT ===================================================================================== 
