delete from birja where par like 'B_CONT_%';

--додати параметр в birja - ідентифыкатор підстави для купілі валюти, по якому буде проводитись контроль
begin
    execute immediate 'insert into birja (par,comm,val) values 
			(''B_CONT_L'',''Ідент. підстави купівлі валюти для контролю доб. ліміту'',''082'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into birja (PAR, COMM, VAL, KF)
                       values (''B_CONT_M'', ''Ідент. підстави купівлі банківських металів для контролю доб. ліміту '', ''140'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/


-- додати атрибут  - сума добового ліміту купівлі безготівкової валюти 
begin
 branch_attribute_utl.create_attribute('CURR_LIM_DAY1','Добовий ліміт купівлі безготівкової валюти(коп)','N');
 branch_attribute_utl.set_attribute_value('/','CURR_LIM_DAY1',14999999);
end;
/


commit;

