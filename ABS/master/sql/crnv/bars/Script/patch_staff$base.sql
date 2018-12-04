begin
  execute immediate 'alter table STAFF$BASE drop constraint cc_staff_tabn_cc';
  dbms_output.put_line('Table altered.');
exception
  when others then if sqlcode = -2443 then null; else raise; end if;
end;
/