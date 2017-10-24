

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ZAY_BACK_RESERVE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ZAY_BACK_RESERVE ***

  CREATE OR REPLACE TRIGGER BARS.TU_ZAY_BACK_RESERVE 
after update on zayavka
for each row
    WHEN (old.viza = 1       and new.viza = -1 and
      old.sos = 0        and new.sos  = -1 and
      old.idback is null and new.idback = -1) begin
  -- откат суммы лимита при сторнировании заявки на покупку валюты
  -- нужен только при birja.rezerv = 1
  update accounts
     set lim = nvl(lim, 0) + :old.lim
   where acc = :old.acc0
     and :old.lim is not null;
end;



/
ALTER TRIGGER BARS.TU_ZAY_BACK_RESERVE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ZAY_BACK_RESERVE.sql =========***
PROMPT ===================================================================================== 
