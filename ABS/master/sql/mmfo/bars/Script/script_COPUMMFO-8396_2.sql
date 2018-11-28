begin EXECUTE IMMEDIATE 'drop table NBU_CREDIT_INSURANCE ';
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   -- ORA-00942: table or view does not exist
end;
/

begin EXECUTE IMMEDIATE 'drop table NBU_CREDIT_INSURANCE_FILES ';
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   -- ORA-00942: table or view does not exist
end;
/