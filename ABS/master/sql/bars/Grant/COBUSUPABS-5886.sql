begin
    execute immediate 'grant execute on PKG_SW_COMPARE to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 