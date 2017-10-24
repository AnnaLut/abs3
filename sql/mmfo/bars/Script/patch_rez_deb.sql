begin
 execute immediate   'alter table REZ_DEB add (tipa  INTEGER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_DEB.tipa  IS 'Тип активу (по REZ_TIPA)';

begin
 execute immediate   'alter table REZ_DEB add (tipa_FV INTEGER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_DEB.tipa_FV  IS 'Тип активу для прийому від FV';

