begin
    execute immediate 'insert into MSP_ACC_TRANS_2560 (ACC_NUM, KF, EDRPU)
values (''256000023'', ''322669'', ''09322277'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;