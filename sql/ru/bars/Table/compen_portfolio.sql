exec bpa.alter_policy_info('compen_portfolio', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('compen_portfolio', 'whole',  null,  'E', 'E', 'E');


begin
  execute immediate '
create table COMPEN_PORTFOLIO
(
  id                   NUMBER(14) not null,
  fio                  VARCHAR2(256),
  country              INTEGER,
  postindex            VARCHAR2(256),
  obl                  VARCHAR2(256),
  rajon                VARCHAR2(256),
  city                 VARCHAR2(256),
  address              VARCHAR2(512),
  fulladdress          VARCHAR2(999),
  icod                 VARCHAR2(128),
  doctype              INTEGER,
  docserial            VARCHAR2(16),
  docnumber            VARCHAR2(32),
  docorg               VARCHAR2(256),
  docdate              DATE,
  clientbdate          DATE,
  clientbplace         VARCHAR2(256),
  clientsex            CHAR(1),
  clientphone          VARCHAR2(128),
  registrydate         DATE,
  nsc                  VARCHAR2(32),
  ida                  VARCHAR2(32),
  nd                   VARCHAR2(256),
  sum                  NUMBER,
  ost                  NUMBER,
  dato                 DATE,
  datl                 DATE,
  attr                 VARCHAR2(10),
  card                 NUMBER(2),
  datn                 DATE,
  ver                  NUMBER(4),
  stat                 VARCHAR2(6),
  tvbv                 CHAR(3),
  branch               VARCHAR2(30),
  kv                   NUMBER(6),
  status               INTEGER,
  date_import          DATE,
  dbcode               VARCHAR2(32),
  percent              NUMBER,
  kkname               VARCHAR2(256),
  ob22                 CHAR(2),
  rnk                  NUMBER,
  branchact            VARCHAR2(30),
  close_date           DATE,
  reason_change_status VARCHAR2(255)
)tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_PORTFOLIO
  is '������������ ������';
-- Add comments to the columns 
comment on column COMPEN_PORTFOLIO.id
  is 'PK (min m_f_o_00000001 - max m_f_o_99999999)';
comment on column COMPEN_PORTFOLIO.fio
  is 'ϲ�';
comment on column COMPEN_PORTFOLIO.country
  is '��� �����';
comment on column COMPEN_PORTFOLIO.postindex
  is '�������� ������';
comment on column COMPEN_PORTFOLIO.obl
  is '�������';
comment on column COMPEN_PORTFOLIO.rajon
  is '�����';
comment on column COMPEN_PORTFOLIO.city
  is '��������� �����';
comment on column COMPEN_PORTFOLIO.address
  is '������';
comment on column COMPEN_PORTFOLIO.fulladdress
  is '����� ������';
comment on column COMPEN_PORTFOLIO.icod
  is '��� ����';
comment on column COMPEN_PORTFOLIO.doctype
  is '��� ���������';
comment on column COMPEN_PORTFOLIO.docserial
  is '���� ���������';
comment on column COMPEN_PORTFOLIO.docnumber
  is '����� ���������';
comment on column COMPEN_PORTFOLIO.docorg
  is '�����, �� ����� ��������';
comment on column COMPEN_PORTFOLIO.docdate
  is '���� ������ ���������';
comment on column COMPEN_PORTFOLIO.clientbdate
  is '���� ����������';
comment on column COMPEN_PORTFOLIO.clientbplace
  is '̳��� ����������';
comment on column COMPEN_PORTFOLIO.clientsex
  is '����� (1-�,2-�,0-�)';
comment on column COMPEN_PORTFOLIO.clientphone
  is '�������';
comment on column COMPEN_PORTFOLIO.registrydate
  is '���� ���������� �������� (datp)';
comment on column COMPEN_PORTFOLIO.nsc
  is '����� ������� ����';
comment on column COMPEN_PORTFOLIO.ida
  is 'I������i����� ������� ����';
comment on column COMPEN_PORTFOLIO.nd
  is '��� = kkmark_tvbv_id_file_nsc';
comment on column COMPEN_PORTFOLIO.sum
  is '����� ������ (sum*100)';
comment on column COMPEN_PORTFOLIO.ost
  is '����� ������ (ost*100)';
comment on column COMPEN_PORTFOLIO.dato
  is '���� �������� ������ (dato)';
comment on column COMPEN_PORTFOLIO.datl
  is '���� �������� �������� (datl)';
comment on column COMPEN_PORTFOLIO.attr
  is '������ ���i�� � ����� ��������� ����';
comment on column COMPEN_PORTFOLIO.card
  is '���������� ����� ������ ����';
comment on column COMPEN_PORTFOLIO.datn
  is '���� ����������� �������i�';
comment on column COMPEN_PORTFOLIO.ver
  is '����i� ������� ����';
comment on column COMPEN_PORTFOLIO.stat
  is '���������� �����';
comment on column COMPEN_PORTFOLIO.tvbv
  is '��� ���� ����';
comment on column COMPEN_PORTFOLIO.branch
  is '�����';
comment on column COMPEN_PORTFOLIO.kv
  is '��� ������';
comment on column COMPEN_PORTFOLIO.status
  is '������';
comment on column COMPEN_PORTFOLIO.date_import
  is '���� �������';
comment on column COMPEN_PORTFOLIO.dbcode
  is '����� ��� �������������';
comment on column COMPEN_PORTFOLIO.percent
  is '³�������� ������';
comment on column COMPEN_PORTFOLIO.kkname
  is '����� ������';
comment on column COMPEN_PORTFOLIO.ob22
  is '��22';
comment on column COMPEN_PORTFOLIO.rnk
  is '������������ ����� �볺���';
comment on column COMPEN_PORTFOLIO.branchact
  is '����� �����������';
comment on column COMPEN_PORTFOLIO.close_date
  is '���� ������� ������';
comment on column COMPEN_PORTFOLIO.reason_change_status
  is '������� ���� �������';

begin
    execute immediate 'create index IDX_COMPEN_PORTFOLIO_RNK on COMPEN_PORTFOLIO (RNK)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_PORTFOLIO_TVBV on COMPEN_PORTFOLIO (TVBV, SUBSTR(BRANCH,2,6))
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_PORTFOLIO
  add constraint PK_COMPEN_PORTFOLIO primary key (ID)
  using index 
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO
  add constraint FK_COMPEN_PORTFOLIO_STATUS foreign key (STATUS)
  references COMPEN_PORTFOLIO_STATUS (STATUS_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO add rnk_bur NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PORTFOLIO add branchact_bur VARCHAR2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PORTFOLIO add ostasvo NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO.rnk_bur
  is '������������ ����� �볺��� ���������� �� ���������';
comment on column COMPEN_PORTFOLIO.branchact_bur
  is '����� ����������� ��� ������� �� ���������';
comment on column COMPEN_PORTFOLIO.ostasvo
  is '����� ������ (ost*100) �� ����';


begin
    execute immediate 'alter table COMPEN_PORTFOLIO add branch_crkr VARCHAR2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COPMEN_PORTFOLIO_LFIO_NSC on COMPEN_PORTFOLIO (LOWER(FIO))
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_P_BRANCH_CRKR_OB22 on COMPEN_PORTFOLIO (branch_crkr, ob22)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'drop index IDX_COMPEN_P_BRANCH_CRKR';
 exception when others then 
    if sqlcode = -1418 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_PORTFOLIO_DBCODE on COMPEN_PORTFOLIO (DBCODE)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_P_BRANCHACT_RNK_BUR on COMPEN_PORTFOLIO (BRANCHACT_BUR, RNK_BUR)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_PORTFOLIO_icod on COMPEN_PORTFOLIO (icod)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_PORTFOLIO_branchact on COMPEN_PORTFOLIO (branchact)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COPMEN_PORTFOLIO_NSC on COMPEN_PORTFOLIO (NSC)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


comment on column COMPEN_PORTFOLIO.branch
  is '����� � ���� ����������� �����';
comment on column COMPEN_PORTFOLIO.branch_crkr
  is '�������� ����� ������';

begin
    execute immediate 'alter table COMPEN_PORTFOLIO add status_prev INTEGER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO.status_prev is '��������� ������ ������';


begin
    execute immediate 'alter table COMPEN_PORTFOLIO add type_person number(1) default 0';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO.type_person is '��� ����� 0-��� 1-�� (��.��������, ���� ���������)';

begin
    execute immediate 'alter table COMPEN_PORTFOLIO add name_person varchar2(255)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO.name_person is '����� ��.����� (��.��������)';

begin
    execute immediate 'alter table COMPEN_PORTFOLIO add edrpo_person varchar2(10)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO.edrpo_person is '������ ��.����� (��.��������)';


-- Grant/Revoke object privileges 
grant select, insert, update, delete on COMPEN_PORTFOLIO to START1;
grant select, insert, update, delete on COMPEN_PORTFOLIO to WR_ALL_RIGHTS;
