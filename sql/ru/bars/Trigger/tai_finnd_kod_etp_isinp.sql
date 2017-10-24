

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_FINND_KOD_ETP_ISINP.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_FINND_KOD_ETP_ISINP ***

  CREATE OR REPLACE TRIGGER BARS.TAI_FINND_KOD_ETP_ISINP 
after insert or update  ON BARS.FIN_ND for each row
 WHEN (
new.kod = 'ETP' and old.s <> new.s
      ) begin

    if :new.s  = 1 then
      update nd_txt set txt = (select inv_name from fin_inv_type where inv_kod = 1)  where nd = :new.nd and tag = 'ISINP';
      if sql%rowcount = 0 then
              insert into nd_txt (nd, tag, txt) values (:new.nd, 'ISINP',  (select inv_name from fin_inv_type where inv_kod = 1));
      end if;
    elsif :new.s  = 2 then
      update nd_txt set txt = (select inv_name from fin_inv_type where inv_kod = 2)  where nd = :new.nd and tag = 'ISINP';
      if sql%rowcount = 0 then
              insert into nd_txt (nd, tag, txt) values (:new.nd, 'ISINP',  (select inv_name from fin_inv_type where inv_kod = 2));
      end if;
    end if;

end tai_finnd_kod_ETP_isinp;
/
ALTER TRIGGER BARS.TAI_FINND_KOD_ETP_ISINP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_FINND_KOD_ETP_ISINP.sql ========
PROMPT ===================================================================================== 
