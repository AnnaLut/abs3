begin
    execute immediate 'drop trigger TAU_ACCOUNTS_OVER_LIM';
 exception when others then 
    if sqlcode = -4080 then null; else raise; 
    end if; 
end;
/ 