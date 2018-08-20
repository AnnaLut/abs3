prompt create table bars_intgr.clientfo2

begin
    execute immediate q'[
create table bars_intgr.clientfo2
(
CHANGENUMBER NUMBER,
LAST_NAME VARCHAR2(50),
FIRST_NAME VARCHAR2(50),
MIDDLE_NAME VARCHAR2(60),
BDAY DATE,
GR VARCHAR2(30),
PASSP NUMBER(22, 0),
SER VARCHAR2(10),
NUMDOC VARCHAR2(20),
PDATE DATE,
ORGAN VARCHAR2(150),
PASSP_EXPIRE_TO DATE,
PASSP_TO_BANK DATE,
KF  VARCHAR2(6),
RNK NUMBER(22, 0),
OKPO VARCHAR2(14),
CUST_STATUS VARCHAR2(20),
CUST_ACTIVE NUMBER(22, 0),
TELM VARCHAR2(20),
TELW VARCHAR2(20),
TELD VARCHAR2(20),
TELADD VARCHAR2(20),
EMAIL VARCHAR2(100),
ADR_POST_COUNTRY VARCHAR2(55),
ADR_POST_DOMAIN VARCHAR2(30),
ADR_POST_REGION VARCHAR2(30),
ADR_POST_LOC VARCHAR2(30),
ADR_POST_ADR VARCHAR2(100),
ADR_POST_ZIP VARCHAR2(20),
ADR_FACT_COUNTRY VARCHAR2(55),
ADR_FACT_DOMAIN VARCHAR2(30),
ADR_FACT_REGION VARCHAR2(30),
ADR_FACT_LOC VARCHAR2(30),
ADR_FACT_ADR VARCHAR2(100),
ADR_FACT_ZIP VARCHAR2(20),
ADR_WORK_COUNTRY VARCHAR2(55),
ADR_WORK_DOMAIN VARCHAR2(30),
ADR_WORK_REGION VARCHAR2(30),
ADR_WORK_LOC VARCHAR2(30),
ADR_WORK_ADR VARCHAR2(100),
ADR_WORK_ZIP VARCHAR2(20),
BRANCH VARCHAR2(30),
NEGATIV_STATUS VARCHAR2(10),
REESTR_MOB_BANK VARCHAR2(10),
REESTR_INET_BANK VARCHAR2(10),
REESTR_SMS_BANK VARCHAR2(10),
MONTH_INCOME NUMBER(22, 2),
SUBJECT_ROLE VARCHAR2(10),
REZIDENT VARCHAR2(10),
MERRIED VARCHAR2(500),
EMP_STATUS VARCHAR2(10),
SUBJECT_CLASS VARCHAR2(10),
INSIDER VARCHAR2(10),
SEX CHAR(1),
VIPK NUMBER(22, 0),
VIP_FIO_MANAGER VARCHAR2(250),
VIP_PHONE_MANAGER VARCHAR2(30),
DATE_ON DATE,
DATE_OFF DATE,
EDDR_ID VARCHAR2(20),
IDCARD_VALID_DATE DATE,
IDDPL VARCHAR2(500),
BPLACE VARCHAR2(70),
SUBSD VARCHAR2(500),
SUBSN VARCHAR2(500),
ELT_N VARCHAR2(500),
ELT_D VARCHAR2(500),
GCIF VARCHAR2(30),
NOMPDV VARCHAR2(9),
NOM_DOG VARCHAR2(10),
SW_RN VARCHAR2(500),
Y_ELT VARCHAR2(500),
ADM VARCHAR2(70),
FADR VARCHAR2(500),
ADR_ALT VARCHAR2(70),
BUSSS VARCHAR2(500),
PC_MF VARCHAR2(500),
PC_Z4 VARCHAR2(500),
PC_Z3 VARCHAR2(500),
PC_Z5 VARCHAR2(500),
PC_Z2 VARCHAR2(500),
PC_Z1 VARCHAR2(500),
AGENT VARCHAR2(500),
PC_SS VARCHAR2(500),
STMT VARCHAR2(500),
VIDKL VARCHAR2(500),
VED CHAR(5),
TIPA VARCHAR2(500),
PHKLI VARCHAR2(500),
AF1_9 VARCHAR2(500),
IDDPD VARCHAR2(500),
DAIDI VARCHAR2(500),
DATVR VARCHAR2(500),
DATZ VARCHAR2(500),
DATE_PHOTO DATE,
IDDPR VARCHAR2(500),
ISE CHAR(5),
OBSLU VARCHAR2(500),
CRSRC VARCHAR2(500),
DJOTH VARCHAR2(500),
DJAVI VARCHAR2(500),
DJ_TC VARCHAR2(500),
DJOWF VARCHAR2(500),
DJCFI VARCHAR2(500),
DJ_LN VARCHAR2(500),
DJ_FH VARCHAR2(500),
DJ_CP VARCHAR2(500),
CHORN VARCHAR2(500),
CRISK_KL VARCHAR2(1),
BC NUMBER(22, 0),
SPMRK VARCHAR2(500),
K013 VARCHAR2(500),
KODID VARCHAR2(500),
COUNTRY NUMBER(22, 0),
MS_FS VARCHAR2(500),
MS_VD VARCHAR2(500),
MS_GR VARCHAR2(500),
LIM_KASS NUMBER(22, 0),
LIM NUMBER(22, 0),
LICO VARCHAR2(500),
UADR VARCHAR2(500),
MOB01 VARCHAR2(500),
MOB02 VARCHAR2(500),
MOB03 VARCHAR2(500),
SUBS VARCHAR2(500),
K050 CHAR(3),
DEATH VARCHAR2(500),
NO_PHONE NUMBER(22, 0),
NSMCV VARCHAR2(500),
NSMCC VARCHAR2(500),
NSMCT VARCHAR2(500),
NOTES VARCHAR2(140),
SAMZ VARCHAR2(500),
OREP VARCHAR2(500),
OVIFS VARCHAR2(500),
AF6 VARCHAR2(500),
FSKRK VARCHAR2(500),
FSOMD VARCHAR2(500),
FSVED VARCHAR2(500),
FSZPD VARCHAR2(500),
FSPOR VARCHAR2(500),
FSRKZ VARCHAR2(500),
FSZOP VARCHAR2(500),
FSKPK VARCHAR2(500),
FSKPR VARCHAR2(500),
FSDIB VARCHAR2(500),
FSCP VARCHAR2(500),
FSVLZ VARCHAR2(500),
FSVLA VARCHAR2(500),
FSVLN VARCHAR2(500),
FSVLO VARCHAR2(500),
FSSST VARCHAR2(500),
FSSOD VARCHAR2(500),
FSVSN VARCHAR2(500),
DOV_P VARCHAR2(500),
DOV_A VARCHAR2(500),
DOV_F VARCHAR2(500),
NMKV VARCHAR2(70),
SN_GC VARCHAR2(500),
NMKK VARCHAR2(38),
PRINSIDER NUMBER(22, 0),
NOTESEC VARCHAR2(256),
MB CHAR(1),
PUBLP VARCHAR2(500),
WORKB VARCHAR2(500),
C_REG NUMBER(22, 0),
C_DST NUMBER(22, 0),
RGADM VARCHAR2(30),
RGTAX VARCHAR2(30),
DATEA DATE,
DATET DATE,
RNKP NUMBER(22, 0),
CIGPO VARCHAR2(500),
COUNTRY_NAME VARCHAR2(70),
TARIF VARCHAR2(500),
AINAB VARCHAR2(500),
TGR NUMBER(22, 0),
CUSTTYPE NUMBER(22, 0),
RIZIK VARCHAR2(500),
SNSDR VARCHAR2(500),
IDPIB VARCHAR2(500),
FS CHAR(2),
SED CHAR(4),
DJER VARCHAR2(500),
CODCAGENT NUMBER(22, 0),
SUTD VARCHAR2(500),
RVDBC VARCHAR2(500),
RVIBA VARCHAR2(500),
RVIDT VARCHAR2(500),
RV_XA VARCHAR2(500),
RVIBR VARCHAR2(500),
RVIBB VARCHAR2(500),
RVRNK VARCHAR2(500),
RVPH1 VARCHAR2(500),
RVPH2 VARCHAR2(500),
RVPH3 VARCHAR2(500),
SAB VARCHAR2(6),
VIP_ACCOUNT_MANAGER VARCHAR2(500)
)
tablespace BRSDMIMP
PARTITION by list (KF)
 (  
 PARTITION KF_300465 VALUES ('300465'),
 PARTITION KF_302076 VALUES ('302076'),
 PARTITION KF_303398 VALUES ('303398'),
 PARTITION KF_304665 VALUES ('304665'),
 PARTITION KF_305482 VALUES ('305482'),
 PARTITION KF_311647 VALUES ('311647'),
 PARTITION KF_312356 VALUES ('312356'),
 PARTITION KF_313957 VALUES ('313957'),
 PARTITION KF_315784 VALUES ('315784'),
 PARTITION KF_322669 VALUES ('322669'),
 PARTITION KF_323475 VALUES ('323475'),
 PARTITION KF_324805 VALUES ('324805'),
 PARTITION KF_325796 VALUES ('325796'),
 PARTITION KF_326461 VALUES ('326461'),
 PARTITION KF_328845 VALUES ('328845'),
 PARTITION KF_331467 VALUES ('331467'),
 PARTITION KF_333368 VALUES ('333368'),
 PARTITION KF_335106 VALUES ('335106'),
 PARTITION KF_336503 VALUES ('336503'),
 PARTITION KF_337568 VALUES ('337568'),
 PARTITION KF_338545 VALUES ('338545'),
 PARTITION KF_351823 VALUES ('351823'),
 PARTITION KF_352457 VALUES ('352457'),
 PARTITION KF_353553 VALUES ('353553'),
 PARTITION KF_354507 VALUES ('354507'),
 PARTITION KF_356334 VALUES ('356334')
 )]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

