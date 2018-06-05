
begin EXECUTE IMMEDIATE 'alter table bars.mbdk_ob22 add ( K9 int ) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.mbdk_OB22.K9    IS 'Числовой код по IFRS=принцип обліку по МСФЗ-9 ("корзина")';

update mbdk_OB22 set K9 = 1 where substr(SS,1,4) in ('2063','1500','2102','2062','2083','2063','1502','2062','2233','2062','2203','2202');
commit;




