PROMPT *** Create  trigger TAU_OPER_KOMIS_NON_CASH ***

create or replace trigger TAU_OPER_KOMIS_NON_CASH
after insert on OPER
for each row
WHEN ( new.TT = 'R01'         -- міжбанк
   and new.KV = 980           -- нац.валюта
   and new.DK = 1             -- надходження
   and new.NLSB like '2620%'  -- поточні рах. / депозити навимогу ФО
   and new.MFOA not like '8%' -- не від казначейства
   and new.PDAT >= trunc(sysdate)
     )
begin

  insert -- добавляем документ в очередь на снятие комиссии
    into KOMIS_NON_CASH (ref)
  values (:new.ref);

end TAU_OPER_KOMIS_NON_CASH;
/

show errors;
