begin
    execute immediate 'insert into ow_iic_msgcode t (tt, mfoa, nlsa, msgcode)
values (''R01'',''300465'',''29095000322669'', ''PAYPENS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
