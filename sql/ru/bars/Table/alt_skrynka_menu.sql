begin 
execute immediate 
' ALTER TABLE skrynka_menu ADD (STRPARNAME VARCHAR2 (30 Byte) )';
exception when others then 
if sqlcode=-1430 then null; else raise; end if;
end;
/
