begin
    execute immediate 'insert into CM_OPERSTATUS (ID, NAME)
values (20, ''�����. ������� ��� � ���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CM_OPERSTATUS (ID, NAME)
values (30, ''�� �����. ������� ��� � ���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;

