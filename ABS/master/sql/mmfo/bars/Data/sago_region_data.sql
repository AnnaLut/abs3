begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (1, ''Вінницька'', ''302076'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (2, ''Волинська'', ''303398'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (3, ''Дніпропетровська'', ''305482'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (5, ''Житомирська'', ''311647'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (6, ''Закарпатська'', ''312356'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (7, ''Запорізька'', ''313957'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (8, ''Івано-Франківська'', ''336503'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (10, ''Кіровоградська'', ''323475'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (13, ''Львівська'', ''325796'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (14, ''Миколаївська'', ''326461'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (15, ''Одеська'', ''328845'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (16, ''Полтавська'', ''331467'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (17, ''Рівненська'', ''333368'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (18, ''Сумська'', ''337568'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (19, ''Тернопільська'', ''338545'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (20, ''Харківська'', ''351823'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (21, ''Херсонська'', ''352457'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (22, ''Хмельницька'', ''315784'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (23, ''Черкаська'', ''354507'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (24, ''Чернігівська'', ''353553'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (25, ''Чернівецька'', ''356334'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REGION (REG_ID, NAMЕ, KF)
values (26, ''Київ'', ''322669'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;