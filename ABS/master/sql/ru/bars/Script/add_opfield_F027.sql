begin
Insert into BARS.OP_FIELD
   (TAG, NAME, BROWSER, USE_IN_ARCH)
 Values
   ('F027', 'Код індикатора', 'TagBrowse("SELECT F027,txt FROM KOD_F027")', 1);
exception
     when dup_val_on_index
     then
     null; 
end;
/
commit;