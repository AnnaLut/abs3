begin
    execute immediate 'grant execute on bars.M_ACCP to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -1917 then null; 
	else raise; 
    end if; 
end;
/ 
