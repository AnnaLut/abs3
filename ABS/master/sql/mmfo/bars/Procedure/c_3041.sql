

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/C_3041.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure C_3041 ***

  CREATE OR REPLACE PROCEDURE BARS.C_3041 ( p_kf varchar2) is 
   NEW3 accounts%rowtype; 
   oo oper%rowtype    ; l_dazs date;
begin 
   If p_kf is not null then bc.go( p_KF) ; end if;  If gl.AMFO <> '300465' then RETURN; end if;
   l_dazs  := DAT_NEXT_U( gl.bdate, 1) ;  
   oo.tt   := '024'  ;  
   oo.nd   := '13/1-07/20' ;  
   oo.nazn := 'Згорнення рах 62** відповідно до змін в плані рах.НБУ'; 
 
   --Сначала откроем и заменим 
   for OLD3 in (select * from accounts where nbs in ('3540', '3640', '3041', '3351') and dazs is null )
   loop
      If    OLD3.nbs='3540' and OLD3.ob22 = '03' then NEW3.nbs := '3043' ; NEW3.ob22:= '03'; -- 03 - за валютними операціями на умовах своп валютний (короткий);
      ElsIf OLD3.nbs='3640' and OLD3.ob22 = '03' then NEW3.nbs := '3353' ; NEW3.ob22:= '03'; -- 03 - за валютними операціями на умовах своп валютний (короткий);
      ElsIf OLD3.nbs='3041' and OLD3.ob22 = '02' then NEW3.nbs := '3043' ; NEW3.ob22:= '01'; -- 01 - за валютними операціями на умовах своп валютний (довгий);
      ElsIf OLD3.nbs='3351' and OLD3.ob22 = '02' then NEW3.nbs := '3353' ; NEW3.ob22:= '01'; -- 01 - за валютними операціями на умовах своп валютний (довгий);
      ------------------------------------------------------------------------------
      else  goto HET_;
      end if; 
/*
№ 3043 "Активи за валютними своп-контрактами, що оцінюються за справедливою вартістю через прибутки/збитки":
01 - за валютними операціями на умовах своп валютний (довгий);
02 - за валютними операціями на умовах "депо-своп" (довгий);;
03 - за валютними операціями на умовах своп валютний (короткий);
04 - за валютними операціями на умовах "депо-своп" (короткий).

№ 3353 "Зобов`язання за валютними своп-контрактами, що оцінюються за справедливою вартістю через прибутки/збитки":
01 - за валютними операціями на умовах своп валютний (довгий);;
02 - за валютними операціями на умовах "депо-своп" (довгий);;
03 - за валютними операціями на умовах своп валютний (короткий);
04 - за валютними операціями на умовах "депо-своп" (короткий).
*/

      begin select * into NEW3 from accounts where kv = OLD3.KV and nbs = NEW3.NBS and ob22 = NEW3.ob22 and dazs is null and rnk = OLD3.rnk and rownum=1;
      exception when no_data_found then    
         NEW3.acc  := FOREX.open_accF (OLD3.rnk, NEW3.NBS, OLD3.KV);
         accreg.setAccountSParam(NEW3.acc, 'OB22', NEW3.ob22 );
         begin select * into NEW3 from accounts where acc = NEW3.acc;
         exception when no_data_found then goto HET_;
         end ;
      end;

      If OLD3.ostc <> 0 then --          -- перебросить остаток
         oo.nam_a := substr(OLD3.nms,1,38);         oo.nlsa  := OLD3.nls ;
         oo.nam_b := substr(new3.nms,1,38);         oo.nlsb  := NEW3.nls ;

         If OLD3.ostc > 0 then oo.dk := 1 ; oo.s :=   OLD3.ostc;
         else                  oo.dk := 0 ; oo.s := - OLD3.ostc;
         end if;

         -- отключить режим отложенной оплаты
         update accounts set opt = 0 where acc= OLD3.acc and opt=1;

         gl.ref (oo.REF);
         gl.in_doc3
               (ref_=> oo.REF,  tt_ => oo.tt   , vob_=> 6   , nd_ => oo.nd ,
               pdat_=>SYSDATE, vdat_=> gl.bdate, dk_ =>oo.dk, kv_ => OLD3.kv ,
               s_   => oo.S  , kv2_ => OLD3.kv   , s2_ =>oo.S ,sk_  => null , 
               data_=> gl.BDATE, datp_=>gl.bdate,
               nam_a_ => oo.nam_a, nlsa_  => oo.nlsA, mfoa_ => gl.aMfo ,
               nam_b_ => oo.nam_b, nlsb_  => oo.nlsb, mfob_ => gl.aMfo ,
               nazn_  => oo.nazn , d_rec_ => null   , id_a_ => gl.aOkpo,
               id_b_  => gl.aOkpo, id_o_  => null   , sign_ => null    ,  
               sos_   => 1,         prty_ => null   , uid_  => null )  ;
         gl.payv(0, oo.ref, gl.bdate, oo.tt , oo.dk, OLD3.kv, oo.nlsa, oo.s, OLD3.kv, oo.nlsb, oo.s );
         gl.pay (2, oo.ref, gl.bdate); 
      end if; 
      -- и закрыть
      update accounts set dazs = l_dazs where acc = OLD3.acc;
      Update accounts set tobo    = OLD3.branch where acc = new3.acc ;
      -------------------
     <<HET_>> null;
   end loop;
end c_3041;
/
show err;

PROMPT *** Create  grants  C_3041 ***
grant EXECUTE                                                                on C_3041          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/C_3041.sql =========*** End *** ==
PROMPT ===================================================================================== 
