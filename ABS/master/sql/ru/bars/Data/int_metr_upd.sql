--���� �������� �� �.3.1. ����� ������ COBUSUPABS-6353
SET DEFINE OFF;
begin
  update int_metr t
     set t.name = '% ���.�� ����.���.�������������'
   where t.metr = 0;
end;
/
commit;