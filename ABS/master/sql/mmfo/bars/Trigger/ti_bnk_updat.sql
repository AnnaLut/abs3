

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_BNK_UPDAT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_BNK_UPDAT ***

  CREATE OR REPLACE TRIGGER BARS.TI_BNK_UPDAT 
  AFTER INSERT ON banks_update
  FOR EACH ROW
-- Reflects banks_update insertion into banks table
-- Ver @(#) ti_bnkup.sql 3.1.1.2 98/10/28


BEGIN
   sep.pu_grc(:NEW.op,:NEW.mfop,:NEW.mfou,:NEW.mfo,:NEW.sab,:NEW.nbw,:NEW.model_no,:NEW.reserved);
END ti_bnk_updat;




/
ALTER TRIGGER BARS.TI_BNK_UPDAT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_BNK_UPDAT.sql =========*** End **
PROMPT ===================================================================================== 
