begin EXECUTE IMMEDIATE 'alter table bars.cc_deal add ( NDG number) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.cc_deal.NDG IS 'Реф генерального КД ';