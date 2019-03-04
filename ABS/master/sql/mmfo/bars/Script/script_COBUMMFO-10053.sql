begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME,TYPE,  NOT_TO_EDIT, CODE)
 Values
   ('LIZASUM', 'Автоматична зміна вартості предмета лізингу', 'CCK', 'FM_YESNO', 'C', 0, 'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME,TYPE,  NOT_TO_EDIT, CODE)
 Values
   ('LIZSUM', 'Вартість предмета лізингу', 'CCK', null, 'N', 0, 'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
update BARS.CC_TAG 
  set CODE = 'ZAL'
where TAG in ('LIZSUM','LIZASUM');
end;
/
COMMIT;