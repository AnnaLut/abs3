delete from birja where par like 'B_CONT_%';

--������ �������� � birja - ������������� ������� ��� ���� ������, �� ����� ���� ����������� ��������
begin
    execute immediate 'insert into birja (par,comm,val) values 
			(''B_CONT_L'',''�����. ������� ����� ������ ��� �������� ���. ����'',''082'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into birja (PAR, COMM, VAL, KF)
                       values (''B_CONT_M'', ''�����. ������� ����� ���������� ������ ��� �������� ���. ���� '', ''140'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/


-- ������ �������  - ���� �������� ���� ����� ����������� ������ 
begin
 branch_attribute_utl.create_attribute('CURR_LIM_DAY1','������� ��� ����� ����������� ������(���)','N');
 branch_attribute_utl.set_attribute_value('/','CURR_LIM_DAY1',14999999);
end;
/


commit;

