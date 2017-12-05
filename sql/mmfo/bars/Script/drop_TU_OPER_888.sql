begin 
  execute immediate 
    'DROP TRIGGER bars.TU_OPER_888';
exception when others then 
  if sqlcode=-04080 then null; else raise; end if;
end;
/