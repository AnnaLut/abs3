begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IDI', '�������. �������/ ����� ����������', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IK0', '�����.���. ����������', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IK9', '������.�����.���.(����.)����������', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IKN', '�����.���.�� ����. ����������', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IPN', '������.�����.���.�� ����.����������', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('IR9', '�������.��� ����������', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('ISP', '������.������. �� ����. ����������', 1000);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into TIPS
   (TIP, NAME, ORD)
 Values
   ('ISS', '����. ����������', 1000);
exception when dup_val_on_index then
null;
end;
/
COMMIT;
/
