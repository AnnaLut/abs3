

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORP_DATA_ACC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORP_DATA_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORP_DATA_ACC'', ''CENTER'' , null, null, ''E'', null);
               bpa.alter_policy_info(''OB_CORP_DATA_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OB_CORP_DATA_ACC'', ''WHOLE'' , null, null, ''E'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORP_DATA_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORP_DATA_ACC 
   (SESS_ID NUMBER, 
    ACC NUMBER, 
    KF VARCHAR2(6), 
    FDAT DATE, 
    CORP_ID NUMBER, 
    NLS VARCHAR2(14), 
    KV NUMBER, 
    OKPO VARCHAR2(14), 
    OBDB NUMBER, 
    OBDBQ NUMBER, 
    OBKR NUMBER, 
    OBKRQ NUMBER, 
    OST NUMBER, 
    OSTQ NUMBER, 
    KOD_USTAN NUMBER, 
    KOD_ANALYT VARCHAR2(4), 
    DAPP DATE, 
    POSTDAT DATE, 
    NAMK VARCHAR2(70), 
    NMS VARCHAR2(70), 
    IS_LAST NUMBER(1,0),
	NBS VARCHAR2(4)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD COMPRESS 
  partition by range (FDAT)
  INTERVAL(NUMTOYMINTERVAL(1, ''MONTH''))
 (PARTITION P_OLD_DAT VALUES LESS THAN ( TO_DATE(''01.03.2017'',''DD.MM.YYYY'')),
  PARTITION P_03_2017 VALUES LESS THAN ( TO_DATE(''01.04.2017'',''DD.MM.YYYY'')),
  PARTITION P_04_2017 VALUES LESS THAN ( TO_DATE(''01.05.2017'',''DD.MM.YYYY'')),
  PARTITION P_05_2017 VALUES LESS THAN ( TO_DATE(''01.06.2017'',''DD.MM.YYYY'')),
  PARTITION P_06_2017 VALUES LESS THAN ( TO_DATE(''01.07.2017'',''DD.MM.YYYY'')),
  PARTITION P_07_2017 VALUES LESS THAN ( TO_DATE(''01.08.2017'',''DD.MM.YYYY'')),
  PARTITION P_08_2017 VALUES LESS THAN ( TO_DATE(''01.09.2017'',''DD.MM.YYYY'')),
  PARTITION P_09_2017 VALUES LESS THAN ( TO_DATE(''01.10.2017'',''DD.MM.YYYY'')),
  PARTITION P_10_2017 VALUES LESS THAN ( TO_DATE(''01.11.2017'',''DD.MM.YYYY'')),
  PARTITION P_11_2017 VALUES LESS THAN ( TO_DATE(''01.12.2017'',''DD.MM.YYYY'')),
  PARTITION P_12_2017 VALUES LESS THAN ( TO_DATE(''01.01.2018'',''DD.MM.YYYY'')),
  PARTITION P_01_2018 VALUES LESS THAN ( TO_DATE(''01.02.2018'',''DD.MM.YYYY'')),
  PARTITION P_02_2018 VALUES LESS THAN ( TO_DATE(''01.03.2018'',''DD.MM.YYYY'')),
  PARTITION P_03_2018 VALUES LESS THAN ( TO_DATE(''01.04.2018'',''DD.MM.YYYY'')),
  PARTITION P_04_2018 VALUES LESS THAN ( TO_DATE(''01.05.2018'',''DD.MM.YYYY'')),
  PARTITION P_05_2018 VALUES LESS THAN ( TO_DATE(''01.06.2018'',''DD.MM.YYYY'')),
  PARTITION P_06_2018 VALUES LESS THAN ( TO_DATE(''01.07.2018'',''DD.MM.YYYY'')),
  PARTITION P_07_2018 VALUES LESS THAN ( TO_DATE(''01.08.2018'',''DD.MM.YYYY'')),
  PARTITION P_08_2018 VALUES LESS THAN ( TO_DATE(''01.09.2018'',''DD.MM.YYYY'')),
  PARTITION P_09_2018 VALUES LESS THAN ( TO_DATE(''01.10.2018'',''DD.MM.YYYY''))) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
    execute immediate 'alter table OB_CORP_DATA_ACC add nbs VARCHAR2(4)';          
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/


PROMPT *** ALTER_POLICIES to OB_CORP_DATA_ACC ***
 exec bpa.alter_policies('OB_CORP_DATA_ACC');


COMMENT ON TABLE BARS.OB_CORP_DATA_ACC IS '��� �-����� � ����� �������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.SESS_ID IS '������������� ��� ������������ ����� � ��';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.ACC IS '�� �������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.KF IS '��� �����';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.FDAT IS '����, �� ��� ����������� �-����';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.CORP_ID IS '�� ����������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.NLS IS '�������� ������� (������� �������  ��� ����������� �����)';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.KV IS '������ �������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.OKPO IS '��� ����';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.OBDB IS '������� ������� � �����';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.OBDBQ IS '������� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.OBKR IS '�������� ������� � �����';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.OBKRQ IS '�������� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.OST IS '�������� ������� � �����';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.OSTQ IS '�������� ������� (��������� � ����������� �����)';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.KOD_USTAN IS '��� �������� �������������� �볺���';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.KOD_ANALYT IS '��� ����������� �����';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.DAPP IS '���� ������������ ���� �� �������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.POSTDAT IS '���� ���������� � ��� (���� ���� �� ������� ��� ������� �� �������)';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.NAMK IS '������������ �볺���';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.NMS IS '������������ �������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.IS_LAST IS '����������� �����';
COMMENT ON COLUMN BARS.OB_CORP_DATA_ACC.NBS IS '���������� �������';


PROMPT *** Create  index IND_OB_CORP_DATA_ACC_CORP ***
begin   
 execute immediate '
  CREATE INDEX BARS.IND_OB_CORP_DATA_ACC_CORP ON BARS.OB_CORP_DATA_ACC (FDAT, IS_LAST, CORP_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IND_OB_CORP_DATA_ACC_CORP ***
begin   
 execute immediate '
  CREATE INDEX BARS.IND_OB_CORP_DATA_ACC_CORP ON BARS.OB_CORP_DATA_ACC (FDAT, IS_LAST, CORP_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  OB_CORP_DATA_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OB_CORP_DATA_ACC to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORP_DATA_ACC.sql =========*** End 
PROMPT ===================================================================================== 

