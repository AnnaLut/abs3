begin
 execute immediate   'alter table NBU23_REZ add (rez9 number) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN NBU23_REZ.rez9  IS 'Резерв по стандарту МСФЗ-9 ном.';

begin
 execute immediate   'alter table NBU23_REZ add (rezq9 number) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN NBU23_REZ.rezq9  IS 'Резерв по стандарту МСФЗ-9 екв.';

begin
 execute immediate   'alter table NBU23_REZ_OTCN add (rez9 number) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN NBU23_REZ.rez9  IS 'Резерв по стандарту МСФЗ-9 ном.';

begin
 execute immediate   'alter table NBU23_REZ_OTCN add (rezq9 number) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN NBU23_REZ.rezq9  IS 'Резерв по стандарту МСФЗ-9 екв.';
/


