begin
   execute immediate 'drop procedure cck_del6';
exception when others then       
  if sqlcode=-4043 then null; else raise; end if; 
end; 
/



begin
   execute immediate 'drop table "S6_Contract_V"';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/
