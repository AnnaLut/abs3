begin
  begin
    bpa.alter_policy_info(p_table_name    => 'KOD_DZR',
                          p_policy_group  => 'FILIAL',
                          p_select_policy => 'M',
                          p_insert_policy => 'M',
                          p_update_policy => 'M',
                          p_delete_policy => 'M');
  exception
    when others then
      bars_audit.info('Exception in script COBUMMFO-9474 stage1: '||sqlerrm);
  end;
  
  begin
    bpa.remove_policies(p_table_name => 'KOD_DZR');
  exception
    when others then
      bars_audit.info('Exception in script COBUMMFO-9474 stage2: '||sqlerrm);
  end;
  
  begin
    bpa.add_policies(p_table_name => 'KOD_DZR');
  exception
    when others then
      bars_audit.info('Exception in script COBUMMFO-9474 stage3: '||sqlerrm);
  end;
  
  begin
    bpa.enable_policies(p_table_name => 'KOD_DZR');
  exception
    when others then
      bars_audit.info('Exception in script COBUMMFO-9474 stage4: '||sqlerrm);
  end;
exception
  when others then
    null;
end;
/
