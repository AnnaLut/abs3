begin
    bars_policy_adm.alter_policy_info('DEAL_ACCOUNT_TYPE', 'WHOLE', null, null, null, null);
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'CREATE TABLE DEAL_ACCOUNT_TYPE
     (
        ID                   NUMBER(5)                       NOT NULL,
        GL_ACCOUNT_TYPE_CODE CHAR(3 CHAR),
        BALANCE_ACCOUNT      VARCHAR2(6 CHAR),
        OB22_CODE            VARCHAR2(100 CHAR),
        ACCOUNT_MASK         VARCHAR2(30 CHAR),
        IS_AUTO_OPEN         CHAR(1 BYTE)                    NOT NULL
     )
     TABLESPACE BRSSMLD';
exception
    when name_already_used then
         null;
end;
/

COMMENT ON TABLE DEAL_ACCOUNT_TYPE IS '���� ������� � ������ ������ ����� ���� (���, �� ��������� ������� � ������ �����)';

COMMENT ON COLUMN DEAL_ACCOUNT_TYPE.ID IS '������������� ���� ������� �� ������';
COMMENT ON COLUMN DEAL_ACCOUNT_TYPE.GL_ACCOUNT_TYPE_CODE IS '��� ������� ������� �����';
COMMENT ON COLUMN DEAL_ACCOUNT_TYPE.BALANCE_ACCOUNT IS '���������� ����� ������� ��� ������ ���� ������� � ������ ������ ��������';
COMMENT ON COLUMN DEAL_ACCOUNT_TYPE.IS_AUTO_OPEN IS '������ ����, �� ������� ���� ����������� �������� ����������� ��� ��������� � ����� �������';

declare
     name_already_used exception;
     table_can_have_only_one_pk exception;
     pragma exception_init(name_already_used, -955);
     pragma exception_init(table_can_have_only_one_pk, -2260);
begin
    execute immediate 'ALTER TABLE DEAL_ACCOUNT_TYPE ADD CONSTRAINT PK_DEAL_ACCOUNT_TYPE PRIMARY KEY (ID) USING INDEX TABLESPACE BRSSMLI';
exception
    when name_already_used or table_can_have_only_one_pk then
         null;
end;
/

declare
    name_already_used exception;
    such_constraint_already_exists exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(such_constraint_already_exists, -2275);
begin
    lock table attribute_kind in exclusive mode;
    lock table deal_account_type in exclusive mode;

    execute immediate 'ALTER TABLE DEAL_ACCOUNT_TYPE ADD CONSTRAINT FK_DEAL_ACC_TYPE_REF_ATTR_KIND FOREIGN KEY (ID) REFERENCES ATTRIBUTE_KIND (ID)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/


