begin
  execute immediate 'CREATE PUBLIC SYNONYM login FOR bars.login';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/