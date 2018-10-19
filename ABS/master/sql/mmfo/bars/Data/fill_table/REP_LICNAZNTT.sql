begin 
insert into REP_LICNAZNTT(TT) values ('DOR'); 
exception when others then null;
end;
/
begin 
insert into REP_LICNAZNTT(TT) values ('DO1'); 
exception when others then null;
end;
/
begin 
insert into REP_LICNAZNTT(TT) values ('DO2'); 
exception when others then null;
end;
/
commit;