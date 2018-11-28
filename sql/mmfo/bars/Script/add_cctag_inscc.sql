begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('INSCC', 'Страхування кредиту', 'CCK', 'FM_YESNO', 0, 
    'MAIN');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
branch_attribute_utl.add_new_attribute_with_set('INSCC','CCK Включення перевірки параметру страхування при авторизації кредиту','N',null,null,'/','1');
end;
/
commit;

---------------------------------------

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY0T', 'Страхування забезпечення №1', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY2T', 'Страхування забезпечення №2', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY4T', 'Страхування забезпечення №3', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY6T', 'Страхування забезпечення №4', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY8T', 'Страхування забезпечення №5', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

----------------------------------------
begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY1T', 'Страхування поруки №1', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY3T', 'Страхування поруки №2', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY5T', 'Страхування поруки №3', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY7T', 'Страхування поруки №4', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY9T', 'Страхування поруки №5', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;
----------------------------------------

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY0U', 'Номер договору забезпечення №1', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY2U', 'Номер договору забезпечення №2', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY4U', 'Номер договору забезпечення №3', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY6U', 'Номер договору забезпечення №4', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY8U', 'Номер договору забезпечення №5', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

--------------------------------------------------

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY1U', 'Номер договору поруки №1', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY3U', 'Номер договору поруки №2', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY5U', 'Номер договору поруки №3', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY7U', 'Номер договору поруки №4', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY9U', 'Номер договору поруки №5', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

------------------------------------------------------

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY0V', 'Дата укладення договору забезпечення №1', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY2V', 'Дата укладення договору забезпечення №2', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY4V', 'Дата укладення договору забезпечення №3', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY6V', 'Дата укладення договору забезпечення №4', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY8V', 'Дата укладення договору забезпечення №5', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

------------------------------------------------

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY1V', 'Дата укладення договору поруки №1', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY3V', 'Дата укладення договору поруки №2', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY5V', 'Дата укладення договору поруки №3', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY7V', 'Дата укладення договору поруки №4', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY9V', 'Дата укладення договору поруки №5', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;