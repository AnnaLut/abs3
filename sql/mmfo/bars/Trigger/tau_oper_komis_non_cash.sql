

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_KOMIS_NON_CASH.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_KOMIS_NON_CASH ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_KOMIS_NON_CASH 
after update or insert of dk on oper
for each row
    WHEN (new.tt = 'R01'and substr(new.nlsb,1,4)='2620' and new.dk=1
) begin

  --if inserting then
    -- добавляем документ в очередь на снятие комиссии
     insert into komis_non_cash (ref) values (:new.ref);

  --end if;

end tau_oper_komis_non_cash;


/
ALTER TRIGGER BARS.TAU_OPER_KOMIS_NON_CASH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_KOMIS_NON_CASH.sql ========
PROMPT ===================================================================================== 
