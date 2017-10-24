prompt -------------------------------------
prompt  �������� ������� DPT_VIDD_ARC
prompt  ���� ������� (�����)
prompt -------------------------------------
/

exec bpa.alter_policy_info( 'DPT_VIDD_ARC', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'DPT_VIDD_ARC', 'FILIAL', null, null, null, null );

begin
  execute immediate 'CREATE TABLE DPT_VIDD_ARC(
  VIDD               NUMBER(38) CONSTRAINT CC_DPTVIDDARCARC_VIDD_NN NOT NULL,
  DEPOSIT_COD        VARCHAR2(4 BYTE),
  TYPE_NAME          VARCHAR2(50 BYTE) CONSTRAINT CC_DPTVIDDARC_TYPENAME_NN NOT NULL,
  BASEY              INTEGER                    DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_BASEY_NN NOT NULL,
  BASEM              INTEGER                    DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_BASEM_NN NOT NULL,
  BR_ID              NUMBER(38),
  FREQ_N             NUMBER(3)                  DEFAULT 1 CONSTRAINT CC_DPTVIDDARC_FREQN_NN NOT NULL,
  FREQ_K             NUMBER(3) CONSTRAINT CC_DPTVIDDARC_FREQK_NN NOT NULL,
  BSD                CHAR(4 BYTE) CONSTRAINT CC_DPTVIDDARC_BSD_NN NOT NULL,
  BSN                CHAR(4 BYTE) CONSTRAINT CC_DPTVIDDARC_BSN_NN NOT NULL,
  METR               NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_METR_NN NOT NULL,
  AMR_METR           NUMBER                     DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_AMRMETR_NN NOT NULL,
  DURATION           NUMBER(10)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_DURATION_NN NOT NULL,
  TERM_TYPE          NUMBER                     DEFAULT 1 CONSTRAINT CC_DPTVIDDARC_TERMTYPE_NN NOT NULL,
  MIN_SUMM           NUMBER(24),
  COMMENTS           VARCHAR2(128 BYTE),
  FLAG               NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_FLAG_NN NOT NULL,
  TYPE_COD           VARCHAR2(4 BYTE),
  KV                 NUMBER(3) CONSTRAINT CC_DPTVIDDARC_KV_NN NOT NULL,
  TT                 CHAR(3 BYTE),
  SHABLON            VARCHAR2(15 BYTE),
  IDG                NUMBER(38),
  IDS                NUMBER(38),
  NLS_K              VARCHAR2(15 BYTE),
  DATN               DATE,
  DATK               DATE,
  BR_ID_L            NUMBER(38),
  FL_DUBL            NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_FLDUBL_NN NOT NULL,
  ACC7               NUMBER(38),
  ID_STOP            NUMBER(38)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_IDSTOP_NN NOT NULL,
  KODZ               NUMBER(38),
  FMT                NUMBER(2),
  FL_2620            NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_FL2620_NN NOT NULL,
  COMPROC            NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_COMPROC_NN NOT NULL,
  LIMIT              NUMBER(24),
  TERM_ADD           NUMBER(7,2),
  TERM_DUBL          NUMBER(10)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_TERMDUBL_NN NOT NULL,
  DURATION_DAYS      NUMBER(10)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_DURATIONDAYS_NN NOT NULL,
  EXTENSION_ID       NUMBER(38),
  TIP_OST            NUMBER(1)                  DEFAULT 1 CONSTRAINT CC_DPTVIDDARC_TIPOST_NN NOT NULL,
  BR_WD              NUMBER(38),
  NLSN_K             VARCHAR2(14 BYTE),
  BSA                CHAR(4 BYTE),
  MAX_LIMIT          NUMBER(24),
  BR_BONUS           NUMBER(38)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_BRBONUS_NN NOT NULL,
  BR_OP              NUMBER(38)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_BROP_NN NOT NULL,
  AUTO_ADD           NUMBER(1)                  DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_AUTOADD_NN NOT NULL,
  TYPE_ID            NUMBER(38)                 DEFAULT 0 CONSTRAINT CC_DPTVIDDARC_TYPEID_NN NOT NULL,
  DISABLE_ADD        NUMBER(1),
  CODE_TARIFF        NUMBER(38),
  DURATION_MAX       NUMBER(3),
  DURATION_DAYS_MAX  NUMBER(3),
  IRREVOCABLE        NUMBER(1)                  DEFAULT 1 CONSTRAINT CC_DPTVIDDARC_IRREVOCABLE_NN NOT NULL,
  DATE_OFF           DATE                       DEFAULT sysdate CONSTRAINT CC_DPTVIDDARC_DATE_OFF NOT NULL,
  USER_OFF           NUMBER(38)                 DEFAULT sys_context(''bars_context'',''user_id'') CONSTRAINT CC_DPTVIDDARC_USER_OFF NOT NULL,
  SUPPLEMENTAL LOG DATA (ALL) COLUMNS,
  SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS,
  SUPPLEMENTAL LOG DATA (UNIQUE) COLUMNS,
  SUPPLEMENTAL LOG DATA (FOREIGN KEY) COLUMNS
) TABLESPACE brsmdld';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE DPT_VIDD_ARC IS '���� ������ (�����)';
COMMENT ON COLUMN DPT_VIDD_ARC.VIDD             IS '��� ���� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.DEPOSIT_COD      IS '�� ���.';
COMMENT ON COLUMN DPT_VIDD_ARC.TYPE_NAME        IS '������������ ���� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.BASEY            IS '��� �������� ����';
COMMENT ON COLUMN DPT_VIDD_ARC.BASEM            IS '������� ������.%-��� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.BR_ID            IS '��� ������� ���������� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.FREQ_N           IS '������������� ���������� %%';
COMMENT ON COLUMN DPT_VIDD_ARC.FREQ_K           IS '������������� ������� %%';
COMMENT ON COLUMN DPT_VIDD_ARC.BSD              IS '���������� ���� ��������';
COMMENT ON COLUMN DPT_VIDD_ARC.BSN              IS '���������� ���� ����������� ���������';
COMMENT ON COLUMN DPT_VIDD_ARC.METR             IS '��� ������ ���������� ���������';
COMMENT ON COLUMN DPT_VIDD_ARC.AMR_METR         IS '����� ����������� ���������';
COMMENT ON COLUMN DPT_VIDD_ARC.DURATION         IS '���� ���� ������ � �������';
COMMENT ON COLUMN DPT_VIDD_ARC.TERM_TYPE        IS '��� �����: 1-����, 0-����, 2-��������';
COMMENT ON COLUMN DPT_VIDD_ARC.MIN_SUMM         IS '����������� ����� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.COMMENTS         IS '�����������';
COMMENT ON COLUMN DPT_VIDD_ARC.FLAG             IS '���� ����������';
COMMENT ON COLUMN DPT_VIDD_ARC.TYPE_COD         IS '���������� ��� ���� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.KV               IS '������ ���� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.TT               IS '��� ��������';
COMMENT ON COLUMN DPT_VIDD_ARC.SHABLON          IS '������';
COMMENT ON COLUMN DPT_VIDD_ARC.IDG              IS '��� ������ ��� ���������� ������ ���.%%';
COMMENT ON COLUMN DPT_VIDD_ARC.IDS              IS '��� ����� ��� ���������� ������ ���.%%';
COMMENT ON COLUMN DPT_VIDD_ARC.NLS_K            IS '���� ������������ ��������';
COMMENT ON COLUMN DPT_VIDD_ARC.DATN             IS '���� ������ �������� ���� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.DATK             IS '���� ��������� �������� ���� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.BR_ID_L          IS '��� ������ �����������';
COMMENT ON COLUMN DPT_VIDD_ARC.FL_DUBL          IS '���� ������������������';
COMMENT ON COLUMN DPT_VIDD_ARC.ACC7             IS '�����.����� ����� ��������';
COMMENT ON COLUMN DPT_VIDD_ARC.ID_STOP          IS '��� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.KODZ             IS '��� ������� ��� ������ �������';
COMMENT ON COLUMN DPT_VIDD_ARC.FMT              IS '������ �������� �������';
COMMENT ON COLUMN DPT_VIDD_ARC.FL_2620          IS '������� �� ����� "�� �������������"';
COMMENT ON COLUMN DPT_VIDD_ARC.COMPROC          IS '������� �������������';
COMMENT ON COLUMN DPT_VIDD_ARC.LIMIT            IS '����������� ����� ����������';
COMMENT ON COLUMN DPT_VIDD_ARC.TERM_ADD         IS '���� ����������';
COMMENT ON COLUMN DPT_VIDD_ARC.TERM_DUBL        IS '����.���-�� ������������������ ������';
COMMENT ON COLUMN DPT_VIDD_ARC.DURATION_DAYS    IS '���� ���� ������ � ����';
COMMENT ON COLUMN DPT_VIDD_ARC.EXTENSION_ID     IS '��� ������� ������������������';
COMMENT ON COLUMN DPT_VIDD_ARC.TIP_OST          IS '��� ���������� �������';
COMMENT ON COLUMN DPT_VIDD_ARC.BR_WD            IS '��� ������ ��� ��������� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.NLSN_K           IS '���� ������������ ������.%%';
COMMENT ON COLUMN DPT_VIDD_ARC.BSA              IS '���������� ���� �����������';
COMMENT ON COLUMN DPT_VIDD_ARC.MAX_LIMIT        IS '������������ ����� ����������';
COMMENT ON COLUMN DPT_VIDD_ARC.BR_BONUS         IS '��� ������� �������� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.BR_OP            IS '��� �����.�������� ����� ������� � �������� ��������';
COMMENT ON COLUMN DPT_VIDD_ARC.AUTO_ADD         IS '���� �������������� ������';
COMMENT ON COLUMN DPT_VIDD_ARC.TYPE_ID          IS '����.��� ���� ��������';
COMMENT ON COLUMN DPT_VIDD_ARC.DISABLE_ADD      IS '������ ��������������� ��������';
COMMENT ON COLUMN DPT_VIDD_ARC.CODE_TARIFF      IS '��� ������ �� ������ ������ ��� ������.�����.';
COMMENT ON COLUMN DPT_VIDD_ARC.DURATION_MAX     IS '������������ ����� ������ � ������ (��� TERM_TYPE = 2)';
COMMENT ON COLUMN DPT_VIDD_ARC.DURATION_DAYS_MAX IS '������������ ����� ������ � � ���� (��� TERM_TYPE = 2)';
COMMENT ON COLUMN DPT_VIDD_ARC.IRREVOCABLE      IS '������������ ���������� ������ (���������� ���������� ���������)';
COMMENT ON COLUMN DPT_VIDD_ARC.DATE_OFF         IS '���� ��������� � �����';
COMMENT ON COLUMN DPT_VIDD_ARC.USER_OFF         IS '����������, ���������� ��� � �����'; 
/

GRANT ALL ON DPT_VIDD_ARC TO BARS_ACCESS_DEFROLE;
/
