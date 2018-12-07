begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP,NMS, TAB_NAME)
 Values
   ('NLS_2206i', 'ACC_2206I', 'OB_2206I', '2206', 'IDI', 
    '��������������� �������/ �����. #NMS', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_2203i', 'ACC_2203I', 'OB_2203I', '2203', 'ISS', 
    '����. ����������. #NMS', 'W4_ACC_INST');
    exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_2203OVDi', 'ACC_2203OVDI', 'OB_2203OVDI', '2203', 'ISP', 
    '������.������. �� ����. ����������. #NMK', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_2208OVDi', 'ACC_2208OVDI', 'OB_2208OVDI', '2208', 'IPN', 
    '������.�����.���. �� ����. ����������. #NMK', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_3570OVDi', 'ACC_3570OVDI', 'OB_3570OVDI', '3570', 'IK9', 
    '������.�����.���.(����.) ����������. #NMK', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_3570i', 'ACC_3570I', 'OB_3570I', '3570', 'IK0', 
    '�����.���. ����������. #NMK', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_9129i', 'ACC_9129I', 'OB_9129I', '9129', 'IR9', 
    '�������.��� ����������. #NLS', 'W4_ACC');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_2208i', 'ACC_2208I', 'OB_2208I', '2208', 'IKN', 
    '�����.���.�� ����. ����������. #NMS', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
COMMIT;
/