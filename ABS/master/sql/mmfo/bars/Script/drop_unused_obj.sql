begin
   execute immediate 'drop procedure p_fb5';
exception when others then       
  if sqlcode=-4043 then null; else raise; end if; 
end; 
/


