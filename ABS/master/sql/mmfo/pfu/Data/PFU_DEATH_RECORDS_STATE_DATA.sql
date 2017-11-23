begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''NEW'', ''����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''CHECKED'', ''���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_OKPO'', ''������� � ���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''PROCESSED'', ''�����������(� ������� ������� ����)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''DEBET_PAYM_CREATED'', ''�������� ����� �� ������� ����� � ������� �볺��� � �� �� ���������� ������� � ���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''IN_PAY'', ''������� �� ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_ACC'', ''������� �� ��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_ACC_CLOSE'', ''������� ��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_ACC_PENS'', ''��������� �� �������� (�� �������)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_ACC_OKPO'', ''������� �� ������� �� ����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_NAME'', ''������� �� ������� �� ϲ�'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''READY_FOR_PAY'', ''������� �� ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


commit;