exec bpa.alter_policy_info('COMPEN_PARAMS_DATA', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_PARAMS_DATA', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_PARAMS_DATA
(
  id        NUMBER not null,
  par       VARCHAR2(32),
  val       VARCHAR2(64),
  kf        VARCHAR2(6),
  branch    VARCHAR2(30),
  date_from DATE,
  date_to   DATE,
  is_enable NUMBER(1),
  userid    NUMBER(38),
  upd_date  DATE
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_PARAMS_DATA
  is '�������� ��������� ������ ����';
-- Add comments to the columns 
comment on column COMPEN_PARAMS_DATA.par
  is '������������ ���������';
comment on column COMPEN_PARAMS_DATA.val
  is '�������� ���������';
comment on column COMPEN_PARAMS_DATA.kf
  is '��� �� ��� 䳺 ��������';
comment on column COMPEN_PARAMS_DATA.branch
  is '����� �� ���� 䳺 ��������';
comment on column COMPEN_PARAMS_DATA.date_from
  is '���� ������� 䳿 ����';
comment on column COMPEN_PARAMS_DATA.date_to
  is '���� ���������� 䳿 ����';
comment on column COMPEN_PARAMS_DATA.is_enable
  is '������ 䳿 ���� (0 - �� 䳺/ 1-䳺)';
comment on column COMPEN_PARAMS_DATA.userid
  is '������������� �����������, ���� ��� ����';
comment on column COMPEN_PARAMS_DATA.upd_date
  is '���� �� ��� �������� ���';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_PARAMS_DATA
  add constraint PK_COMPENPARAMSDATA primary key (ID)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PARAMS_DATA
  add constraint FK_CRKRPARDATA_BANKSRU_KF foreign key (KF)
  references BANKS_RU (MFO)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PARAMS_DATA
  add constraint FK_CRKRPARDATA_BRANCH_BRANCH foreign key (BRANCH)
  references BRANCH (BRANCH)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PARAMS_DATA
  add constraint FK_CRKRPARDATA_CRKRPAR_PAR foreign key (PAR)
  references COMPEN_PARAMS (PAR)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table COMPEN_PARAMS_DATA
  add constraint CC_COMPENPARAMSPAR_NN
  check ("PAR" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


alter table COMPEN_PARAMS_DATA modify is_enable default 0;
alter table COMPEN_PARAMS_DATA modify userid default sys_context('bars_global', 'user_id');
alter table COMPEN_PARAMS_DATA modify upd_date default sysdate;

-- Grant/Revoke object privileges 
grant select, insert, update, delete on COMPEN_PARAMS_DATA to BARS_ACCESS_DEFROLE;
