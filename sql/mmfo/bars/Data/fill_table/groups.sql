-- ����� ������������
begin
  insert into GROUPS ( ID, NAME )
  values ( 1025, 'ϳ������ ���-�����' );
exception
  when dup_val_on_index then
    null;
end;
/

commit;

begin
  insert into GROUPS ( ID, NAME )
  values ( 1026, '�����-����' );
exception
  when dup_val_on_index then
    null;
end;
/

commit;
