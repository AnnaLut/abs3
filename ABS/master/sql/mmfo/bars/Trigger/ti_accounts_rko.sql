

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_ACCOUNTS_RKO.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_ACCOUNTS_RKO ***

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

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_ACCOUNTS_RKO.sql =========*** End
PROMPT ===================================================================================== 
