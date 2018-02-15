begin
   execute immediate 'drop procedure p_fb5';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/


