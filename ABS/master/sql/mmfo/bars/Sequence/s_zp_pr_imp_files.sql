begin execute immediate'
   create sequence bars.s_zp_pr_imp_files start with 1';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/