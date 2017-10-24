

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_FINND_KOD_INV_ISINP.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_FINND_KOD_INV_ISINP ***

  CREATE OR REPLACE TRIGGER BARS.TAI_FINND_KOD_INV_ISINP 
after insert or update  ON BARS.FIN_ND for each row
   WHEN (
new.kod = 'INV' and  new.s = 1 and old.s <> new.s
      ) begin

    update nd_txt set txt = (select inv_name from fin_inv_type where inv_kod = 0)  where nd = :new.nd and tag = 'ISINP';
    if sql%rowcount = 0 then
            insert into nd_txt (nd, tag, txt) values (:new.nd, 'ISINP',  (select inv_name from fin_inv_type where inv_kod = 0));
    end if;

end tai_finnd_kod_INV_isinp;


/
ALTER TRIGGER BARS.TAI_FINND_KOD_INV_ISINP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_FINND_KOD_INV_ISINP.sql ========
PROMPT ===================================================================================== 
