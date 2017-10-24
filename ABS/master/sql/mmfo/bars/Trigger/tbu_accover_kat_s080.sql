

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOVER_KAT_S080.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOVER_KAT_S080 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOVER_KAT_S080 
  before update of FIN23, OBS23  ON BARS.ACC_OVER for each row
 follows tbu_ACCOVER_K23
declare
   acc_ number;
begin
  for p in (select a.acc,a.RNK from accounts a where dazs is null  and acc in
               (     :old.acc                , nvl(:old.accO    , :old.acc),
                 nvl(:old.ACC_9129, :old.acc), nvl(:old.ACC_2067, :old.acc),
                 nvl(:old.ACC_2069, :old.acc), nvl(:old.ACC_2096, :old.acc)
               )
            union all
            select a.acc,a.RNK from accounts a where dazs is null  and acc in (select acc from nd_acc where nd= :old.ND)
               )
   loop
      update specparam set s080 = to_char(:new.kat23) where acc = p.Acc;
      if SQL%rowcount = 0 then
         INSERT INTO SPECPARAM (ACC,S080) VALUES (P.ACC, to_char(:new.kat23) ) ;
      end if;
     begin
        select acra into acc_ from int_accn where id= 0 and acc=p.ACC;
        update specparam set s080 = to_char(:new.kat23) where acc = Acc_;
        if SQL%rowcount = 0 then
           INSERT INTO SPECPARAM (ACC,S080) VALUES (ACC_, to_char(:new.kat23) ) ;
        end if;
     EXCEPTION WHEN NO_DATA_FOUND THEN  null;
     END;
   end loop; --- P
end tbu_accover_KAT_S080;


/
ALTER TRIGGER BARS.TBU_ACCOVER_KAT_S080 DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOVER_KAT_S080.sql =========**
PROMPT ===================================================================================== 
