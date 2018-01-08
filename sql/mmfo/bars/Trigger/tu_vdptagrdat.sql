

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_VDPTAGRDAT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_VDPTAGRDAT ***

  CREATE OR REPLACE TRIGGER BARS.TU_VDPTAGRDAT 
 INSTEAD
 OF update
 ON V_DPT_AGR_DAT
 FOR EACH ROW
BEGIN
 update dpt_agreements set AGRMNT_DATE = to_date(:new.AGRMNT_DATE,'dd/mm/yyyy'),
                           DATE_BEGIN  = to_date(:new.DATE_BEGIN ,'dd/mm/yyyy'),
                           DATE_END    = to_date(:new.DATE_END   ,'dd/mm/yyyy')
        where DPT_ID = :OLD.DPT_ID and AGRMNT_NUM=:old.AGRMNT_NUM;
END;




/
ALTER TRIGGER BARS.TU_VDPTAGRDAT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_VDPTAGRDAT.sql =========*** End *
PROMPT ===================================================================================== 
