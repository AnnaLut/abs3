begin
    execute immediate 'grant execute  on MSFZ9 to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
