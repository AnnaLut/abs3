BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SP ', 1, '�������.����', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SPN', 2, '�������.��������', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SS ', 3, '���������� ����', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SN ', 4, '���������� ��������', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SN8', 5, '����', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SK9', 6, '������������ ��������', 77);
exception
  when dup_val_on_index then null;
end;
/
BEGIN
Insert into BARS.CC_RANG
   (TIP, ORD, COMM, RANG)
 Values
   ('SK0', 7, '���������� ��������', 77);
exception
  when dup_val_on_index then null;
end;
/
COMMIT;