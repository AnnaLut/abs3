begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IDI', 'Неаморт. дисконт/ премія Інстолмент', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IK0', 'Нарах.дох. інстолмент', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IK9', 'Простр.нарах.дох.(коміс.)інстолмент', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IKN', 'Нарах.дох.за кред. інстолмент', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IPN', 'Простр.нарах.дох.за кред.інстолмент', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IR9', 'Невикор.ліміт інстолмент', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('ISP', 'Простр.заборг. за кред. інстолмент', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('ISS', 'Кред. інстолмент', 1000);
exception when dup_val_on_index then
null;
end;
/
COMMIT;
/
