

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_LOM_234.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_LOM_234 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_LOM_234 
     INSTEAD OF UPDATE
       ON LOM_234 REFERENCING NEW AS NEW OLD AS OLD
declare
  S1_ number;
  S2_ number;
begin
  If nvl(:new.sum1,0) <=0 then
     raise_application_error(
            -20203,
            '\9356 - Žè.¢ ‘ã¬¬¥ "–¥­ -1 „Œ /  ­ª"',
            TRUE);
  end if;
  S1_:= :new.sum1*100;
  If :old.npp = 3 then
     S1_:= S1_ + round(S1_*20/100,0) ;
  end if;

  If :old.npp = 4 then
     If nvl(:new.sum2,0) <=0 then
        raise_application_error(
            -20203,
            '\9356 - Žè.¢ ‘ã¬¬¥ "®áâã¯¨«®(¢ âç „‘)"',
            TRUE);
     end if;
  end if;
  S2_ := :new.sum2*100;

  cc_lom (:old.npp, null, s1_, s2_, :NEW.nazn);
end tbu_LOM_234;



/
ALTER TRIGGER BARS.TBU_LOM_234 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_LOM_234.sql =========*** End ***
PROMPT ===================================================================================== 
