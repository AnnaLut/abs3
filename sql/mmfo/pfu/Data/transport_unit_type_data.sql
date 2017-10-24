delete from transport_unit_type where ID = 15;

begin
    execute immediate 'insert into transport_unit_type (ID, TRANSPORT_TYPE_CODE, TRANSPORT_TYPE_NAME, DIRECTION)
                       values (15, ''SET_CARD_BLOCK'', ''���������� ����� �� ������� ��'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'insert into transport_unit_type (ID, TRANSPORT_TYPE_CODE, TRANSPORT_TYPE_NAME, DIRECTION)
		       values (17, ''SET_CARD_UNBLOCK'', ''������������� ����� �� ������� ��'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/


commit;