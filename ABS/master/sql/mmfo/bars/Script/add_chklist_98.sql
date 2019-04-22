begin
Insert into BARS.CHKLIST
   (IDCHK, NAME, F_IN_CHARGE, IDCHK_HEX)
 Values
   (98, '98_Технологічна віза імпорту', 1, '62');
 exception when dup_val_on_index then null;  
end;
/  
COMMIT;