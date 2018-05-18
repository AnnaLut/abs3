begin EXECUTE IMMEDIATE 'alter table bars.cck_ob22 add ( KL1 int ) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/


COMMENT ON COLUMN BARS.cck_ob22.KL1 IS '1=Одно-векторна КЛ для VIDD=2';

