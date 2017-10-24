exec bpa.alter_policy_info('COMPEN_PARAMS', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_PARAMS', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_PARAMS
(
  par         VARCHAR2(32) not null,
  discription VARCHAR2(64),
  type        NUMBER(1)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_PARAMS
  is 'Параметри модулю ЦРКР';
-- Add comments to the columns 
comment on column COMPEN_PARAMS.par
  is 'Код параметру';
comment on column COMPEN_PARAMS.discription
  is 'Опис параметру';
comment on column COMPEN_PARAMS.type
  is 'Тип параметру (1 - ліміт, 2 - Параметр)';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_PARAMS
  add constraint PK_COMPENPARAMS primary key (PAR)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PARAMS
  add constraint FK_CRKRPAR_CRKRPARTYPES_TYPE foreign key (TYPE)
  references COMPEN_PARAM_TYPES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete on COMPEN_PARAMS to BARS_ACCESS_DEFROLE;
