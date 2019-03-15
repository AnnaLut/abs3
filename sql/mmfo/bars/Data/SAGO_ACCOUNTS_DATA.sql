begin
    execute immediate 'insert into BARS.SAGO_ACCOUNTS (NBS, NLS, KF)
values (''1811'', null, ''300465'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_ACCOUNTS (NBS, NLS, KF)
values (''3739'', null, ''300465'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_ACCOUNTS (NBS, NLS, KF)
values (''1001'', null, ''300465'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_ACCOUNTS (NBS, NLS, KF)
values (''9817'', null, ''300465'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_ACCOUNTS (NBS, NLS, KF)
values (''9910'', null, ''300465'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_ACCOUNTS (NBS, NLS, KF)
values (''1811'', null, ''322669'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_ACCOUNTS (NBS, NLS, KF)
values (''3739'', null, ''322669'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_ACCOUNTS (NBS, NLS, KF)
values (''1001'', null, ''322669'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_ACCOUNTS (NBS, NLS, KF)
values (''9817'', null, ''322669'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_ACCOUNTS (NBS, NLS, KF)
values (''9910'', null, ''322669'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
