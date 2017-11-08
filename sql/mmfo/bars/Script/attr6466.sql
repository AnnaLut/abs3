begin
    branch_attribute_utl.add_new_attribute('SW_YEAR', 'Рахунок 3739 для зарахування SWIFT(кінець року)', 'C');
    branch_attribute_utl.set_attribute_value('/300465/', 'SW_YEAR', '37395529');

    commit;
end;
/

begin

Insert into BARS.SW_TT_IMPORT
   (TT, IO_IND, ORD)
 Values
   ('8FY', 'O', 99);
exception when dup_val_on_index then null;
end;
/   
begin
Insert into BARS.TIPS
   (TIP, NAME, ORD)
 Values
   ('NLF', '3739 для SWIFT-картотеки', 999);
exception when dup_val_on_index then null;
end;
/   
COMMIT;

EXEC bc.go(300465);

BEGIN
   FOR k IN (SELECT acc
               FROM accounts
              WHERE nls = '37395529')
   LOOP
      UPDATE accounts
         SET tip = 'NLF'
       WHERE acc = k.acc;
   END LOOP;
END;
/

COMMIT;
EXEC bc.home;
