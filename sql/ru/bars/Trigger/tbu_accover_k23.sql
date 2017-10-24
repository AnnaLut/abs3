

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOVER_K23.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOVER_K23 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOVER_K23 
  before update of FIN23, OBS23  ON BARS.ACC_OVER   for each row
 WHEN (
nvl(old.FIN23,0) <> nvl(new.FIN23,0) OR
       nvl(old.OBS23,0) <> nvl(new.OBS23,0)
      ) declare

  l_fin23 int; l_obs23 int; l_kat23 int; l_k23 number; l_cus int; l_nd int; l_rnk int;

begin

  --по умолчательной методике ПЕТРОКОМ(ЮЛ) + она же ОЩАДБАНК (ФЛ)


  l_fin23 := nvl(:new.FIN23,0); l_obs23 := nvl(:new.OBS23,0); l_nd    := :new.nd;

  if l_fin23 = 0 or  l_obs23=0 then return; end if;
  ----------------------------------------------
  select c.custtype,a.rnk into l_cus,l_rnk from customer c, v_gl a  where a.acc = :old.acc and a.rnk =c.rnk;

   ------новые  KAT23
   begin
     select  kat into l_kat23 from FIN_OBS_KAT  where fin = l_fin23  and obs = l_obs23 and cus = l_cus ;
   EXCEPTION WHEN NO_DATA_FOUND THEN    --самое плохое значение
     raise_application_error(-20000, 'КД реф='      || :old.ND ||
                                     ' пом.Фiн.23=' || l_fin23 ||
                                     ' або Обс.23=' || l_obs23 );
   end;

   k23_def ( p_fin23 => l_fin23,
             p_obs23 => l_obs23,
             p_cus   => l_cus  ,
             p_nd    => l_nd   ,
             p_rnk   => l_rnk  ,
            -------------------
             p_KAT23 => l_kat23, -- OUT int,
             p_k23   => l_k23    -- OUT number
           );

   ------новые  K23
   if l_k23 is null THEN
      if :new.nd=5078055 and sysdate<to_date('20-06-2016','dd-mm-yyyy') THEN
         l_k23 := 0.06;
      else
         begin
           select k into l_k23 from stan_kat23 where kat=l_kat23;
         EXCEPTION WHEN NO_DATA_FOUND THEN l_k23 := 1;
         end;
      end if;
   end if;

   :new.KAT23 := l_kat23;
   :new.k23   := l_k23  ;

end tbu_ACCOVER_k23;
/
ALTER TRIGGER BARS.TBU_ACCOVER_K23 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOVER_K23.sql =========*** End
PROMPT ===================================================================================== 
