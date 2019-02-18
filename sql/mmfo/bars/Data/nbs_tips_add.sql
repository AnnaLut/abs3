begin
    execute immediate 'insert into NBS_TIPS (NBS, TIP, OPT, OB22)
values (''2560'', ''SBD'', null, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into NBS_TIPS (NBS, TIP, OPT, OB22)
values (''2909'', ''SBD'', null, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;