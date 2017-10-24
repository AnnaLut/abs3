prompt Loading COMPEN_PARAMS...
begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT'', ''Ліміт виплат по компенсаційному рахунку'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_BURIAL'', ''Ліміт виплат на поховання'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO COMPEN_PARAMS T (PAR, DISCRIPTION, TYPE)
  VALUES (''COMPEN_OFFSET_DAYS'', ''Кількість днів від актуалізації до планової виплати'', 2)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_02'', ''Ліміт виплат по вкладам з ОБ22=02'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_03'', ''Ліміт виплат по вкладам з ОБ22=03'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_04'', ''Ліміт виплат по вкладам з ОБ22=04'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_05'', ''Ліміт виплат по вкладам з ОБ22=05'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_06'', ''Ліміт виплат по вкладам з ОБ22=06'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_07'', ''Ліміт виплат по вкладам з ОБ22=07'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_08'', ''Ліміт виплат по вкладам з ОБ22=08'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_09'', ''Ліміт виплат по вкладам з ОБ22=09'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_10'', ''Ліміт виплат по вкладам з ОБ22=10'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_11'', ''Ліміт виплат по вкладам з ОБ22=11'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_12'', ''Ліміт виплат по вкладам з ОБ22=12'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_13'', ''Ліміт виплат по вкладам з ОБ22=13'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_14'', ''Ліміт виплат по вкладам з ОБ22=14'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_15'', ''Ліміт виплат по вкладам з ОБ22=15'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_16'', ''Ліміт виплат по вкладам з ОБ22=16'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_17'', ''Ліміт виплат по вкладам з ОБ22=17'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_18'', ''Ліміт виплат по вкладам з ОБ22=18'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_19'', ''Ліміт виплат по вкладам з ОБ22=19'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_20'', ''Ліміт виплат по вкладам з ОБ22=20'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS (par, discription, type)
values (''COMPEN_LIMIT_21'', ''Ліміт виплат по вкладам з ОБ22=21'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


commit;
