begin
insert into bars.p12_2c (code, txt)
 values ('7.2', 'Фінансова операція з повернення іноземному інвестору коштів, отриманих від продажу корпоративних прав/цінних паперів');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
commit;