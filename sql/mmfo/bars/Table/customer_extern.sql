prompt ... 


-- Create table
begin
    execute immediate 'create table CUSTOMER_EXTERN
(
  id          NUMBER(22),
  name        VARCHAR2(70),
  doc_type    NUMBER(22),
  doc_serial  VARCHAR2(30),
  doc_number  VARCHAR2(22),
  doc_date    DATE,
  doc_issuer  VARCHAR2(70),
  birthday    DATE,
  birthplace  VARCHAR2(70),
  sex         CHAR(1) default ''0'',
  adr         VARCHAR2(100),
  tel         VARCHAR2(100),
  email       VARCHAR2(100),
  custtype    NUMBER(1),
  okpo        VARCHAR2(14),
  country     NUMBER(3),
  region      VARCHAR2(2),
  fs          CHAR(2),
  ved         CHAR(5),
  sed         CHAR(4),
  ise         CHAR(5),
  notes       VARCHAR2(80),
  rnk         NUMBER,
  detrnk      DATE,
  kf          VARCHAR2(6) default sys_context(''bars_context'', ''user_mfo'') not null,
  date_photo  DATE,
  eddr_id     VARCHAR2(20),
  actual_date DATE
)
tablespace BRSMDLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


begin
  execute immediate q'[alter table BARS.CUSTOMER_EXTERN ADD date_photo DATE]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "date_photo" already exists in table.');
    else raise;
    end if;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_EXTERN ADD eddr_id varchar2(20)]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "eddr_id" already exists in table.');
    else raise;
    end if;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_EXTERN ADD actual_date DATE]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "actual_date" already exists in table.');
    else raise;
    end if;
end;
/



-- Add comments to the table 
comment on table CUSTOMER_EXTERN
  is '�� ������� �����';
-- Add comments to the columns 
comment on column CUSTOMER_EXTERN.id
  is 'Id';
comment on column CUSTOMER_EXTERN.name
  is '������������/���';
comment on column CUSTOMER_EXTERN.doc_type
  is '��� ���������';
comment on column CUSTOMER_EXTERN.doc_serial
  is '����� ���������';
comment on column CUSTOMER_EXTERN.doc_number
  is '����� ���������';
comment on column CUSTOMER_EXTERN.doc_date
  is '���� ������ ���������';
comment on column CUSTOMER_EXTERN.doc_issuer
  is '����� ������ ���������';
comment on column CUSTOMER_EXTERN.birthday
  is '���� ��������';
comment on column CUSTOMER_EXTERN.birthplace
  is '����� ��������';
comment on column CUSTOMER_EXTERN.adr
  is '�����';
comment on column CUSTOMER_EXTERN.tel
  is '�������';
comment on column CUSTOMER_EXTERN.email
  is 'E_mail';
comment on column CUSTOMER_EXTERN.custtype
  is '������� (1-��, 2-��)';
comment on column CUSTOMER_EXTERN.okpo
  is '����';
comment on column CUSTOMER_EXTERN.country
  is '��� ������';
comment on column CUSTOMER_EXTERN.region
  is '��� �������';
comment on column CUSTOMER_EXTERN.fs
  is '����� ������������� (K081)';
comment on column CUSTOMER_EXTERN.ved
  is '��� ��. ����-�� (K110)';
comment on column CUSTOMER_EXTERN.sed
  is '���.-�������� ����� (K051)';
comment on column CUSTOMER_EXTERN.ise
  is '����. ������ ��������� (K070)';
comment on column CUSTOMER_EXTERN.notes
  is '�����������';
comment on column CUSTOMER_EXTERN.rnk
  is '��� �볺���, �� ��������� �����';
comment on column CUSTOMER_EXTERN.detrnk
  is '���� ���������� ���';
comment on column CUSTOMER_EXTERN.date_photo
  is '���� ���� ���� ������ ������� ���������� � �������';
comment on column CUSTOMER_EXTERN.eddr_id
  is '��������� ����� ������ � ����';
comment on column CUSTOMER_EXTERN.actual_date
  is 'ĳ����� ��';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CUSTOMER_EXTERN
  add constraint PK_CUSTOMEREXTERN primary key (ID)
  using index 
  tablespace BRSMDLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_EXTERN
  add constraint FK_CUSTOMEREXTERN_COUNTRY foreign key (COUNTRY)
  references COUNTRY (COUNTRY)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_EXTERN
  add constraint FK_CUSTOMEREXTERN_FS foreign key (FS)
  references FS (FS)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_EXTERN
  add constraint FK_CUSTOMEREXTERN_ISE foreign key (ISE)
  references ISE (ISE)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_EXTERN
  add constraint FK_CUSTOMEREXTERN_PASSP foreign key (DOC_TYPE)
  references PASSP (PASSP)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_EXTERN
  add constraint FK_CUSTOMEREXTERN_SED foreign key (SED)
  references SED (SED)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_EXTERN
  add constraint FK_CUSTOMEREXTERN_SEX foreign key (SEX)
  references SEX (ID)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_EXTERN
  add constraint FK_CUSTOMEREXTERN_VED foreign key (VED)
  references VED (VED)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table CUSTOMER_EXTERN
  add constraint CC_CUSTOMEREXTERN_ID_NN
  check ("ID" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_EXTERN
  add constraint CC_CUSTOMEREXTERN_SEX_NN
  check ("SEX" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on CUSTOMER_EXTERN to BARSREADER_ROLE;
grant select on CUSTOMER_EXTERN to BARSUPL;
grant select, insert, update, delete on CUSTOMER_EXTERN to BARS_ACCESS_DEFROLE;
grant select on CUSTOMER_EXTERN to BARS_DM;
grant select, insert, update, delete on CUSTOMER_EXTERN to CUST001;
grant select on CUSTOMER_EXTERN to UPLD;
grant select, insert, update, delete on CUSTOMER_EXTERN to WR_ALL_RIGHTS;
