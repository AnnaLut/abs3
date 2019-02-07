--додати параметр в birja - ідентифыкатор підстави для купілі валюти, по якому буде проводитись контроль
begin
    execute immediate 'update  birja set val=''164'' where par=''B_CONT_L''';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 
delete from kod_70_2 where p63='9.9.9';

