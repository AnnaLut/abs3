

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_CP_KOD_DOK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_CP_KOD_DOK ***

  CREATE OR REPLACE TRIGGER BARS.TU_CP_KOD_DOK 
  AFTER UPDATE OF DOK ON "BARS"."CP_KOD"
  REFERENCING FOR EACH ROW
BEGIN
/*
 предназначен для замены счета начисленных купонов с R2 на R
 по ЦБ, которые куплены с отрицательным купоном.
 Т.е. приведение их в НОРМУ.
*/

 for k in (select d.ACCR, d.ACC
           from cp_deal d, accounts a, int_accn i
           where d.id  = :NEW.ID
             and d.acc = a.acc
             and d.accr is not null
             and d.accr2 is not null
             and i.acra= d.accr2
             and i.id  = 0
             and i.acc = a.acc
             and i.ID  = :NEW.TIP-1
             and (a.ostc <>0 or a.ostb<>0) )
 loop
   update int_accn set acra = k.ACCR where acc = k.ACC and id=0;
 end loop;
END;
/
ALTER TRIGGER BARS.TU_CP_KOD_DOK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_CP_KOD_DOK.sql =========*** End *
PROMPT ===================================================================================== 
