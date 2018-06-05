begin
Insert into BARS.CHECK_TAG
   (TT, TAG_PARENT, VALUE_PARENT, TAG_CHILD, REQUIRED)
 Values
   ('048', 'REZID', '2', 'DJNR ', 'Y');
exception when dup_val_on_index then null;
end;
/   
COMMIT;
