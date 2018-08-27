begin
    execute immediate 'drop table OVR_INTX';
 exception when others then 
    if sqlcode = -4043 then null; else raise; 
    end if; 
end;
/ 

