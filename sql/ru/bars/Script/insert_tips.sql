begin
    execute immediate 'Insert into BARS.TIPS
   (TIP, NAME, ORD)
 Values
   (''OFR'', ''ODB Рахунок контрагента'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;
