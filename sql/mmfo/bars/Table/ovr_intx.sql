prompt ... 

exec bpa.alter_policy_info('OVR_INTX', 'FILIAL', 'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('OVR_INTX', 'WHOLE',  null, null, null, null );


prompt ... 


-- Create table
begin
    execute immediate 'create table OVR_INTX
(
  cdat       DATE,
  acc8       NUMBER,
  sal8       NUMBER,
  ip8        NUMBER,
  ia8        NUMBER,
  pas8       NUMBER,
  akt8       NUMBER,
  acc        NUMBER,
  ost2       NUMBER,
  ip2        NUMBER,
  ia2        NUMBER,
  kp         NUMBER(38,10),
  ka         NUMBER(38,10),
  s2         NUMBER(38,10),
  s8         NUMBER(38,10),
  pr2        NUMBER(38,10),
  pr8        NUMBER(38,10),
  pr         NUMBER(38,10),
  npp        INTEGER,
  vn         INTEGER,
  rnk        NUMBER,
  mod1       INTEGER,
  isp        INTEGER,
  id         NUMBER not null,
  pid        NUMBER,
  kf         VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  count_date DATE,
  state      NUMBER(1) default 0,
  dpr2       NUMBER(38,10),
  dpr8       NUMBER(38,10),
  dpr        NUMBER(38,10)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table OVR_INTX
  is '�������� ���������� ���� �� ���������� ���';
-- Add comments to the columns 
comment on column OVR_INTX.cdat
  is '������.����';
comment on column OVR_INTX.acc8
  is '���-���������';
comment on column OVR_INTX.sal8
  is '������ ������.';
comment on column OVR_INTX.ip8
  is '������ �� 8999 ���= �8 (�������� ������)';
comment on column OVR_INTX.ia8
  is '������ �� 8999 ��� = A8 (�������� ������)';
comment on column OVR_INTX.pas8
  is '���� ��� ���';
comment on column OVR_INTX.akt8
  is '���� ��� ���';
comment on column OVR_INTX.acc
  is '���-�������� 2600';
comment on column OVR_INTX.ost2
  is '������ ������ ��������';
comment on column OVR_INTX.ip2
  is '������ �� ��� 2600.i �2 (����������� ������)';
comment on column OVR_INTX.ia2
  is '������ �� ��� 2600.i �2 (����������� ������)';
comment on column OVR_INTX.kp
  is '����=������ ���/���� ���';
comment on column OVR_INTX.ka
  is '����=������ ���/���� ���';
comment on column OVR_INTX.s2
  is '������� ����� ��� ����� (����������� ������)';
comment on column OVR_INTX.s8
  is '������� ����� ��� �������.(�������� ������)';
comment on column OVR_INTX.pr2
  is '���� ���� �� ����� (����������� ������)';
comment on column OVR_INTX.pr8
  is '���� ���� �� �������.(�������� ������)';
comment on column OVR_INTX.pr
  is '��� ���� ���� �� ����';
comment on column OVR_INTX.npp
  is '0,1,2 - ������������� ��� ��������� �����';
comment on column OVR_INTX.vn
  is '��� ��� 0-����. 1 - �������� ��� 1 ���';
comment on column OVR_INTX.rnk
  is '��� ��������';
comment on column OVR_INTX.mod1
  is '=1-������� ��������� ����������';
comment on column OVR_INTX.id
  is '������������� ������';
comment on column OVR_INTX.pid
  is '������������� ������������ ������';
comment on column OVR_INTX.count_date
  is '���� �������';
comment on column OVR_INTX.state
  is '��������� ������������ ��������';
comment on column OVR_INTX.dpr2
  is '������� ���� ���� �� ����� (����������� ������)';
comment on column OVR_INTX.dpr8
  is '������� ���� ���� �� �������.(�������� ������)';
comment on column OVR_INTX.dpr
  is '������� ��� ���� ���� �� ����';

begin
-- Create/Rebegin
    execute immediate 'create index I_OVRINTX_KF_ACC on OVR_INTX (KF, ACC8, ACC, COUNT_DATE)
  tablespace BRSDYNI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_OVRINTX_STATE on OVR_INTX (KF, STATE)
  tablespace BRSDYNI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table OVR_INTX
  add constraint PK_OVRINTX_ID primary key (ID)
  using index 
  tablespace BRSDYNI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table OVR_INTX
  add constraint UK_OVRINTX_PID unique (PID)
  using index 
  tablespace BRSDYNI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on OVR_INTX to BARSREADER_ROLE;
grant select on OVR_INTX to BARS_ACCESS_DEFROLE;
grant select on OVR_INTX to START1;
grant select on OVR_INTX to UPLD;



exec bpa.alter_policies('OVR_INTX');

