begin
    execute immediate 'insert into MSP_ACC_TRANS_2909 (ACC_NUM, KF, EDRPU)
values (''29096106322669'', ''322669'', ''09322277'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into MSP_ACC_TRANS_2909 (ACC_NUM, KF, EDRPU)
values (''29096106300465'', ''300465'', ''00032129'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


commit;