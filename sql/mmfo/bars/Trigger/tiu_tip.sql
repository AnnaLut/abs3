

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_TIP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_TIP ***

  CREATE OR REPLACE TRIGGER BARS.TIU_TIP 
   BEFORE INSERT OR UPDATE OF tip
   ON accounts
   FOR EACH ROW
     WHEN (    (   new.tip = 'N00'
              OR new.tip = 'T00'
              OR new.tip = 'T0D'
              OR new.tip = 'TNB'
              OR new.tip = 'TND'
              OR new.tip = 'L99'
              OR new.tip = 'N99'
              OR new.tip = '902'
              OR new.tip = '90D')
         AND new.tip <> old.tip) BEGIN
   raise_application_error (
      - (20000 + 1),
      'Cannot duplicate or update account with tip=' || :new.tip,
      TRUE);
END tiu_tip;



/
ALTER TRIGGER BARS.TIU_TIP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_TIP.sql =========*** End *** ===
PROMPT ===================================================================================== 
