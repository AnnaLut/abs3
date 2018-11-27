begin
  BPA.ALTER_POLICY_INFO( 'NBUR_OVDP_6EX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'NBUR_OVDP_6EX', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table NBUR_OVDP_6EX
(
  date_fv       DATE not null,
  isin          VARCHAR2(20),
  kv            VARCHAR2(3),
  fv_cp         NUMBER(10,2),
  yield         NUMBER(10,6),
  kurs          NUMBER(10,6),
  koef          NUMBER(10,2),
  date_maturity DATE
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table NBUR_OVDP_6EX
  is '������ �� ����';
-- Add comments to the columns 
comment on column NBUR_OVDP_6EX.date_fv
  is '����, �� ��� ����������� ����������� �������';
comment on column NBUR_OVDP_6EX.isin
  is 'ISIN';
comment on column NBUR_OVDP_6EX.kv
  is '������ ������� ������� ������';
comment on column NBUR_OVDP_6EX.fv_cp
  is '����������� ������� ������ ������� ������ � ����������� ������������ ��������� ������, � ����� �������';
comment on column NBUR_OVDP_6EX.yield
  is '��������� �� ���������, %';
comment on column NBUR_OVDP_6EX.kurs
  is '���� ������� ������ ��� ���������� ������������ ��������� ������, %';
comment on column NBUR_OVDP_6EX.koef
  is '���������� ����������';
comment on column NBUR_OVDP_6EX.date_maturity
  is '���� ���������';

-- Create/Rebegin
begin
    execute immediate '
create index I_BRSDYND_DATEFV on NBUR_OVDP_6EX (DATE_FV)
  tablespace BRSDYNI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

