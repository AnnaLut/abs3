begin 
 execute immediate 'drop table FINMON_PEP_RELS';
exception when others then if (sqlcode = -955) then null; else raise; end if;   
end; 
/
/*
����� ����    ����� ��������    ���    ��������
id          ��������� ���    N(6)    
idcode      ���    N(10)    
name        �������, ��� �� �� ������� �� ��� ����� ��    C(300)    
pep         �������� � �� ������� �����    C(300)    
bdate       ���� ����������        � ������ dd.mm.yyyy
doct        ��� ���������    N(2)    1 � �������
docs        ���� ���������    �(10)    
docn        ����� ���������    N(10)    
category    �������� ���    C(300)    
edate       ���� ������ ������ ���    D(10)    �������� ���� ��������� � ������, � ������ dd.mm.yyyy 
branch      ��� ��볿 ����� (���)    N(6)    
permit      ����� �� ������������ ������ �������    N(1)    1 - ���, 0 - �
remdoc      ���������� �� ������ ���������    N(1)    1 - ���, 0 - �
comment     �������    C(300)    
ptype       ��� �����    N(1)    1 - ��, 2 - ��, 3 - ���
pres        ������������    N(1)    1 - ���, 0 - �
mdate       ���� ������� ��� � �����    D(10)    � ������ dd.mm.yyyy
*/

begin
  bpa.alter_policy_info('FINMON_PEP_RELS', 'WHOLE', null, null, null, null); 
  bpa.alter_policy_info('FINMON_PEP_RELS', 'FILIAL', null, null, null, null);
end;
/

begin 
execute immediate 'CREATE TABLE BARS.FINMON_PEP_RELS
                    ( ID        NUMBER(6),                     
                      IDCODE    varchar2(10),
                      NAME      VARCHAR2(300),
                      PEP       VARCHAR2(300),
                      BDATE     DATE,
                      DOCT      NUMBER(2),
                      DOCS      VARCHAR2(10),
                      DOCN      NUMBER(10),
                      CATEGORY  VARCHAR2(300),
                      EDATE     DATE,
                      BRANCH    VARCHAR2(6),
                      PERMIT    NUMBER(1), CONSTRAINT CK_PERMIT CHECK (PERMIT IN (0,1)),
                      REMDOC    NUMBER(1), CONSTRAINT CK_REMDOC CHECK (REMDOC IN (0,1)),
                      COMMENTS  VARCHAR2(300),
                      PTYPE     NUMBER(1), CONSTRAINT CK_PTYPE CHECK (PTYPE IN (1,2,3)),
                      PRES      NUMBER(1), CONSTRAINT CK_PRES CHECK (PRES IN (0,1)),
                      MDATE     DATE)
                    TABLESPACE BRSBIGD';
exception when others then if (sqlcode = -955) then null;else raise; end if; 
end;
/
begin
 execute immediate 'alter table FINMON_PEP_RELS add DOCALL varchar2(50)';
exception when others then if (sqlcode = -955) then null; end if;
end;
/
begin
 execute immediate 'ALTER TABLE FINMON_PEP_RELS ADD PRIMARY KEY (IDCODE) ';
exception when others then if (sqlcode = -955) then null; end if;
end;
/
begin
 execute immediate 'CREATE UNIQUE INDEX IDX_DOC_FPEPRELS ON FINMON_PEP_RELS (IDCODE) TABLESPACE BRSBIGI';
exception when others then if (sqlcode = -955) then null; end if;
end;
/


COMMENT ON TABLE FINMON_PEP_RELS IS '������ ��� �˲����';
COMMENT ON COLUMN FINMON_PEP_RELS.ID         IS '��������� ���';
COMMENT ON COLUMN FINMON_PEP_RELS.IDCODE     IS '���';    
COMMENT ON COLUMN FINMON_PEP_RELS.NAME       IS '�������, ��� �� �� ������� �� ��� ����� ��';    
COMMENT ON COLUMN FINMON_PEP_RELS.PEP        IS '�������� � �� ������� �����';
COMMENT ON COLUMN FINMON_PEP_RELS.BDATE      IS '���� ����������';
COMMENT ON COLUMN FINMON_PEP_RELS.DOCT       IS '��� ���������';
COMMENT ON COLUMN FINMON_PEP_RELS.DOCS       IS '���� ���������';
COMMENT ON COLUMN FINMON_PEP_RELS.DOCN       IS '����� ���������';
COMMENT ON COLUMN FINMON_PEP_RELS.CATEGORY   IS '�������� ���';
COMMENT ON COLUMN FINMON_PEP_RELS.EDATE      IS '���� ������ ������ ���';
COMMENT ON COLUMN FINMON_PEP_RELS.BRANCH     IS '��� ��볿 ����� (���)';
COMMENT ON COLUMN FINMON_PEP_RELS.PERMIT     IS '����� �� ������������ ������ �������';
COMMENT ON COLUMN FINMON_PEP_RELS.REMDOC     IS '���������� �� ������ ���������';
COMMENT ON COLUMN FINMON_PEP_RELS.COMMENTS   IS '�������';
COMMENT ON COLUMN FINMON_PEP_RELS.PTYPE      IS '��� ����� (1-��,2-��,3-���)';
COMMENT ON COLUMN FINMON_PEP_RELS.PRES       IS '������������';
COMMENT ON COLUMN FINMON_PEP_RELS.MDATE      IS '���� ������� ��� � �����';
COMMENT ON COLUMN FINMON_PEP_RELS.DOCALL     IS '��������� ���� ��� ��, ������� ��� ������';
/
GRANT SELECT,INSERT,UPDATE,DELETE ON FINMON_PEP_RELS TO BARS_ACCESS_DEFROLE;
/  