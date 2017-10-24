

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_CP_KOD_DATEM.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_CP_KOD_DATEM ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_CP_KOD_DATEM 
  BEFORE INSERT OR UPDATE ON "BARS"."CP_KOD"
  REFERENCING FOR EACH ROW
begin
    :NEW.dat_em  :=  trunc(:NEW.dat_em);
end tbiu_cp_kod_datem;
/
ALTER TRIGGER BARS.TBIU_CP_KOD_DATEM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_CP_KOD_DATEM.sql =========*** E
PROMPT ===================================================================================== 
