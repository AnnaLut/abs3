prompt Loading COMPEN_PORTFOLIO_STATUS...
begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (0, ''̳��������'', ''̳�������� �����. ������ � ��� ����������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (1, ''³�������'', ''̳��������(����������) ��� ����� �������� � ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (-1, ''̳�������� ��������'', ''����� �������� ������ ��� �������. ������ ������ � ������� compen_portfolio_status_old'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (3, ''��������'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (91, ''���������� �'', ''���������� � ��''''���� � ������������� ��������� �� ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (99, ''����������'', ''�������� ����� ����������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (92, ''���������� �'', ''���������� � ��''''���� � ����������� ��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


UPDATE COMPEN_PORTFOLIO_STATUS T SET STATUS_NAME = '���������� ���������'
  WHERE STATUS_ID = 91;
UPDATE COMPEN_PORTFOLIO_STATUS T SET STATUS_NAME = '���������� ��������'
  WHERE STATUS_ID = 92;
commit;
