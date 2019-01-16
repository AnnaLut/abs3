begin
Insert into BARS.SW_IORULE
   (MT, IO_IND)
 Values
   (192, 'I');
exception when dup_val_on_index then null;
end;
/
begin    
Insert into BARS.SW_IORULE
   (MT, IO_IND)
 Values
   (192, 'O');
   exception when dup_val_on_index then null;
end;
/
begin
Insert into BARS.SW_IORULE
   (MT, IO_IND)
 Values
   (196, 'I');
exception when dup_val_on_index then null;
end;
/
begin    
Insert into BARS.SW_IORULE
   (MT, IO_IND)
 Values
   (196, 'O');
   exception when dup_val_on_index then null;
end;
/
begin
Insert into BARS.SW_IORULE
   (MT, IO_IND)
 Values
   (299, 'I');
exception when dup_val_on_index then null;
end;
/
begin    
Insert into BARS.SW_IORULE
   (MT, IO_IND)
 Values
   (299, 'O');
   exception when dup_val_on_index then null;
end;
/

COMMIT;
