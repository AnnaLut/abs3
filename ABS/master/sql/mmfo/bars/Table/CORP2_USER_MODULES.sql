begin 
  bpa.alter_policy_info('CORP2_USER_MODULES', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_USER_MODULES', 'FILIAL',  null,  null, null, null);
end;

/
-- Create table
begin
    execute immediate 'create table CORP2_USER_MODULES
(
  user_id   NUMBER(38),
  module_id VARCHAR2(3),
  constraint PK_CRPUSERMODULES primary key (USER_ID, MODULE_ID)
)
organization index';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table CORP2_USER_MODULES
  is 'Звязок корисувач-модулі';
-- Add comments to the columns 
comment on column CORP2_USER_MODULES.user_id
  is 'Ід корисувача';
comment on column CORP2_USER_MODULES.module_id
  is 'Ід модуля';

grant select, insert, update, delete, alter on CORP2_USER_MODULES to BARS_ACCESS_DEFROLE;
