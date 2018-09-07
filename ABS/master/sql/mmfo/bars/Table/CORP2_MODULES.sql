begin 
  bpa.alter_policy_info('CORP2_MODULES', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_MODULES', 'FILIAL',  null,  null, null, null);
end;

/

begin
    execute immediate 'create table CORP2_MODULES
(
  module_id  VARCHAR2(3 CHAR),
  name       VARCHAR2(100 CHAR),
  user_type  NUMBER(1),
  sort_order NUMBER(3),
  icon_url   VARCHAR2(128 CHAR),
  constraint PK_COREMODULES primary key (MODULE_ID)
)
organization index
rowdependencies';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table CORP2_MODULES
  is 'Модули';
-- Add comments to the columns 
comment on column CORP2_MODULES.module_id
  is 'Код модуля';
comment on column CORP2_MODULES.name
  is 'Имя модуля';
comment on column CORP2_MODULES.user_type
  is 'Глобальный тип пользователя';
comment on column CORP2_MODULES.sort_order
  is 'Порядок сортировки модуля';
comment on column CORP2_MODULES.icon_url
  is 'URL иконки модуля';

-- Create/Recreate check constraints 
begin
    execute immediate 'alter table CORP2_MODULES
  add constraint CC_COREMODULES_MODULEID_NN
  check ("MODULE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_MODULES
  add constraint CC_COREMODULES_NAME_NN
  check ("NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_MODULES
  add constraint CC_COREMODULES_USERTYPE_NN
  check ("USER_TYPE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

grant select on CORP2_MODULES to bars_access_defrole;

