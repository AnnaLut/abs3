begin
  Insert into BARS.TIPS
      (TIP, NAME)
   Values
      ('NLI', 'NLI розрахунки SWIFT по ЮЛ');
exception when dup_val_on_index then  null;
end;
/
COMMIT;


begin
  Insert into BARS.TIPS
      (TIP, NAME)
   Values
      ('NLJ', 'NLJ розрахунки SWIFT по ФЛ');
exception when dup_val_on_index then  null;
end;
/
COMMIT;

begin
  Insert into BARS.NBS_TIPS
       (NBS, TIP)
       Values
      ('3720','NLI');
exception when dup_val_on_index then  null;
end;
/
COMMIT;

begin
  Insert into BARS.NBS_TIPS
       (NBS, TIP)
       Values
      ('3720','NLJ');
exception when dup_val_on_index then  null;
end;
/
COMMIT;

begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('99', '024');
exception when dup_val_on_index then  null;
end;
/

begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('99', 'PKR');
exception when dup_val_on_index then  null;
end;
/

begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('99', '830');
exception when dup_val_on_index then  null;
end;
/

begin
Insert into BARS.NLK_TT
   (ID, TT)
 Values
   ('99', 'C14');
exception when dup_val_on_index then  null;
end;
/

COMMIT;
