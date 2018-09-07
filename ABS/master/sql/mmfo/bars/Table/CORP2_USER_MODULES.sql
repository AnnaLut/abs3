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

grant select, insert, update, delete, alter on CORP2_USER_MODULES to BARS_ACCESS_DEFROLE;
