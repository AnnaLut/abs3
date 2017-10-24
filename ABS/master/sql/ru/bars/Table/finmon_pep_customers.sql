begin
  bpa.alter_policy_info('FINMON_PEP_CUSTOMERS', 'WHOLE', null, null, null, null); 
  bpa.alter_policy_info('FINMON_PEP_CUSTOMERS', 'FILIAL', null, null, null, null);
end;
/
    /*
    �RNK �볺���, 
    �ϲ�/����� �볺���, 
    �� � �������, 
    ������ (���. �.4), 
    �г���� ������, 
    ������� ������ (���������� ������������ ������� ������ � ������ (Id) 2, 3, 62-65), 
    ����� ��������, 
    �RNK �������� �����, 
    �ϲ�/����� �������� �����, 
    �� � ������� (�������� �����)�, 
    ��������� (������ �������� ��볺�� ��� ��������� ������� �� ����). 
    */
begin 
execute immediate 'CREATE TABLE BARS.FINMON_PEP_CUSTOMERS
                    ( ID            number,            
                      RNK           number,
                      NMK           varchar2(150),
                      PERMIT        number(1),
                      CRISK         VARCHAR2(50),
                      CUST_RISK     VARCHAR2(50),
                      CHECK_DATE    DATE DEFAULT TRUNC(SYSDATE),
                      RNK_REEL      number,
                      NMK_REEL      varchar2(150),
                      NUM_REEL      int,
                      COMMENTS      varchar2(200)) TABLESPACE BRSBIGD';
exception when others then if (sqlcode = -955) then null; else raise; end if; 
end;
/

COMMENT ON TABLE FINMON_PEP_CUSTOMERS IS '��. ��� ��� �˲����';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.ID         IS '��������� ���';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.RNK        IS '������������ ����� �볺��� � ��';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.NMK        IS '������������ �볺��� � ��';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.PERMIT     IS '������������ �볺��� � ��';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.CRISK      IS '�������� ������ �볺��� �� ���� ��������';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.CUST_RISK  IS '������ ������ �볺��� �� ���� ��������';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.CHECK_DATE IS '���� ��������';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.RNK_REEL   IS 'RNK ���''����� �����';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.NMK_REEL   IS 'ϲ�/����� ���''����� �����';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.NUM_REEL   IS '� ���''��. ����� � (�������� �����)';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.COMMENTS   IS '��������';

/
GRANT SELECT,INSERT,UPDATE,DELETE ON FINMON_PEP_CUSTOMERS TO BARS_ACCESS_DEFROLE;
/  

