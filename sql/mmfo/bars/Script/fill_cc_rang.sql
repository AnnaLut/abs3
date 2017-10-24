BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SP ', 1, 'Просроч.тело', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SPN', 2, 'Просроч.проценты', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SS ', 3, 'Нормальное тело', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SN ', 4, 'Нормальные проценты', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SN8', 5, 'Пеня', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SK9', 6, 'Просроченная комиссия', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SK0', 7, 'Нормальная комиссия', 77);
exception
  when dup_val_on_index then null;
end;
/
COMMIT;