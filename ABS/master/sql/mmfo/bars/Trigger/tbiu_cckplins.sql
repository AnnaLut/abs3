

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_CCKPLINS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_CCKPLINS ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_CCKPLINS 
before insert or update of ND ON CCK_PL_INS for each row
begin  :new.ND := to_number ( pul.get_mas_ini_val('ND') ) ; end ;

/
ALTER TRIGGER BARS.TBIU_CCKPLINS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_CCKPLINS.sql =========*** End *
PROMPT ===================================================================================== 
