begin 
  bpa.alter_policy_info('CORP2_MODULE_FUNCTIONS', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_MODULE_FUNCTIONS', 'FILIAL',  null,  null, null, null);
end;

/
-- Create table
begin
    execute immediate 'create table CORP2_MODULE_FUNCTIONS
(
  module_id  VARCHAR2(3 CHAR),
  func_id    NUMBER(10),
  sort_order NUMBER(10),
  constraint PK_MODULEFUNCS primary key (MODULE_ID, FUNC_ID)
)
organization index
rowdependencies';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table CORP2_MODULE_FUNCTIONS
  is 'функции модулей системы';
-- Add comments to the columns 
comment on column CORP2_MODULE_FUNCTIONS.module_id
  is 'Id модуля';
comment on column CORP2_MODULE_FUNCTIONS.func_id
  is 'Id функции';
comment on column CORP2_MODULE_FUNCTIONS.sort_order
  is 'Порядок сортировки';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CORP2_MODULE_FUNCTIONS
  add constraint FK_MODULEFUNCS_MODULES foreign key (MODULE_ID)
  references CORP2_MODULES (MODULE_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table CORP2_MODULE_FUNCTIONS
  add constraint CC_MODULEFUNCS_FUNCID_NN
  check ("FUNC_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_MODULE_FUNCTIONS
  add constraint CC_MODULEFUNCS_MODULEID_NN
  check ("MODULE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

grant select on CORP2_MODULE_FUNCTIONS to bars_access_defrole;
