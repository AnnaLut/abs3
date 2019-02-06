begin
execute immediate 'alter table lcs_transactions add recipient varchar2(300 byte)';
exception
 when others  then 
      if sqlcode = -1430 then null; 
      else raise;
      end if;
end;
/

begin
execute immediate 'alter table lcs_transactions add purpose  varchar2(300 byte)';
exception
 when others  then 
      if sqlcode = -1430 then null; 
      else raise;
      end if;
end;
/
