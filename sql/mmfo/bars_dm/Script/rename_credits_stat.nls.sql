prompt rename column nls - nls_SG
begin
execute immediate 'alter table credits_stat rename column nls to   nls_SG';
exception
  when others then
     if sqlcode = -957 then null; ---[1]: ORA-00957: duplicate column name
     else
       raise;
     end if;
end;
/

