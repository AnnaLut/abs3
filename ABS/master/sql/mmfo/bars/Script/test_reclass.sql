begin  EXECUTE IMMEDIATE '     CREATE TABLE TEST_RECLASS ( ACC_OLD NUMBER, ACC_NEW NUMBER )  ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/
