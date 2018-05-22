begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (1, 'Паспорт громадянина України', 1, 'Паспорт громадянина України');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (2, 'Паспорт громадянина України для виїзду за кордон з відміткою про виїзд на ПМП за кордон', 99, 'Iнший документ');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (3, 'Тимчасове посвідчення особи громадянина України', 15, 'Тимчасове посвідчення особи');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (4, 'Свідоцтво про народження', 3, 'Свідоцтво про  народження');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (5, 'Паспортний документ іноземного громадянина', 13, 'Паспорт нерезидента');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (6, 'Посвідка на постійне проживання', 17, 'Посвідчення');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (7, 'Паспортний документ особи без громадянства', 99, 'Iнший документ');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (8, 'Посвідчення біженця', 16, 'Посвідчення біженця');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (9, 'Паспорт громадянина України для виїзду за кордон', 11, 'Паспорт гр.України для виїзду за кордон без відмітки, що підтв. постійне прожив. за кордоном');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (10, 'Паспорт громадянина України у вигляді ID-картки', 7, 'Паспорт ID-картка');
exception when dup_val_on_index then 
    null;
end;
/
COMMIT;
