

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/C_3800.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure C_3800 ***

  CREATE OR REPLACE PROCEDURE BARS.C_3800 ( p_kf varchar2) is 
     --1)     21.06.2017 Згорнення  Вал.поз на рівень МФО
     oo oper%rowtype;      
     l_dazs  date ; 
     l_Br1   varchar2(15) ;  
     l_Br2   varchar2(15) ;  
     OW_3800 varchar2(15) ;  

begin 
     If p_kf is not null   then  bc.go( p_KF) ; end if;
     If gl.aMfo = '300465' then  raise_application_error(-20203, 'Недопустимо для 300465' );  end if;

     if gl.aMfo = '322669' then gl.aUid := 5611; end if;

     l_Br1 := '/'|| gl.aMfo||'/';
     l_Br2 := '/'|| gl.aMfo||'/000000/';
     l_dazs  := DAT_NEXT_U( gl.bdate, 1) ;  
     oo.tt   := '024'  ;  
     oo.nd   := 'CL_3800' ;  
     oo.nazn := 'Згорнення однотипних Вал.поз на рівень МФО'; 


     -------------------------------------------------------------------
     --Знайти пар.для ПЦ
     begin select val into OW_3800 from OW_params where par = 'NLS_3800';
     EXCEPTION WHEN NO_DATA_FOUND THEN OW_3800 :='1';
     end ;

     -- підняти наверх все рах вал.поз з /мммммм/000000/ на /мммммм/ або вішалки
     for H in (select * from accounts  where nbs in ('3800','3801','6204') 
                  and dazs is null 
                  and (branch = l_Br2  or tip ='VE1' OR nls = OW_3800 )  )
     loop update accounts set tobo   = l_br1 where acc = H.acc ; 
          update spot     set branch = l_br1 where acc = H.acc ; 
     end  loop;
     --------------------------------------------------------------------

     -- рекомендации  от Миши2
     for k in (select * from accounts 
              where nbs in ('6204', '3800','3801')  and opt = 1 
               and dazs is null 
               and branch <> l_Br1    )

     loop update accounts set opt = 0 where acc = k.acc; end loop;
     gl.paysos0;
     ----------------------------------------------------------------

     --перекинути всі залишки та зактири всі решту рахунків.
     for k in (select * from accounts  where nbs in ('3800','3801','6204') 
                  and (dazs is null or dazs > gl.bdate) 
                  and branch <> l_Br1    )
     loop 
       begin -- найти замену наверху
          select substr(nms,1,38), nls into oo.nam_b, oo.nlsb  from accounts 
          where nbs=k.nbs and ob22=k.ob22 and kv=k.kv and dazs is null and branch=l_Br1 and rownum=1 ;

          If k.ostc = 0 then -- просто закрыть
             update accounts set dazs = l_dazs where acc = k.acc;
          else 
             oo.nam_a := substr(k.nms,1,38);
             oo.nlsa  := k.nls ;
             If k.ostc > 0 then oo.dk := 1 ; oo.s :=   k.ostc;
             else               oo.dk := 0 ; oo.s := - k.ostc;
             end if;
             -- отключить режим отложенной оплаты
---          update accounts set opt = 0 where acc= k.acc and opt=1;
             -- перебросить остаток
             gl.ref (oo.REF);
             gl.in_doc3
               (ref_=> oo.REF,  tt_ => oo.tt   , vob_=> 6   , nd_ =>oo.nd ,
               pdat_=>SYSDATE, vdat_=> gl.bdate, dk_ =>oo.dk, kv_ => k.kv ,
               s_   => oo.S  , kv2_ => k.kv    , s2_ =>oo.S ,sk_  => null , 
               data_=> gl.BDATE, datp_=>gl.bdate,
               nam_a_ => oo.nam_a, nlsa_  => oo.nlsA, mfoa_ => gl.aMfo ,
               nam_b_ => oo.nam_b, nlsb_  => oo.nlsb, mfob_ => gl.aMfo ,
               nazn_  => oo.nazn , d_rec_ => null   , id_a_ => gl.aOkpo,
               id_b_  => gl.aOkpo, id_o_  => null   , sign_ => null    ,  
               sos_   => 1,         prty_ => null   , uid_  => null );
             gl.payv(0, oo.ref, gl.bdate, oo.tt , oo.dk, k.kv, oo.nlsa, oo.s, k.kv, oo.nlsb, oo.s );
             gl.pay (2, oo.ref, gl.bdate); 
             -- и закрыть
             update accounts set dazs = l_dazs where acc = k.acc;
          end if; 
       EXCEPTION WHEN NO_DATA_FOUND THEN 
          -- если нет замены - поднять наверх
          update accounts set tobo   = l_br1 where acc = k.acc ;
          update spot     set branch = l_br1 where acc = k.acc ; 
       end ;
   end loop ;

end c_3800 ;
/
show err;

PROMPT *** Create  grants  C_3800 ***
grant EXECUTE                                                                on C_3800          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/C_3800.sql =========*** End *** ==
PROMPT ===================================================================================== 
