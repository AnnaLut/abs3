begin
  begin insert into F045(F045, txt, d_open) values('1', '������������ ������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into F045(F045, txt, d_open) values('2', '�������������� ������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into F045(F045, txt, d_open) values('3', '������ � ������� �i� ����, ���, �����', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/


begin
  begin insert into F045(F045, txt, d_open) values('#', '����� �������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/

commit;