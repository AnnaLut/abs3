begin
insert into bars.p12_2c (code, txt)
 values ('7.2', 'Գ������� �������� � ���������� ���������� ��������� �����, ��������� �� ������� ������������� ����/������ ������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
commit;