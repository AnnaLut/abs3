begin
insert into bars.mway_pay_tt
  (tt, service_code, service_name, is_fee)
values
  ('W2P',
   'TRANSFER_CARD_ACC_SSD',
   'Операція карта - поточний рахунок в АБС через ІПТ',
   0);
commit;
exception
  when dup_val_on_index then
    null;
end;
/
