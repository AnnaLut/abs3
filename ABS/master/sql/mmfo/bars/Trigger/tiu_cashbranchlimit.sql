

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CASHBRANCHLIMIT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CASHBRANCHLIMIT ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CASHBRANCHLIMIT 
  before insert or update ON CASH_BRANCH_LIMIT for each row
begin
  If :new.l_t in ('1','2') and length(:new.branch) = 15 OR
     :new.l_t in ('3','4') and length(:new.branch) = 22  then
     RETURN;
  end if;

  raise_application_error(-20100,
  'Вид лiмiту '|| :new.l_t ||'  НЕ вiдповiдає бранчу '|| :new.branch);

end TIU_CASHBRANCHLIMIT;



/
ALTER TRIGGER BARS.TIU_CASHBRANCHLIMIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CASHBRANCHLIMIT.sql =========***
PROMPT ===================================================================================== 
