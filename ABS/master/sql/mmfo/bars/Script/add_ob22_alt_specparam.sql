
begin  EXECUTE IMMEDIATE 'ALTER TABLE  bars.specparam ADD  (Ob22_alt char(2) ) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.SPECPARAM.OB22_alt IS 'Ob22 для рах NLSALT';


