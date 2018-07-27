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
    into KOMIS_NON_CASH ( REF )
  select :new.REF
    from ACCOUNTS
   where KF  = :new.KF
     and NLS = :new.NLSB
     and KV  = :new.KV
     and TIP = 'DEP';

end TAU_OPER_KOMIS_NON_CASH;
/

show errors;
