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