comment on column bars_intgr.clientfo2.LAST_NAME is q'[�������]';
comment on column bars_intgr.clientfo2.FIRST_NAME is q'[���]';
comment on column bars_intgr.clientfo2.MIDDLE_NAME is q'[��-�������]';
comment on column bars_intgr.clientfo2.BDAY is q'[���� ����������]';
comment on column bars_intgr.clientfo2.GR is q'[������������]';
comment on column bars_intgr.clientfo2.PASSP is q'[��� ���������]';
comment on column bars_intgr.clientfo2.SER is q'[����]';
comment on column bars_intgr.clientfo2.NUMDOC is q'[����� ���������]';
comment on column bars_intgr.clientfo2.PDATE is q'[���� ������]';
comment on column bars_intgr.clientfo2.ORGAN is q'[����� ������]';
comment on column bars_intgr.clientfo2.PASSP_EXPIRE_TO is q'[�������� ������ ��]';
comment on column bars_intgr.clientfo2.PASSP_TO_BANK is '���� ����''������� ��������� �����';
comment on column bars_intgr.clientfo2.KF is q'[���]';
comment on column bars_intgr.clientfo2.RNK is q'[���]';
comment on column bars_intgr.clientfo2.OKPO is q'[���]';
comment on column bars_intgr.clientfo2.CUST_STATUS is q'[������ �볺��� � ����]';
comment on column bars_intgr.clientfo2.CUST_ACTIVE is q'[��� ��������� �볺���]';
comment on column bars_intgr.clientfo2.TELM is q'[�������� �������]';
comment on column bars_intgr.clientfo2.TELW is q'[������� �������]';
comment on column bars_intgr.clientfo2.TELD is q'[���������� �������]';
comment on column bars_intgr.clientfo2.TELADD is q'[�������� ��������]';
comment on column bars_intgr.clientfo2.EMAIL is q'[���������� �����]';
comment on column bars_intgr.clientfo2.ADR_POST_COUNTRY is q'[�����]';
comment on column bars_intgr.clientfo2.ADR_POST_DOMAIN is q'[�������]';
comment on column bars_intgr.clientfo2.ADR_POST_REGION is q'[�����]';
comment on column bars_intgr.clientfo2.ADR_POST_LOC is q'[��������� �����]';
comment on column bars_intgr.clientfo2.ADR_POST_ADR is q'[������, �������, ��������]';
comment on column bars_intgr.clientfo2.ADR_POST_ZIP is q'[�������� ������]';
comment on column bars_intgr.clientfo2.ADR_FACT_COUNTRY is q'[�����]';
comment on column bars_intgr.clientfo2.ADR_FACT_DOMAIN is q'[�������]';
comment on column bars_intgr.clientfo2.ADR_FACT_REGION is q'[�����]';
comment on column bars_intgr.clientfo2.ADR_FACT_LOC is q'[��������� �����]';
comment on column bars_intgr.clientfo2.ADR_FACT_ADR is q'[������, �������, ��������]';
comment on column bars_intgr.clientfo2.ADR_FACT_ZIP is q'[�������� ������]';
comment on column bars_intgr.clientfo2.ADR_WORK_COUNTRY is q'[�����]';
comment on column bars_intgr.clientfo2.ADR_WORK_DOMAIN is q'[�������]';
comment on column bars_intgr.clientfo2.ADR_WORK_REGION is q'[�����]';
comment on column bars_intgr.clientfo2.ADR_WORK_LOC is q'[��������� �����]';
comment on column bars_intgr.clientfo2.ADR_WORK_ADR is q'[������, �������, ��������]';
comment on column bars_intgr.clientfo2.ADR_WORK_ZIP is q'[�������� ������]';
comment on column bars_intgr.clientfo2.BRANCH is q'[³�������]';
comment on column bars_intgr.clientfo2.NEGATIV_STATUS is q'[���������� ������]';
comment on column bars_intgr.clientfo2.REESTR_MOB_BANK is q'[��������� � ��������� �������]';
comment on column bars_intgr.clientfo2.REESTR_INET_BANK is q'[��������� � ��������-�������]';
comment on column bars_intgr.clientfo2.REESTR_SMS_BANK is q'[��������� � ���-�������]';
comment on column bars_intgr.clientfo2.MONTH_INCOME is q'[�������� ������� �����]';
comment on column bars_intgr.clientfo2.SUBJECT_ROLE is '���� ��� ���''����';
comment on column bars_intgr.clientfo2.REZIDENT is q'[��������]';
comment on column bars_intgr.clientfo2.MERRIED is q'[ѳ������ ����]';
comment on column bars_intgr.clientfo2.EMP_STATUS is q'[������ ��������� �����]';
comment on column bars_intgr.clientfo2.SUBJECT_CLASS is '������������ ���''����';
comment on column bars_intgr.clientfo2.INSIDER is q'[������ ������������ �� ���������]';
comment on column bars_intgr.clientfo2.SEX is q'[�����]';
comment on column bars_intgr.clientfo2.VIPK is q'[�������� ��������� ²�]';
comment on column bars_intgr.clientfo2.VIP_FIO_MANAGER is q'[ϲ� ���������� �� ²�]';
comment on column bars_intgr.clientfo2.VIP_PHONE_MANAGER is q'[������� ���������� �� ²�]';
comment on column bars_intgr.clientfo2.DATE_ON is q'[���� �������� �볺���]';
comment on column bars_intgr.clientfo2.DATE_OFF is q'[���� �������� ��� �볺���]';
comment on column bars_intgr.clientfo2.EDDR_ID is q'[����� ������ � ����]';
comment on column bars_intgr.clientfo2.IDCARD_VALID_DATE is q'[ĳ����� �� (������� ID-������)]';
comment on column bars_intgr.clientfo2.IDDPL is q'[���� ������� �������������]';
comment on column bars_intgr.clientfo2.BPLACE is q'[̳��� ����������]';
comment on column bars_intgr.clientfo2.SUBSD is q'[���� �����䳿]';
comment on column bars_intgr.clientfo2.SUBSN is q'[����� �����䳿]';
comment on column bars_intgr.clientfo2.ELT_N is q'[ELT. ����� �������� �볺��-����]';
comment on column bars_intgr.clientfo2.ELT_D is q'[ELT. ���� �������� �볺��-����]';
comment on column bars_intgr.clientfo2.GCIF is q'[GCIF]';
comment on column bars_intgr.clientfo2.NOMPDV is q'[����� � ����� ���]';
comment on column bars_intgr.clientfo2.NOM_DOG is q'[����� �������� �� �������]';
comment on column bars_intgr.clientfo2.SW_RN is q'[����� �볺��� ���������]';
comment on column bars_intgr.clientfo2.Y_ELT is q'[������������� ������ ���������]';
comment on column bars_intgr.clientfo2.ADM is q'[����. ����� ���������]';
comment on column bars_intgr.clientfo2.FADR is q'[������ ����������� �����������]';
comment on column bars_intgr.clientfo2.ADR_ALT is q'[������������� ������]';
comment on column bars_intgr.clientfo2.BUSSS is q'[������-������]';
comment on column bars_intgr.clientfo2.PC_MF is q'[���. ĳ���� ������� �����]';
comment on column bars_intgr.clientfo2.PC_Z4 is q'[���. �������������. ĳ� ��]';
comment on column bars_intgr.clientfo2.PC_Z3 is q'[���. �������������. ��� �������]';
comment on column bars_intgr.clientfo2.PC_Z5 is q'[���. �������������. ���� �������]';
comment on column bars_intgr.clientfo2.PC_Z2 is q'[���. �������������. �����]';
comment on column bars_intgr.clientfo2.PC_Z1 is q'[���. �������������. ����]';
comment on column bars_intgr.clientfo2.AGENT is q'[���. ��� ������ ���������� �� ������]';
comment on column bars_intgr.clientfo2.PC_SS is q'[���. ѳ������ ����]';
comment on column bars_intgr.clientfo2.STMT is q'[³� �������]';
comment on column bars_intgr.clientfo2.VIDKL is q'[³� �볺���]';
comment on column bars_intgr.clientfo2.VED is q'[��� ��������� ��������]';
comment on column bars_intgr.clientfo2.TIPA is q'[��� ��������� ���� ��������]';
comment on column bars_intgr.clientfo2.PHKLI is q'[���� ������, ����� ����������� �볺��]';
comment on column bars_intgr.clientfo2.AF1_9 is q'[��� ��� ��������� �� ���]';
comment on column bars_intgr.clientfo2.IDDPD is q'[���� �������� � ������ ������� ���]';
comment on column bars_intgr.clientfo2.DAIDI is q'[���� ��������� �� ������ ������. �������� �볺���]';
comment on column bars_intgr.clientfo2.DATVR is q'[���� �������� ������� �������]';
comment on column bars_intgr.clientfo2.DATZ is q'[ ���� ���������� ���������� ������]';
comment on column bars_intgr.clientfo2.DATE_PHOTO is q'[���� �������� ����������]';
comment on column bars_intgr.clientfo2.IDDPR is q'[���� ��������� �������.]';
comment on column bars_intgr.clientfo2.ISE is q'[������������� ������ ��������]';
comment on column bars_intgr.clientfo2.OBSLU is q'[������ �������������� �볺���]';
comment on column bars_intgr.clientfo2.CRSRC is q'[������� ���������(DPT-���.������, CCK-����.���.)]';
comment on column bars_intgr.clientfo2.DJOTH is q'[�������. ����]';
comment on column bars_intgr.clientfo2.DJAVI is q'[�������. ��������� �����]';
comment on column bars_intgr.clientfo2.DJ_TC is q'[�������. ����� �� ������]';
comment on column bars_intgr.clientfo2.DJOWF is q'[�������. ����� �����]';
comment on column bars_intgr.clientfo2.DJCFI is q'[�������. ����� ��������� �� ��.]';
comment on column bars_intgr.clientfo2.DJ_LN is q'[�������. ������]';
comment on column bars_intgr.clientfo2.DJ_FH is q'[�������. Գ������� ��������]';
comment on column bars_intgr.clientfo2.DJ_CP is q'[�������. ��]';
comment on column bars_intgr.clientfo2.CHORN is q'[�����������]';
comment on column bars_intgr.clientfo2.CRISK_KL is q'[���� ������������]';
comment on column bars_intgr.clientfo2.BC is q'[�볺�� �����]';
comment on column bars_intgr.clientfo2.SPMRK is q'[��� "������� ������" �����.]';
comment on column bars_intgr.clientfo2.K013 is q'[��� ���� �볺���]';
comment on column bars_intgr.clientfo2.KODID is q'[��� ���������. �볺���]';
comment on column bars_intgr.clientfo2.COUNTRY is q'[��� �����]';
comment on column bars_intgr.clientfo2.MS_FS is q'[���.-������� �����]';
comment on column bars_intgr.clientfo2.MS_VD is q'[������ ���� ��������]';
comment on column bars_intgr.clientfo2.MS_GR is q'[��������� �� �����]';
comment on column bars_intgr.clientfo2.LIM_KASS is q'[˳�� ����]';
comment on column bars_intgr.clientfo2.LIM is q'[˳�� �� ������ ������.]';
comment on column bars_intgr.clientfo2.LICO is q'[˳���糿 �� ���. ������ ����.]';
comment on column bars_intgr.clientfo2.UADR is q'[̳����������. ��. ������]';
comment on column bars_intgr.clientfo2.MOB01 is q'[�������� 1]';
comment on column bars_intgr.clientfo2.MOB02 is q'[�������� 2]';
comment on column bars_intgr.clientfo2.MOB03 is q'[�������� 3]';
comment on column bars_intgr.clientfo2.SUBS is q'[�������� �����䳿]';
comment on column bars_intgr.clientfo2.K050 is q'[���������� ��� �050]';
comment on column bars_intgr.clientfo2.DEATH is q'[������ �볺���]';
comment on column bars_intgr.clientfo2.NO_PHONE is q'[³�������� ���������]';
comment on column bars_intgr.clientfo2.NSMCV is q'[��� �볺���(��/����/���/����)]';
comment on column bars_intgr.clientfo2.NSMCC is q'[��� �볺��� � ����. ������]';
comment on column bars_intgr.clientfo2.NSMCT is q'[��� �볺���.�-������� �����, 2-����.]';
comment on column bars_intgr.clientfo2.NOTES is q'[������� �������]';
comment on column bars_intgr.clientfo2.SAMZ is q'[�������������]';
comment on column bars_intgr.clientfo2.OREP is q'[��������� �볺���]';
comment on column bars_intgr.clientfo2.OVIFS is q'[³��������� �������� ����� ���.]';
comment on column bars_intgr.clientfo2.AF6 is q'[³������. �������� ��� � ������� �����.]';
comment on column bars_intgr.clientfo2.FSKRK is q'[����.����.���.�����.���.������� �� ��]';
comment on column bars_intgr.clientfo2.FSOMD is '̳�. �����. ����� ��''�';
comment on column bars_intgr.clientfo2.FSVED is q'[���������������� ��������]';
comment on column bars_intgr.clientfo2.FSZPD is q'[������� ����. ��������(��)]';
comment on column bars_intgr.clientfo2.FSPOR is q'[�������� �� ���. ������. ��]';
comment on column bars_intgr.clientfo2.FSRKZ is q'[����. ������.����.��������.�� �����.]';
comment on column bars_intgr.clientfo2.FSZOP is q'[������ �� ������� �����]';
comment on column bars_intgr.clientfo2.FSKPK is q'[�-��� �������� �����������]';
comment on column bars_intgr.clientfo2.FSKPR is q'[�-��� ������� ����������]';
comment on column bars_intgr.clientfo2.FSDIB is q'[�������� �������� � ���. ������]';
comment on column bars_intgr.clientfo2.FSCP is q'[�������� - ���� ������]';
comment on column bars_intgr.clientfo2.FSVLZ is q'[�������� - �������� ������]';
comment on column bars_intgr.clientfo2.FSVLA is q'[�������� - ����]';
comment on column bars_intgr.clientfo2.FSVLN is q'[�������� - ����������]';
comment on column bars_intgr.clientfo2.FSVLO is q'[�������� - ����������]';
comment on column bars_intgr.clientfo2.FSSST is q'[���������� ������(��)]';
comment on column bars_intgr.clientfo2.FSSOD is q'[���� ��������� ������]';
comment on column bars_intgr.clientfo2.FSVSN is q'[������ ��� ����� - �������]';
comment on column bars_intgr.clientfo2.DOV_P is q'[�������� ��� ����. �����]';
comment on column bars_intgr.clientfo2.DOV_A is q'[������ ����. �����]';
comment on column bars_intgr.clientfo2.DOV_F is q'[������� �����]';
comment on column bars_intgr.clientfo2.NMKV is '����� ��''�(���)';
comment on column bars_intgr.clientfo2.SN_GC is '����� ��''�(���. ���.)';
comment on column bars_intgr.clientfo2.NMKK is '����� ��''�(������.)';
comment on column bars_intgr.clientfo2.PRINSIDER is q'[�������� ������ ���������]';
comment on column bars_intgr.clientfo2.NOTESEC is q'[������� ��� ��]';
comment on column bars_intgr.clientfo2.MB is q'[��������� �� ������ ������]';
comment on column bars_intgr.clientfo2.PUBLP is q'[��������� �� ����. �����]';
comment on column bars_intgr.clientfo2.WORKB is q'[��������� �� ����. �����]';
comment on column bars_intgr.clientfo2.C_REG is q'[������� ϲ]';
comment on column bars_intgr.clientfo2.C_DST is q'[�������� ϲ]';
comment on column bars_intgr.clientfo2.RGADM is q'[���. ����� � �����������]';
comment on column bars_intgr.clientfo2.RGTAX is q'[���. ����� ϲ]';
comment on column bars_intgr.clientfo2.DATEA is q'[���� �����. � ����.]';
comment on column bars_intgr.clientfo2.DATET is q'[���� �����. � ϲ]';
comment on column bars_intgr.clientfo2.RNKP is q'[������. ����� ��������]';
comment on column bars_intgr.clientfo2.CIGPO is q'[������ ���������]';
comment on column bars_intgr.clientfo2.COUNTRY_NAME is q'[����� �����]';
comment on column bars_intgr.clientfo2.TARIF is q'[��������� �����(��)]';
comment on column bars_intgr.clientfo2.AINAB is q'[������� � ����� ������]';
comment on column bars_intgr.clientfo2.TGR is q'[��� ���������� ������]';
comment on column bars_intgr.clientfo2.CUSTTYPE is q'[��� �볺���]';
comment on column bars_intgr.clientfo2.RIZIK is q'[г���� ������]';
comment on column bars_intgr.clientfo2.SNSDR is q'[������� ����, ���. ���. ����. �����.]';
comment on column bars_intgr.clientfo2.IDPIB is q'[ϲ� ����., �����. �� �����. �� ������.]';
comment on column bars_intgr.clientfo2.FS is q'[����� ��������]';
comment on column bars_intgr.clientfo2.SED is q'[����� ��������������(�051)]';
comment on column bars_intgr.clientfo2.DJER is q'[�������������� ������ ����. ������]';
comment on column bars_intgr.clientfo2.CODCAGENT is q'[�������������� �볺���(�010)]';
comment on column bars_intgr.clientfo2.SUTD is q'[�������������� ��� ��������]';
comment on column bars_intgr.clientfo2.RVDBC is q'[���. DBCode]';
comment on column bars_intgr.clientfo2.RVIBA is q'[���. ������ ���. ������ ������]';
comment on column bars_intgr.clientfo2.RVIDT is q'[���. ���� ������ ������]';
comment on column bars_intgr.clientfo2.RV_XA is '���. ��''� ����� ��';
comment on column bars_intgr.clientfo2.RVIBR is q'[���. ³������� ������ ������]';
comment on column bars_intgr.clientfo2.RVIBB is q'[���. ³������� ������ ������(���)]';
comment on column bars_intgr.clientfo2.RVRNK is q'[���. ��� � ���]';
comment on column bars_intgr.clientfo2.RVPH1 is q'[���. �������-1]';
comment on column bars_intgr.clientfo2.RVPH2 is q'[���. �������-2]';
comment on column bars_intgr.clientfo2.RVPH3 is q'[���. �������-3]';
comment on column bars_intgr.clientfo2.SAB is q'[����������� ��� �볺���]';
comment on column bars_intgr.clientfo2.VIP_ACCOUNT_MANAGER is q'[������� vip-��������� � AD]';

prompt modify adr_work_adr varchar2(100)
alter table bars_intgr.clientfo2 modify adr_work_adr varchar2(100);

prompt alter column organ modify varchar2(150)
alter table bars_intgr.clientfo2 modify ORGAN VARCHAR2(150);

prompt create unique index XPK_CLIENFO2

begin
    execute immediate 'create unique index XPK_CLIENFO2 on bars_intgr.clientfo2(KF, RNK) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create index I_CLIENFO2_CHANGENUMBER

begin
    execute immediate 'create index I_CLIENFO2_CHANGENUMBER on bars_intgr.clientfo2(KF, CHANGENUMBER) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt create error log
begin
    dbms_errlog.create_error_log(dml_table_name => 'CLIENTFO2', err_log_table_space => 'BRSDMIMP');
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
