prompt create table bars_intgr.bpk2
begin
    execute immediate q'[
create table bars_intgr.bpk2
(
    CHANGENUMBER NUMBER, 
	KF VARCHAR2(6), 
	BRANCH VARCHAR2(30), 
	RNK NUMBER(15,0), 
	ND NUMBER(15,0), 
	DAT_BEGIN DATE, 
	BPK_TYPE VARCHAR2(50), 
	NLS VARCHAR2(15), 
	DAOS DATE, 
	KV NUMBER(3,0), 
	INTRATE NUMBER(5,2), 
	OSTC NUMBER(15,2), 
	DATE_LASTOP DATE, 
	CRED_LINE VARCHAR2(20), 
	CRED_LIM NUMBER(15,2), 
	USE_CRED_SUM NUMBER(15,2), 
	DAZS DATE, 
	BLKD NUMBER(3,0), 
	BLKK NUMBER(3,0), 
	BPK_STATUS NUMBER(1,0), 
	PK_OKPO VARCHAR2(10), 
	PK_NAME VARCHAR2(100), 
	PK_OKPO_N NUMBER(22,0), 
	VID VARCHAR2(35), 
	LIE_SUM VARCHAR2(254), 
	LIE_VAL VARCHAR2(254), 
	LIE_DATE VARCHAR2(254), 
	LIE_DOCN VARCHAR2(254), 
	LIE_ATRT VARCHAR2(254), 
	LIE_DOC VARCHAR2(254), 
	PK_TERM VARCHAR2(254), 
	PK_OLDND VARCHAR2(254), 
	PK_WORK VARCHAR2(254), 
	PK_CNTRW VARCHAR2(254), 
	PK_OFAX VARCHAR2(254), 
	PK_PHONE VARCHAR2(254), 
	PK_PCODW VARCHAR2(254), 
	PK_ODAT VARCHAR2(254), 
	PK_STRTW VARCHAR2(254), 
	PK_CITYW VARCHAR2(254), 
	PK_OFFIC VARCHAR2(30), 
	DKBO_DATE_OFF DATE, 
	DKBO_START_DATE DATE, 
	DKBO_DEAL_NUMBER VARCHAR2(30), 
	KOS NUMBER(24,0), 
	DOS NUMBER(24,0), 
	W4_ARSUM VARCHAR2(254), 
	W4_KPROC VARCHAR2(254), 
	W4_SEC VARCHAR2(254), 
	ACC NUMBER(24,0), 
	OB22 VARCHAR2(2), 
	NMS VARCHAR2(70)
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

COMMENT ON COLUMN BARS_INTGR.BPK2.KF IS '��';
COMMENT ON COLUMN BARS_INTGR.BPK2.BRANCH IS '³�������';
COMMENT ON COLUMN BARS_INTGR.BPK2.RNK IS '���';
COMMENT ON COLUMN BARS_INTGR.BPK2.ND IS '����� ��������';
COMMENT ON COLUMN BARS_INTGR.BPK2.DAT_BEGIN IS '���� ��������';
COMMENT ON COLUMN BARS_INTGR.BPK2.BPK_TYPE IS '��� ������� �����';
COMMENT ON COLUMN BARS_INTGR.BPK2.NLS IS '����� �������';
COMMENT ON COLUMN BARS_INTGR.BPK2.DAOS IS '���� �������� �������';
COMMENT ON COLUMN BARS_INTGR.BPK2.KV IS '������ �������';
COMMENT ON COLUMN BARS_INTGR.BPK2.INTRATE IS '³�������� ������';
COMMENT ON COLUMN BARS_INTGR.BPK2.OSTC IS '�������� ������� �� �������';
COMMENT ON COLUMN BARS_INTGR.BPK2.DATE_LASTOP IS '���� �������� ��������';
COMMENT ON COLUMN BARS_INTGR.BPK2.CRED_LINE IS '�������� ���';
COMMENT ON COLUMN BARS_INTGR.BPK2.CRED_LIM IS '���� ����������� ����.��';
COMMENT ON COLUMN BARS_INTGR.BPK2.USE_CRED_SUM IS '����������� ���� ����.��';
COMMENT ON COLUMN BARS_INTGR.BPK2.DAZS IS '���� �������� �������';
COMMENT ON COLUMN BARS_INTGR.BPK2.BLKD IS '��� ���������� ������� �� ������';
COMMENT ON COLUMN BARS_INTGR.BPK2.BLKK IS '��� ���������� ������� �� �������';
COMMENT ON COLUMN BARS_INTGR.BPK2.BPK_STATUS IS '������ �������� �� ������� (1-��������, 0-��������)';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_OKPO IS '���������� ������, ������ ����������';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_NAME IS '���������� ������, ����� ����������';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_OKPO_N IS '���������� ������, ��� ������������ ��������';
COMMENT ON COLUMN BARS_INTGR.BPK2.VID IS '��� ������� (���)';
COMMENT ON COLUMN BARS_INTGR.BPK2.LIE_SUM IS '����� �������. ���� ���������';
COMMENT ON COLUMN BARS_INTGR.BPK2.LIE_VAL IS '����� �������. ������ ���������';
COMMENT ON COLUMN BARS_INTGR.BPK2.LIE_DATE IS '����� �������. ���� ���������';
COMMENT ON COLUMN BARS_INTGR.BPK2.LIE_DOCN IS '����� �������. ����� ���������';
COMMENT ON COLUMN BARS_INTGR.BPK2.LIE_ATRT IS '����� �������. �����, ���� ����� ��������';
COMMENT ON COLUMN BARS_INTGR.BPK2.LIE_DOC IS '����� �������. ����� ���������';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_TERM IS '���. ʳ������ ������ 䳿 ������';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_OLDND IS '���. ����� �������� �� ��';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_WORK IS '���. ̳��� ������';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_CNTRW IS '���. ̳��� ������: �����';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_OFAX IS '���. ̳��� ������: FAX';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_PHONE IS '���. ̳��� ������: �������';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_PCODW IS '���. ̳��� ������: �������� ������';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_ODAT IS '���. ̳��� ������: � ����� ���� ������';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_STRTW IS '���. ̳��� ������: ������';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_CITYW IS '���. ̳��� ������: ����';
COMMENT ON COLUMN BARS_INTGR.BPK2.PK_OFFIC IS '���. ������';
COMMENT ON COLUMN BARS_INTGR.BPK2.DKBO_DATE_OFF IS '���� ��������� ����';
COMMENT ON COLUMN BARS_INTGR.BPK2.DKBO_START_DATE IS '���� ��������� �� ����';
COMMENT ON COLUMN BARS_INTGR.BPK2.DKBO_DEAL_NUMBER IS '� �������� ����';
COMMENT ON COLUMN BARS_INTGR.BPK2.KOS IS '������� ������';
COMMENT ON COLUMN BARS_INTGR.BPK2.DOS IS '������� �����';
COMMENT ON COLUMN BARS_INTGR.BPK2.W4_ARSUM IS 'Way4. ���������� ����';
COMMENT ON COLUMN BARS_INTGR.BPK2.W4_KPROC IS 'Way4. ³������ �� �������';
COMMENT ON COLUMN BARS_INTGR.BPK2.W4_SEC IS 'Way4. ����� �����';
COMMENT ON COLUMN BARS_INTGR.BPK2.ACC IS '��������� ������������� �������';

prompt create unique index xpk_bpk2

begin
    execute immediate 'create unique index xpk_bpk2 on bars_intgr.bpk2(KF, ACC) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create index I_accounts_CHANGENUMBER

begin
    execute immediate 'create index I_BPK2_CHANGENUMBER on bars_intgr.bpk2(KF, CHANGENUMBER) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create error log
begin
    dbms_errlog.create_error_log(dml_table_name => 'BPK2', err_log_table_space => 'BRSDMIMP');
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
