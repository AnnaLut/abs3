exec bpa.alter_policy_info('COMPEN_MOTIONS', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('COMPEN_MOTIONS', 'whole',  null,  'E', 'E', 'E');

-- Create table
begin
    execute immediate 'create table COMPEN_MOTIONS
(
  id_compen NUMBER(14) not null,
  idm       INTEGER not null,
  sumop     NUMBER,
  ost       NUMBER,
  zpr       NUMBER,
  datp      DATE,
  prea      VARCHAR2(6),
  oi        VARCHAR2(4),
  ol        VARCHAR2(4),
  dk        INTEGER,
  datl      DATE,
  typo      VARCHAR2(2),
  mark      VARCHAR2(1),
  ver       NUMBER(4),
  stat      VARCHAR2(6)
)
tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_MOTIONS
  is '����� ������i� �� ��������';
-- Add comments to the columns 
comment on column COMPEN_MOTIONS.id_compen
  is 'm_f_o_00000000 (ASVO_COMPEN.ID)';
comment on column COMPEN_MOTIONS.idm
  is 'PK ��';
comment on column COMPEN_MOTIONS.sumop
  is '���� ��������';
comment on column COMPEN_MOTIONS.ost
  is '������� �i��� ������i�';
comment on column COMPEN_MOTIONS.zpr
  is '������� �������i� �i��� ������i�';
comment on column COMPEN_MOTIONS.datp
  is '���� ����������� �������i� ������i�';
comment on column COMPEN_MOTIONS.prea
  is '���� ������� �� ������i�';
comment on column COMPEN_MOTIONS.oi
  is '����� ������i� � ����� ������i��� ����';
comment on column COMPEN_MOTIONS.ol
  is '����� ���''����� ������i�';
comment on column COMPEN_MOTIONS.dk
  is 'DK';
comment on column COMPEN_MOTIONS.datl
  is '���� ������i�';
comment on column COMPEN_MOTIONS.typo
  is '��� ������i�';
comment on column COMPEN_MOTIONS.mark
  is '������ ���i�� � ����� ���������';
comment on column COMPEN_MOTIONS.ver
  is '����i� �������';
comment on column COMPEN_MOTIONS.stat
  is '���� ������i�';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_MOTIONS
  add constraint PK_COMPEN_MOTIONS primary key (ID_COMPEN, IDM)
  using index 
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_MOTIONS
  add constraint FK_COMPEN_MOTIONS_PORTFOLIO foreign key (ID_COMPEN)
  references COMPEN_PORTFOLIO (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_MOTIONS_ID on COMPEN_MOTIONS (ID_COMPEN)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Grant/Revoke object privileges 
grant select, insert, update, delete on COMPEN_MOTIONS to START1;
grant select, insert, update, delete on COMPEN_MOTIONS to WR_ALL_RIGHTS;
