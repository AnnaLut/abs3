begin
    execute immediate 'insert into SAGO_OPERATION_TTS (ID_SAGO_OPER, TTS)
values (''BN01'', ''092'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION_TTS (ID_SAGO_OPER, TTS)
values (''BN01'', ''VZA'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION_TTS (ID_SAGO_OPER, TTS)
values (''BN02'', ''090'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION_TTS (ID_SAGO_OPER, TTS)
values (''BN02'', ''VZB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION_TTS (ID_SAGO_OPER, TTS)
values (''BN03'', ''VZA'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION_TTS (ID_SAGO_OPER, TTS)
values (''BN04'', ''VZB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION_TTS (ID_SAGO_OPER, TTS)
values (''BNZ2'', ''225'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
