--додати параметр в birja - ідентифыкатор підстави для купілі валюти, по якому буде проводитись контроль
begin
    execute immediate 'insert into birja (par,comm,val) values (''B_CONT_L'',''Ідент. підстави купівлі для контролю добового ліміту'',''9.9.9'')';
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
--додати код підстави до довідника - 
begin
    execute immediate 'insert into kod_70_2 (P63, TXT, TXT108, DATA_O, DATA_C)
values (''9.9.9'', ''Незначний обсяг без наявності підстав'', ''Незначний обсяг без наявності підстав'', to_date(''07-02-2019'', ''dd-mm-yyyy''), null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

