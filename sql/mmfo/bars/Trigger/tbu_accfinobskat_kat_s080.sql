

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCFINOBSKAT_KAT_S080.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCFINOBSKAT_KAT_S080 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCFINOBSKAT_KAT_S080 
  before update of FIN, OBS  ON BARS.ACC_FIN_OBS_KAT   for each row
  follows tbiu_ACC_FIN_OBS_KAT_K23
begin
   update specparam set s080 = to_char(:new.kat) where acc = :old.Acc;
   if SQL%rowcount = 0 then
      INSERT INTO SPECPARAM (ACC,S080) VALUES (:old.ACC, to_char(:new.kat) ) ;
   end if;
end tbu_accfinobskat_KAT_S080;


/
ALTER TRIGGER BARS.TBU_ACCFINOBSKAT_KAT_S080 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCFINOBSKAT_KAT_S080.sql ======
PROMPT ===================================================================================== 
