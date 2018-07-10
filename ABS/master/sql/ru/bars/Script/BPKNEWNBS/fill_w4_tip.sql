begin
    execute immediate 'insert into W4_TIPS (TIP, TERM_MIN, TERM_MAX)
values (''W4G'', 24, 60)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_TIPS (TIP, TERM_MIN, TERM_MAX)
values (''W4S'', 24, 60)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_TIPS (TIP, TERM_MIN, TERM_MAX)
values (''W4W'', 24, 60)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

