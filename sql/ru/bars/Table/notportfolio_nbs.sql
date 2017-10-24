begin
  bpa.alter_policy_info(p_table_name    => 'NOTPORTFOLIO_NBS',
                        p_policy_group  => 'WHOLE',
                        p_select_policy => null,
                        p_insert_policy => null,
                        p_update_policy => null,
                        p_delete_policy => null);
end;
/
begin
    execute immediate 'create table NOTPORTFOLIO_NBS
(
  nbs CHAR(4)
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 
