
begin
  begin insert into accp_fee_types values(1, 'Фіксований % '); exception when dup_val_on_index then null; end;
  begin insert into accp_fee_types values(2, 'Ступінчатий % (згідно тарифу)'); exception when dup_val_on_index then null; end;
end;
/
commit;