begin 
   execute immediate 'drop trigger TAU_ACCOUNTS_NBU49';
exception when others then null;
end;
/

begin 
   execute immediate 'begin drop trigger TU_ACCOUNTS_RKO';
exception when others then null;
end;
/
