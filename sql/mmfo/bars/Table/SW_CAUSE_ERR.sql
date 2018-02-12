prompt ... 
begin 
  BPA.ALTER_POLICY_INFO( 'SW_CAUSE_ERR', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'SW_CAUSE_ERR', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table SW_CAUSE_ERR
(
  id          NUMBER not null,
  name        VARCHAR2(200) not null,
  description VARCHAR2(50),
  tt          CHAR(3)
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


begin
  execute immediate q'[ALTER TABLE BARS.SW_CAUSE_ERR ADD tt CHAR(3)]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "tt" already exists in table.');
    else raise;
    end if;
end;
/

-- Add comments to the table 
comment on table SW_CAUSE_ERR
  is 'Причины расхождений';
-- Add comments to the columns 
comment on column SW_CAUSE_ERR.description
  is 'описание';
comment on column SW_CAUSE_ERR.tt
  is 'операция для решения расхождения';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SW_CAUSE_ERR
  add constraint PK_SWCAUSEERR primary key (ID)
  using index 
  tablespace BRSDYND
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



