BEGIN
    Insert into BARS.CC_RANG_NAME
       (RANG, NAME, CUSTTYPE, BLK)
     Values
       (77, '�� �������� ���� � ������� 2620 ��� 2625 (10.06.17)', 3, 14);
exception
  when dup_val_on_index then null;
end;
/
COMMIT;