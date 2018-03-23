begin
Insert into BARS.OP_FIELD
   (TAG, NAME, BROWSER, USE_IN_ARCH)
 Values
   ('D1#3K', 'Код мети придбання/продажу валюти', 'TagBrowse("SELECT F092,txt FROM F092")', 1);
exception
     when dup_val_on_index
     then
     null; 
end;
/
commit;
