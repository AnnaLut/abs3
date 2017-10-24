

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_SPECPARAM.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_SPECPARAM ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_SPECPARAM 
  BEFORE INSERT OR UPDATE OF R013 ON "BARS"."SPECPARAM"
  REFERENCING FOR EACH ROW
DECLARE
   tip_   accounts.tip%type;
   nbs_	  accounts.nbs%type;
/******************************************************************************
   NAME: TBIU_SPECPARAM
   PURPOSE: временный триггер для подмены значений параметра R013,
   			проставляемых в пакете ССК для счетов начисленных доходов
   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        12.04.2007  Virko            1. Created this trigger.
 ******************************************************************************/
BEGIN
      select nbs, tip
      into nbs_, tip_
      from accounts
      where acc=:new.acc;
  
   if tip_ = 'SN ' then
   	  if nbs_ in ('1518', '1528') and :new.r013 in ('1', '2', '3', '4') then
	  	 :new.r013:=null;
	  elsif nbs_ not in ('1518', '1528') and :new.r013 in ('1', '2') then
	  	 :new.r013:='3';
	  end if;
    end if;
END;


/
ALTER TRIGGER BARS.TBIU_SPECPARAM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_SPECPARAM.sql =========*** End 
PROMPT ===================================================================================== 
