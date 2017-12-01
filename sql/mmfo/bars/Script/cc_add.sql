begin
 execute immediate   'alter table CC_add add (N_NBU varchar2(50)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN cc_add.n_NBU IS 'Номер свідоцтва НБУ';
begin
 execute immediate   'alter table CC_add add (D_NBU date) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN cc_add.D_NBU IS 'Дата реєстрації в НБУ';


