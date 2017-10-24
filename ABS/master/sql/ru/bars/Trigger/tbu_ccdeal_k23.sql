

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CCDEAL_K23.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CCDEAL_K23 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CCDEAL_K23 
  before update of FIN23, OBS23  ON BARS.CC_DEAL   for each row
 WHEN (
new.FIN23 >0 and new.OBS23 >0
      ) declare
 l_cus   int   ; l_fin23 int   ;   l_obs23 int;   l_nd    number; l_rnk   number;
 l_kat23 int   ; l_k23   number;


 l_fin int   ;   l_obs int;  l_kat int   ; l_k   number; l_flag int;
begin

  l_fin23 := nvl(:new.FIN23,0);  l_obs23 := nvl(:new.OBS23,0);
  if l_fin23 = 0 or  l_obs23 =0  then return; end if;

  l_nd    := :old.nd; l_rnk   := :old.rnk;
  ----------------------------------------------
  --по умолчательной методике ПЕТРОКОМ(ЮЛ) + она же ОЩАДБАНК (ФЛ)

--  If    :old.vidd in ( 1, 2, 3)                then l_cus := 2;
--  elsIf :old.vidd in (11,12,13)                then l_cus := 3;
--  elsif :old.vidd >=1500 and  :old.vidd <=1600 then l_cus := 1;
--  else
    select custtype into l_cus from customer where rnk =:old.rnk;
--  end if ;


     -- В нас появились бюджетні організації
     -- А в них все не так:

              case
                    WHEN substr(:new.prod,1,2) = '21' THEN
					           l_cus := 4;
							   l_fin23 := least(l_fin23, 4);   -- бюджетні установи від 1 до 4 COBUPRVN-166

							 if  :new.FIN23 > 4 and nvl(:old.FIN23,0) <=4
								  then  raise_application_error(-(20000+111),'\' ||'Заборонено встановлювати значення класу позичальника вище 4 для державних установ ',TRUE);
							 end if;

                    ELSE l_cus := l_cus;
                END CASE;

 --новые  KAT23 по умолчанию +  новые  K23  по умолчанию
 k23_def ( p_fin23 => l_fin23,
           p_obs23 => l_obs23,
           p_cus   => l_cus  ,
           p_nd    => l_nd   ,
           p_rnk   => l_rnk  ,
           -------------------
           p_KAT23 => l_kat23, -- OUT int,
           p_k23   => l_k23  -- OUT number
         );

-- BRSMAIN-2660
		if 	l_kat23  < 5 then
				if    SP_50(:new.nd, round(sysdate,'MM') ) = 5 then
							l_kat23 := 5;
							l_k23   := 1;
				end if;
		end if;



  -- вичитуємо ручне коригування
  fin_nbu.get_adjustment (p_mod     =>  'CCK',
                          p_nd      =>  :new.nd,
                          p_flag    =>  l_flag,
                          p_fin23   =>  l_fin,
                          p_obs23   =>  l_obs,
                          p_kat23   =>  l_kat,
                          p_k23     =>  l_k);



  Case l_flag
    when  1 then   -- приміняємо ручне коригування

             :new.fin23 := l_fin  ;
             :new.obs23 := l_obs  ;
             :new.KAT23 := l_kat  ;
             :new.k23   := l_k    ;

    else
             :new.KAT23 := l_kat23;
             :new.k23   := l_k23  ;
  End case;



end tbu_CCDEAL_K23;
/
ALTER TRIGGER BARS.TBU_CCDEAL_K23 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CCDEAL_K23.sql =========*** End 
PROMPT ===================================================================================== 
