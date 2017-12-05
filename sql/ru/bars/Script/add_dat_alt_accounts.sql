begin  EXECUTE IMMEDIATE 'ALTER TABLE  bars.accounts  ADD  (DAT_ALT date ) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.ACCOUNTS.DAT_ALT IS 'Дата заміни NLS->NLSALT';