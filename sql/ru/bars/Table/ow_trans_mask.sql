begin
  bpa.alter_policy_info(p_table_name    => 'ow_trans_mask',
                        p_policy_group  => 'WHOLE',
                        p_select_policy => null,
                        p_insert_policy => null,
                        p_update_policy => null,
                        p_delete_policy => null);
end;
/ 
-- Create table
begin
    execute immediate 'create table OW_TRANS_MASK
(
  mask VARCHAR2(19),
  comm VARCHAR2(254)
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 
