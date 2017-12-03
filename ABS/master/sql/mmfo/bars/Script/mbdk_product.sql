begin
 execute immediate   'alter table mbdk_product add (NBS char(4)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN mbdk_product.NBS IS 'Бал.рах.продукту';

begin
 execute immediate   'alter table mbdk_product add (OB22 char(2)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN mbdk_product.Ob22 IS 'ОБ22 продукту';