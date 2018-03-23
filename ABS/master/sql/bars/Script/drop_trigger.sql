begin 
   execute immediate 'drop trigger BARS.TA$RP_DPTFILEROW';
exception when others then       
  if sqlcode=-4080 then null; else raise; end if; 
end; 
/

