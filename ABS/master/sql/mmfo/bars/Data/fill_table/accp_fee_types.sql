
begin
  begin insert into accp_fee_types values(1, 'Գ�������� % '); exception when dup_val_on_index then null; end;
  begin insert into accp_fee_types values(2, '���������� % (����� ������)'); exception when dup_val_on_index then null; end;
end;
/
commit;