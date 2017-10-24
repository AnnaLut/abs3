

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_VOBPCMERCH.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_VOBPCMERCH ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_VOBPCMERCH 
  INSTEAD OF INSERT OR DELETE OR UPDATE ON "BARS"."V_OBPC_MERCH"
  REFERENCING FOR EACH ROW
  declare
  g_modcode  varchar2(3) := 'BPK';
  l_acc      number;
begin
  if inserting then
     if :new.transit_nls is not null and :new.kv is not null then
        begin
           select acc into l_acc
             from accounts
            where nls = :new.transit_nls and kv = :new.kv;
        exception when no_data_found then
           -- Рахунок не знайдено
           bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', :new.transit_nls, to_char(:new.kv));
        end;
     else
        l_acc := null;
     end if;
     insert into obpc_merch (merch, kv, card_system, transit_acc)
     values (:new.merch, :new.kv, :new.card_system, l_acc);
  elsif updating then
     if :new.transit_nls is not null and :new.kv is not null then
        begin
           select acc into l_acc
             from accounts
            where nls = :new.transit_nls and kv = :new.kv;
        exception when no_data_found then
           -- Рахунок не знайдено
           bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', :new.transit_nls, to_char(:new.kv));
        end;
     else
        l_acc := null;
     end if;
     update obpc_merch
        set kv = :new.kv,
            transit_acc = l_acc
      where merch = :new.merch and card_system = :new.card_system;
  elsif deleting then
     delete from obpc_merch where merch = :old.merch and card_system = :old.card_system;
  end if;
end;



/
ALTER TRIGGER BARS.TIUD_VOBPCMERCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_VOBPCMERCH.sql =========*** End
PROMPT ===================================================================================== 
