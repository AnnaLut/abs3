prompt  �������� ������� DPT_BONUS_REQUESTS_ARC
/
prompt  ����� �������� �� ��������� ����� � ���������� ��������� ��
/
prompt -------------------------------------
/

exec bpa.alter_policy_info( 'DPT_BONUS_REQUESTS_ARC', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'DPT_BONUS_REQUESTS_ARC', 'FILIAL', null, null, null, null );

begin
  execute immediate 'CREATE TABLE DPT_BONUS_REQUESTS_ARC(
  DPT_ID            NUMBER(38),
  BONUS_ID          NUMBER(38),
  BONUS_VALUE_PLAN  NUMBER(9,6),
  BONUS_VALUE_FACT  NUMBER(9,6),
  REQUEST_DATE      DATE ,
  REQUEST_USER      NUMBER(38),
  REQUEST_AUTO      CHAR(1 BYTE),
  REQUEST_CONFIRM   CHAR(1 BYTE),
  REQUEST_RECALC    CHAR(1 BYTE),
  REQUEST_DELETED   CHAR(1 BYTE),
  REQUEST_STATE     VARCHAR2(5 BYTE),
  PROCESS_DATE      DATE,
  PROCESS_USER      NUMBER(38),
  REQ_ID            NUMBER(38),
  REQUEST_BDATE     DATE,
  KF                VARCHAR2(6 BYTE),
  BRANCH            VARCHAR2(30 BYTE)
) TABLESPACE brsmdld';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE DPT_BONUS_REQUESTS_ARC IS '����� �������� �� ��������� ����� � ���������� ��������� ��';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.DPT_ID IS '������������� ��������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.BONUS_ID IS '������������� ������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.BONUS_VALUE_PLAN IS '������ ��������� �������� %-��� ������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.BONUS_VALUE_FACT IS '������ ������������� �������� %-��� ������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_DATE IS '���� � ����� ������������ �������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_USER IS '������������-��������� �������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_AUTO IS '������� �������.������������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_CONFIRM IS '������� ������������� �������������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_RECALC IS '������� ������������� �����������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_DELETED IS '������� ���������� �� ���������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_STATE IS '������ �������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.PROCESS_DATE IS '���� � ����� ��������� �������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.PROCESS_USER IS '������������-���������� �������';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_BDATE IS '����.���� ������������ �������';
/


GRANT ALL ON DPT_BONUS_REQUESTS_ARC TO BARS_ACCESS_DEFROLE;
/
