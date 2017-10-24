CREATE OR REPLACE TRIGGER "BARS".ti_accounts_rko after insert on accounts
for each row
declare
  stmp_ char(4);
begin
  if :new.kv = 980 then
    begin
      select nbs into stmp_ from rko_nbs where nbs=substr(:new.NLS,1,4) ;
      insert into rko_lst(acc) values(:new.acc);
    exception when no_data_found then
      return;
    end;
  end if;
end;
/