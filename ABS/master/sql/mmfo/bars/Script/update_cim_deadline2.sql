/*
����������� ĳ�� �����������
���� ���, ����, ������
������� �����!
�����, ����� ��������  � 07.02.2019�. (�������) ������ ����������� ����� � ����+365 ��� �� ����+364 �� - ������� : ��������� ��� �� 06.02.2019�. �35
*/

begin
Insert into cim_contract_deadlines
   (DEADLINE, COMMENTS)
 Values
   ('364', '������� �� 364 ���');
exception when dup_val_on_index then
null;
end;
/

begin
update cim_contract_deadlines set DELETE_DATE = to_date('07022019','DDMMYYYY')  where DEADLINE = 365;
end;
/

declare
begin
 update cim_contracts_trade 
 set deadline = 364
 where deadline = 365;
 dbms_output.put_line('�������� ����������� ����� � cim_contracts_trade  '|| SQL%ROWCOUNT); 
end;
/


declare
begin
    update cim_payments_bound set deadline = 364 where deadline = 365;
  dbms_output.put_line('�������� ����������� ����� ��� ������� count '||SQL%ROWCOUNT );

    update cim_fantoms_bound set deadline = 364 where deadline = 365;
  dbms_output.put_line('�������� ����������� ����� ��� ������� count '||SQL%ROWCOUNT );

    update cim_vmd_bound set deadline = 364 where deadline = 365;
  dbms_output.put_line('�������� ����������� ����� ��� �� count '||SQL%ROWCOUNT );

    update cim_act_bound set deadline = 364 where deadline = 365;
  dbms_output.put_line('�������� ����������� ����� ��� ���� count '||SQL%ROWCOUNT );
end;  
/

commit;
/