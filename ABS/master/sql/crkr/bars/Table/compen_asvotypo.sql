exec bpa.alter_policy_info('COMPEN_ASVOTYPO', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_ASVOTYPO', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_ASVOTYPO
(
  typo   CHAR(2) not null,
  code   CHAR(2),
  comm10 VARCHAR2(10),
  txt    VARCHAR2(96),
  dk     INTEGER
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_ASVOTYPO
  is '���� �������� ����';
-- Add comments to the columns 
comment on column COMPEN_ASVOTYPO.typo
  is '���';
comment on column COMPEN_ASVOTYPO.code
  is '���';
comment on column COMPEN_ASVOTYPO.comm10
  is '����� 10';
comment on column COMPEN_ASVOTYPO.txt
  is '����� ��������';
comment on column COMPEN_ASVOTYPO.dk
  is '�����/������-0/1';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_ASVOTYPO
  add constraint PK_COMPEN_ASVOTYPO primary key (TYPO)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete on COMPEN_ASVOTYPO to START1;
grant select, insert, update, delete on COMPEN_ASVOTYPO to WR_ALL_RIGHTS;
