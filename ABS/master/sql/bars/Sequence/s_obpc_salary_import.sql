begin execute immediate'
   create sequence bars.s_obpc_salary_import start with 1';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/