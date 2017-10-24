

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNT_OVERSOB.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ACCOUNT_OVERSOB ***

  CREATE OR REPLACE TRIGGER BARS.TU_ACCOUNT_OVERSOB 
   BEFORE UPDATE OF LIM, OSTC, MDATE
   ON ACCOUNTS
   REFERENCING FOR EACH ROW
  WHEN (
new.nbs=2600 or new.nbs=2067
      ) DECLARE
 nd_   acc_over.nd%type;
 ndoc_ acc_over.ndoc%type;
BEGIN

   begin
    select distinct nd,ndoc
    into nd_,ndoc_
    from acc_over
    where acc = :new.acc
      and nvl(sos,0) <> 1;
   exception when NO_DATA_FOUND then return;
   end;

   if :new.nbs = 2600 then

     -- погашение овердрафта
     if :old.ostc < 0 and :new.ostc >= 0 then

       p_oversob ( :new.acc,null,null,5,0,null);

     end if;

     -- изменение даты погашения остатка
     if :old.mdate <> :new.mdate  then

       p_oversob ( :new.acc,null,null,3,0,:new.mdate);

     end if;

     -- изменение лимита
     if :old.lim <> :new.lim  then

       p_oversob ( :new.acc,null,null,10,:new.lim,null);

     end if;

   elsif :new.nbs = 2067 then

     -- погашение просрочки
     if :old.ostc < 0 and :new.ostc >= 0 then

       p_oversob ( :new.acc,null,null,7,0,null);

     end if;

   end if;

EXCEPTION WHEN OTHERS THEN
 return;
END tu_account_oversob;



/
ALTER TRIGGER BARS.TU_ACCOUNT_OVERSOB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNT_OVERSOB.sql =========*** 
PROMPT ===================================================================================== 
