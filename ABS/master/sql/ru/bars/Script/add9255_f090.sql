begin

   insert into BARS.OP_FIELD
              (TAG, NAME, BROWSER, USE_IN_ARCH)
     values   ('D1#3M', 'Êמה לועט הכÿ פאיכף 3ּױ', 'TagBrowse("SELECT F090,txt naim FROM F090")', 1);

exception
     when dup_val_on_index

       then    null; 
end;
/
commit;

begin

   insert into op_rules (tt, tag, opt, used4input, ord, val, nomodify)
     select tt, 'D1#3M', 'O', 0, max(nvl(ord,0))+1, null, null
       from op_rules
      where tt in ('007','024','030','215','807','817','830','8FY','C14','PKR','W4R',
                   '001','002','010','030','059','830','8C2','8C3','8C4','8FY','C00',
                   'C02','CFB','CFO','CFS','CL0','CLB','CLS','CVB','CVE','CVO','CVS',
                   'F02','FX2','FX3','FX4','FXQ','IBB','IBO','IBS','KK4','KK5','KV3',
                   'NOS','SW0','SW4','SW5','V07','V77','WD3','114','854','R01')
      group by tt;

exception
     when dup_val_on_index

       then    null; 
end;
/
commit;

