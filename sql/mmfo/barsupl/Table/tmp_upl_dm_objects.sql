PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARSUPL/Table/TMP_UPL_DM_OBJECTS.sql =======*** Run 
PROMPT ===================================================================================== 

PROMPT *** Drop temporary table TMP_UPL_DM_OBJECTS ***
begin 

  execute immediate 'DROP TABLE BARSUPL.TMP_UPL_DM_OBJECTS CASCADE CONSTRAINTS';

exception when others then
  if sqlcode=-942 then null; else raise; end if;
  -- ORA-00942: table or view does not exist
end;
/

PROMPT *** Create  table TMP_UPL_DM_OBJECTS ***
begin 
  execute immediate '
CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_UPL_DM_OBJECTS
(
  TYPE_ID      NUMBER(38)         NOT NULL,
  TYPE         NUMBER(38)         NOT NULL,
  OBJECT_ID    NUMBER(38)         NOT NULL,
  KF           VARCHAR2(4000),
  TYPE_CODE    VARCHAR2(30),
  STATE_ID     NUMBER(38),
  DEAL_NUMBER  VARCHAR2(30),
  CUSTOMER_ID  NUMBER(38),
  PRODUCT_ID   NUMBER(38),
  START_DATE   DATE,
  EXPIRY_DATE  DATE,
  CLOSE_DATE   DATE,
  BRANCH_ID    VARCHAR2(30 CHAR),
  CURATOR_ID   NUMBER(38)
)
ON COMMIT PRESERVE ROWS';
--exception when others then
--  if sqlcode=-955 then null; else raise; end if;
end;
/

COMMENT ON TABLE  BARSUPL.TMP_UPL_DM_OBJECTS             IS '��������� ������� ��� ����������� ��������. ������ ���� ��������� �� �������� ���� ������ �� ��������.';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.TYPE_ID     IS '��� �������� �� (�� ����� ������������ ARR_TYPES)';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.TYPE        IS '��� ��"����, �������� � OBJECT_TYPE';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.OBJECT_ID   IS '���������� �������� ������������� ��"����';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.KF          IS '�����';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.TYPE_CODE   IS '��� ��"����, �������� � OBJECT_TYPE (��������� ���)';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.STATE_ID    IS '���� ��"����, �������� � OBJECT_STATE';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.DEAL_NUMBER IS '������� ����� �����, �� ���� ���� ������� �볺���';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.CUSTOMER_ID IS '������������� �볺���, � ���� �������� �����';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.PRODUCT_ID  IS '���������� �������, �� �������� �� ������';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.START_DATE  IS '���� ������� 䳿 �����';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.EXPIRY_DATE IS '���� ���������� 䳿 �����';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.CLOSE_DATE  IS '���� ���������� �������� �����';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.BRANCH_ID   IS 'Գ��� ���������� �����';
COMMENT ON COLUMN BARSUPL.TMP_UPL_DM_OBJECTS.CURATOR_ID  IS '������������� ����������� ����� - �������� �����';

CREATE INDEX BARSUPL.IDX_TMP_DM_OBJ01 ON BARSUPL.TMP_UPL_DM_OBJECTS (OBJECT_ID);
CREATE INDEX BARSUPL.IDX_TMP_DM_OBJ02 ON BARSUPL.TMP_UPL_DM_OBJECTS (TYPE_ID, OBJECT_ID, KF);

PROMPT *** Create  grants  TMP_UPL_DM_OBJECTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_UPL_DM_OBJECTS   to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARSUPL/Table/TMP_UPL_DM_OBJECTS.sql =======*** End 
PROMPT ===================================================================================== 
