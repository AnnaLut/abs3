

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_INACTIVE_ACC.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_INACTIVE_ACC ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_INACTIVE_ACC 
--  Для задачи по списанию ежемесячной комиссии с НЕактивных счетов 2620/05  - Заявка COBUSUPABS-4769
--  Триггер анализирует корреспонденции счетов 2620/05 и (в случае "реальных" оборотов) меняет дату
--  DAPP_REAL в таблице ACC262005 по этому 2620/05.
after update of sos ON BARS.OPER
for each row
 WHEN (
old.sos!=5 and new.sos=5 and (new.nlsa like '2620%' or new.nlsb like '2620%')
      ) declare
l_ob22 accounts.ob22%type:=null;
l_acc  accounts.acc%type:=null;   ----------------------
begin

 if (:new.nlsA like '2620%' and :new.nlsB not like '6%' and :new.nlsB not like '2628%' and :new.nlsB not like '2638%'  and :new.TT <>'N12') then
    begin
      select a.ob22,a.acc into l_ob22,l_acc from accounts a where a.nls =:new.nlsA and a.kv =:new.kv  and a.ob22 ='05';
    exception when others then
      l_ob22:=null;
    end;
    if l_ob22 is not null then
       begin
         update acc262005 ac set ac.dapp_real = gl.bDATE  where ac.acc = l_acc;  ---   :new.nlsa;
         if sql%rowcount=0 then
            insert into acc262005 (ACC,DAPP_REAL) values (l_acc,gl.bDATE);
         end if;
       end;
    end if;
 end if;

 if (:new.nlsB like '2620%' and :new.nlsA not like '6%' and :new.nlsA not like '2628%' and :new.nlsA not like '2638%'  and :new.TT <>'N12') then
    begin
      select a.ob22,a.acc into l_ob22,l_acc from accounts a where a.nls =:new.nlsB and a.kv =:new.kv  and a.ob22 ='05';
    exception when others then
      l_ob22:=null;
    end;
    if l_ob22 is not null then
       begin
         update acc262005 ac set ac.dapp_real = gl.bDATE  where ac.acc = l_acc;  ---  :new.nlsb;
         if sql%rowcount=0 then
            insert into acc262005 (ACC,DAPP_REAL) values (l_acc,gl.bDATE);
         end if;
       end;
    end if;
 end if;

end;
/
ALTER TRIGGER BARS.TAU_OPER_INACTIVE_ACC DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_INACTIVE_ACC.sql =========*
PROMPT ===================================================================================== 
