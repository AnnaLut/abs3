-- ��������� ����������� ���� P090 � 40 �� 50 ��������

exec bc.home();

begin
 execute immediate   'alter table OTCN_F71_TEMP modify (P090 varchar2(50)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/


