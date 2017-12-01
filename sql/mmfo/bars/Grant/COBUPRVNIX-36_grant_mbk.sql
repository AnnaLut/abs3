begin
    execute immediate 'grant execute on MBK to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'grant execute on MBK to FOREX';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/