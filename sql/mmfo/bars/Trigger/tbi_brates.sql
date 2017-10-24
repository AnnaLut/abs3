

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BRATES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BRATES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BRATES 
BEFORE INSERT ON BARS.BRATES
FOR EACH ROW
 WHEN ( new.br_id = 0 or new.br_id is null ) BEGIN
  :new.br_id := s_brates.NextVal;
END TBI_BRATES;
/
ALTER TRIGGER BARS.TBI_BRATES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BRATES.sql =========*** End *** 
PROMPT ===================================================================================== 
