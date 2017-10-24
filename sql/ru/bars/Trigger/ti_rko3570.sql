

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_RKO3570.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_RKO3570 ***

  CREATE OR REPLACE TRIGGER BARS.TI_RKO3570 
instead of insert or update or delete on v_rko_3570 for each row
begin
  if inserting then
    insert into rko_3570(acc)
    select acc from accounts where nls=:new.nls and kv=:new.kv;
  elsif updating then
    update rko_3570 r set acc=
    (select acc from accounts where nls=:new.nls and kv=:new.kv)
    where acc=:old.acc;
  elsif deleting then
    delete from rko_3570 where acc=
    (select acc from accounts where nls=:old.nls and kv=:old.kv);
  end if;
end;
/
ALTER TRIGGER BARS.TI_RKO3570 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_RKO3570.sql =========*** End *** 
PROMPT ===================================================================================== 
