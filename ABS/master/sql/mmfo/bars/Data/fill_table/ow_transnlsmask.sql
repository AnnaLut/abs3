begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP,NMS, TAB_NAME)
 Values
   ('NLS_2206i', 'ACC_2206I', 'OB_2206I', '2206', 'IDI', 
    'Неамортизований дисконт/ премія. #NMS', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_2203i', 'ACC_2203I', 'OB_2203I', '2203', 'ISS', 
    'Кред. інстолмент. #NMS', 'W4_ACC_INST');
    exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_2203OVDi', 'ACC_2203OVDI', 'OB_2203OVDI', '2203', 'ISP', 
    'Простр.заборг. за кред. інстолмент. #NMK', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_2208OVDi', 'ACC_2208OVDI', 'OB_2208OVDI', '2208', 'IPN', 
    'Простр.нарах.дох. за кред. інстолмент. #NMK', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_3570OVDi', 'ACC_3570OVDI', 'OB_3570OVDI', '3570', 'IK9', 
    'Простр.нарах.дох.(коміс.) інстолмент. #NMK', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_3570i', 'ACC_3570I', 'OB_3570I', '3570', 'IK0', 
    'Нарах.дох. інстолмент. #NMK', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_9129i', 'ACC_9129I', 'OB_9129I', '9129', 'IR9', 
    'Невикор.ліміт інстолмент. #NLS', 'W4_ACC');
exception when dup_val_on_index then
null;
end;
/
begin
Insert into OW_TRANSNLSMASK
   (MASK, A_W4_ACC, A_W4_NBS_OB22, NBS, TIP, NMS, TAB_NAME)
 Values
   ('NLS_2208i', 'ACC_2208I', 'OB_2208I', '2208', 'IKN', 
    'Нарах.дох.за кред. інстолмент. #NMS', 'W4_ACC_INST');
exception when dup_val_on_index then
null;
end;
/
COMMIT;
/