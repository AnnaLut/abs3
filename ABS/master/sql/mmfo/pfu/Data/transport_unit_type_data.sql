begin
update transport_unit_type set  TRANSPORT_TYPE_CODE = 'CREATE_PAYM' , TRANSPORT_TYPE_NAME = '�������� ��������� �������'  where ID =  6;
end;
/

begin
    execute immediate '
insert into transport_unit_type (ID, TRANSPORT_TYPE_CODE, TRANSPORT_TYPE_NAME, DIRECTION)
values (13, ''CHECKPAYMBACKSTATE'', ''���������� ������� ������� �� ���������� �����'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into transport_unit_type (ID, TRANSPORT_TYPE_CODE, TRANSPORT_TYPE_NAME, DIRECTION)
values (14, ''GET_CLEAR_ACC'', ''��������� ������ ��� ��������'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into pfu.transport_unit_type (ID, TRANSPORT_TYPE_CODE, TRANSPORT_TYPE_NAME, DIRECTION)
values (18, ''MSP_GET_ACC_REST'', ''��������� ������� �� �����(���)'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into pfu.transport_unit_type (ID, TRANSPORT_TYPE_CODE, TRANSPORT_TYPE_NAME, DIRECTION)
values (19, ''MSP_CHECKPAYMSTATE'', ''���������� ������� �������(���)'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


commit;