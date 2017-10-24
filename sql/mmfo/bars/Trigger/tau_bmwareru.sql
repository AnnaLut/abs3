

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_BMWARERU.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_BMWARERU ***

  CREATE OR REPLACE TRIGGER BARS.TAU_BMWARERU 
  INSTEAD OF UPDATE ON "BARS"."V_BM_WARE_RU"
  REFERENCING FOR EACH ROW
  BEGIN
  If pul.get_mas_ini_val ('TTTT' ) like '1001%' then
     BM_300465.FL  (:new.kod, :new.kol, :new.CENA_PROD) ;
  else
     BM_300465.RU  (:new.kod, :new.kol, :new.CENA_PROD) ;
  end if;
END TAU_BMWARERU ;



/
ALTER TRIGGER BARS.TAU_BMWARERU ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_BMWARERU.sql =========*** End **
PROMPT ===================================================================================== 
