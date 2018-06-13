 begin
 begin
     Insert into BARS.FR_PRINT_FORMAT
       (ID, FR_PRINT_FORMAT)
     Values
       (7, 'Pdf');
   exception when dup_val_on_index then null; 
   end;
   
  begin
     Insert into BARS.FR_PRINT_FORMAT
       (ID, FR_PRINT_FORMAT)
      Values
        (11, 'Word (doc)');
   exception when dup_val_on_index then null; 
   end;
   
   begin
    Insert into BARS.FR_PRINT_FORMAT
   (ID, FR_PRINT_FORMAT)
 Values
   (9, 'Rtf');
    exception when dup_val_on_index then null; 
   end;
 end;  
/
COMMIT;