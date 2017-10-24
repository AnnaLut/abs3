

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CCDEAL_KAT_S080.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CCDEAL_KAT_S080 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CCDEAL_KAT_S080 
  before update of  FIN23, OBS23  ON BARS.CC_DEAL   for each row
   follows BARS.tbu_CCDEAL_K23
begin

 for p in (select a.acc from nd_acc n, accounts a where n.nd = :old.ND and n.acc=a.acc and a.rnk=:old.rnk and a.dazs is null
           and trim(a.tip) not in ('SD','SG','ODB','DEP') )
 loop

   update specparam set s080 = to_char(:new.kat23) where acc = p.Acc;
   if SQL%rowcount = 0 then
      INSERT INTO SPECPARAM (ACC,S080) VALUES (P.ACC, to_char(:new.kat23) ) ;
   end if;
 end loop; --- P

end tbu_CCDEAL_KAT_S080;
/
ALTER TRIGGER BARS.TBU_CCDEAL_KAT_S080 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CCDEAL_KAT_S080.sql =========***
PROMPT ===================================================================================== 
