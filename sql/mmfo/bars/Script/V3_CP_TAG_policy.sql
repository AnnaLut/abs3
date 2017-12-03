begin
  delete from policy_table where table_name = 'V3_CP_TAG';
  bpa.remove_policies('V3_CP_TAG');
end;  
/
commit;