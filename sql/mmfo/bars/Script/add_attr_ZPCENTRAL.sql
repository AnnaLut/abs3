begin   
branch_attribute_utl.create_attribute    ('ZPCENTRAL', 'Сервіс для передачі ознаки централізованого договору', 'C');
branch_attribute_utl.set_attribute_value ('/','ZPCENTRAL','/barsroot/webservices/SalaryBagServices/ZPServiceMain.asmx');   
end;
/
begin   
branch_attribute_utl.create_attribute    ('ZPCORP2URL', 'URL вебсервіса corp2 для передачі довідників', 'C');
end;
/
commit;
/
merge into bars.web_barsconfig a using
 (select
  1 as grouptype,
  'ZP.ABS_login' as key,
  null as csharptype,
  '' as val,
  'ZP: логін технічного користувача' as comm
  from dual) b
on (a.key = b.key)
when not matched then 
insert (
  grouptype, key, csharptype, val, comm)
values (
  b.grouptype, b.key, b.csharptype, b.val, b.comm);
/
commit;
/

