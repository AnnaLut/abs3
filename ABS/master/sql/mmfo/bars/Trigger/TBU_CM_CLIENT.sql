create or replace trigger TBU_CM_CLIENT
  before update
  on CM_CLIENT_QUE 
  for each row
begin
  if :old.oper_status in (20, 30) then
    raise_application_error(-20000,'���������� ����������� ������ �� ������������ ��� ���� ���������� ��������� 2');
  end if;
end TBU;
/
