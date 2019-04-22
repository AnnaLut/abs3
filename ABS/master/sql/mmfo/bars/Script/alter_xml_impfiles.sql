begin   
 execute immediate '  alter table xml_IMPFILES add (CONFIG  VARCHAR2(150))';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
end;
/


begin   
 execute immediate '  alter table xml_IMPFILES add (imptype  VARCHAR2(100))';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
end;
/

