
begin
    execute immediate 'grant execute on bars.pkg_adr_synch to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'grant execute on PKG_ADR_COMPARE to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 

