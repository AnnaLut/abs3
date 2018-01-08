

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/C_6204.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure C_6204 ***

  CREATE OR REPLACE PROCEDURE BARS.C_6204 ( p_kf varchar2) is 
   -- 29.06.2017 Только для РУ
   --- 2)   01.07.2017 Зміни в плані рах  по 6204 (в Матриці) 
   a38 accounts%rowtype;    n6 accounts%rowtype;   oo oper%rowtype ;
   l_br0 varchar2(8);
   l_dazs  date ;
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure OPA  ( p_3800_ob22 varchar2,  p_NBS_PER varchar2,  p_OB_PER varchar2, 
                                           p_NBS_NKR varchar2,  p_OB_NKR varchar2, 
                                           p_NBS_RKR varchar2,  p_OB_RKR varchar2 ) IS
                    l_acc_PER   number ;  
                    l_acc_NKR   number ;  
                    l_acc_RKR   number ;  
       ------------------------------------------------------------------------------------------------------------------------------------------------------------
       procedure ox ( p_3800_ob22 varchar2,  p_NBS_6204 varchar2,  p_ob22_6204 varchar2,  p_nam_6204 varchar2,  
                      R_ACC_6204  OUT number ) is 
             a62 accounts%rowtype;  
       begin a62.nls := VKRZN(substr( gl.aMfo,1,5), p_NBS_6204 || '_0' || p_ob22_6204 );
             a62.nms := p_NAM_6204 || ' вал.поз.3800/'|| p_3800_ob22 ;    
             op_reg (99,0,0, a38.GRP, a62.opt, a38.RNK, a62.NLS, 980, a62.nms, 'ODB', a38.isp, R_acc_6204 );
             Accreg.setAccountSParam ( R_acc_6204, 'OB22', p_ob22_6204  )  ;

             update accounts set tobo = l_br0 , dazs = NULL where acc = R_acc_6204 and (branch <>l_br0  OR  dazs is not null); 
       end ox; 
       -----------------------------------------------------------------------------------------------------------------------------------------------------------

   begin   ox ( p_3800_ob22, p_NBS_PER, p_ob_PER, 'Переоц.до оф.курсу', l_acc_PER );

      If        p_3800_ob22  in ('16','03') then                      l_acc_NKR := l_acc_PER ;          l_acc_RKR := l_acc_PER  ;
      Else ox ( p_3800_ob22, p_NBS_NKR, p_ob_NKR, 'НЕреаліз.результат', l_acc_NKR );
           ox ( p_3800_ob22, p_NBS_RKR, p_ob_RKR, 'Реалізов.результат', l_acc_RKR );
      end if;

      update vp_list V set V.acc6204 = l_acc_PER, V.acc_rrd = l_acc_NKR, V.acc_rrr = l_acc_NKR, V.acc_rrs = l_acc_RKR  
             where exists 
                 (select 1 from accounts a where a.acc = V.acc3800 and a.dazs is null and a.ob22 = p_3800_ob22 and a.nbs = '3800') ;

   end OPA;
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------

begin 
   If p_kf is not  null  then bc.go( p_KF) ; end if ;
   If gl.aMfo = '300465' then  RETURN      ; end if ;
   if gl.aMfo = '322669' then gl.aUid := 5611; end if;

   l_br0   := '/'|| gl.aMfo||'/';


   -- Открытие всех новых 6204
   -- Для РНК. исп, грп и т.д.
   select * into a38 from accounts where nbs='3800' and dazs is null and rownum = 1;
   ---------------------------------------------------------------------------------
   OPA ( p_3800_ob22=>'16',  p_NBS_PER=>'6204', p_OB_PER=>'17',   p_NBS_NKR=>'6204', p_OB_NKR=>'17',   p_NBS_RKR=>'6204', p_OB_RKR=>'17' ); -----------резервы рах.3800/16
   OPA ( p_3800_ob22=>'03',  p_NBS_PER=>'6204', p_OB_PER=>'24',   p_NBS_NKR=>'6204', p_OB_NKR=>'24',   p_NBS_RKR=>'6204', p_OB_RKR=>'24' ); -----------совств поз рах.3800/03
   OPA ( p_3800_ob22=>'10',  p_NBS_PER=>'6204', p_OB_PER=>'01',   p_NBS_NKR=>'6214', p_OB_NKR=>'04',   p_NBS_RKR=>'6214', p_OB_RKR=>'01' ); -----------Бизнес-поз по ВАЛ рах.3800/10
   OPA ( p_3800_ob22=>'09',  p_NBS_PER=>'6204', p_OB_PER=>'15',   p_NBS_NKR=>'6214', p_OB_NKR=>'03',   p_NBS_RKR=>'6214', p_OB_RKR=>'02' ); -----------Бизнес-поз по БМ  рах.3800/09
   OPA ( p_3800_ob22=>'28',  p_NBS_PER=>'6204', p_OB_PER=>'27',   p_NBS_NKR=>'6214', p_OB_NKR=>'09',   p_NBS_RKR=>'6214', p_OB_RKR=>'10' ); -----------Бизнес-поз по БМ  рах.3800/28 (для погашений задолж.банку)

   l_dazs := DAT_NEXT_U( gl.bdate, 1) ;  
   oo.tt   := '024'  ;  
   oo.nd   := 'CL_62**' ;  
   oo.nazn := 'Згорнення рах 62** відповідно до змін в плані рах.НБУ'; 

     -- рекомендации  от Миши2
   for k  in (select * from accounts where nbs = '6204' ----and ob22 in ('08','07','28','05','06','29')
                 and dazs  is null   and ( nls not like '6204_0__'  or branch <>l_br0 )       )
   loop update accounts set opt = 0 where acc = k.acc; end loop;
   gl.paysos0;



   for o6 in (select * from accounts where nbs = '6204' ----and ob22 in ('08','07','28','05','06','29')
                 and dazs  is null   
                 and ( nls not like '6204_0__'  or branch <>l_br0 ) 
            )
   loop

      If o6.ostc <> 0  then    -- перебросить остаток

         If    o6.ob22 = '05' then n6.nbs := '6214' ; n6.ob22 := '01'; --6204'05     6214'01 – РКР для простые М/В операции с вал
         ElsIf o6.ob22 = '06' then n6.nbs := '6214' ; n6.ob22 := '02'; --6204'06     6214'02 – РКР для простые М/В операции с БМ
         ElsIf o6.ob22 = '07' then n6.nbs := '6214' ; n6.ob22 := '03'; --6204'07     6214'03 – НКР для простые М/В операции с БМ
         ElsIf o6.ob22 = '08' then n6.nbs := '6214' ; n6.ob22 := '04'; --6204'08     6214'04 – НКР для простые М/В операции с вал
         ElsIf o6.ob22 = '28' then n6.nbs := '6214' ; n6.ob22 := '09'; --6204'28     6214'09--\ НКР для 3800/28
         ElsIf o6.ob22 = '29' then n6.nbs := '6214' ; n6.ob22 := '10'; --6204'29     6214'10--/ РКР для 3800/28
--       ElsIf o6.ob22 = '21' then n6.nbs := '6214' ; n6.ob22 := '07'; --6204'21     6214'07--\ РКР для …  
--       ElsIf o6.ob22 = '22' then n6.nbs := '6214' ; n6.ob22 := '08'; --6204'22     6214'08--/ НКР для …  
--       ElsIf o6.ob22 = '19' then n6.nbs := '6214' ; n6.ob22 := '05'; --6204/19     6214/05--\ РКР для 3800/25 SPOT
--       ElsIf o6.ob22 = '20' then n6.nbs := '6214' ; n6.ob22 := '06'; --6204/20     6214/06--/ НКР для 3800/25 SPOT
         else                      n6.nbs := o6.nbs ; n6.ob22 :=  o6.ob22 ;
         end if; 

         begin select * into n6 from accounts where kv = 980 and nls like n6.nbs||'_0'||n6.ob22 and dazs is null and branch = l_br0 and acc <> o6.acc;
            oo.nam_a := substr(o6.nms,1,38);  oo.nlsa  :=   o6.nls  ;
            oo.nam_b := substr(n6.nms,1,38);  oo.nlsb  :=   n6.nls  ;
            If o6.ostc > 0 then oo.dk := 1 ;  oo.s     :=   o6.ostc ;
            else                oo.dk := 0 ;  oo.s     := - o6.ostc ;
            end if;
            -- отключить режим отложенной оплаты
            ---update accounts set opt = 0 where acc= o6.acc and opt=1 ;
            gl.ref (oo.REF);
            gl.in_doc3
               (ref_=> oo.REF, tt_=> oo.tt, vob_=> 6   , nd_=> oo.nd, pdat_=>SYSDATE,  vdat_=>gl.bdate, dk_ =>oo.dk, kv_ => o6.kv ,
               s_   => oo.S  ,kv2_=> o6.kv, s2_ =>oo.S ,sk_ => null , data_=>gl.BDATE, datp_=>gl.bdate,
               nam_a_=> oo.nam_a, nlsa_ => oo.nlsA, mfoa_=> gl.aMfo , nam_b_=> oo.nam_b, nlsb_=> oo.nlsb, mfob_=> gl.aMfo,
               nazn_ => oo.nazn , d_rec_=> null   , id_a_=> gl.aOkpo, id_b_ => gl.aOkpo, id_o_=> null   , sign_=> null   , sos_ => 1, prty_ => null, uid_ =>null );
            gl.payv(0, oo.ref, gl.bdate, oo.tt , oo.dk, o6.kv, oo.nlsa, oo.s, o6.kv, oo.nlsb, oo.s );
            gl.pay (2, oo.ref, gl.bdate); 
            update accounts set dazs = l_dazs where acc = o6.acc;
         EXCEPTION WHEN NO_DATA_FOUND THEN null ;
         end;
      else
         update accounts set dazs = l_dazs where acc = o6.acc;
      end if; 
   end loop ;   -- k

   -- поднять наверх и реанимировать 
    If gl.aMfo <> '300465' then 
      l_br0 := '/'|| gl.aMfo||'/';

      for X in (select  v.* from vp_list v, accounts a,accounts b, accounts c, accounts d,accounts e
                where v.acc3800 = a.acc  and v.acc3801 = b.acc and v.acc6204 = c.acc
                  and v.acc_rrr = d.acc  and v.acc_rrs = e.acc and a.nbs = '3800' and A.DAZS is null
                 )
      loop
        update accounts set tobo = l_br0              where acc = x.acc3800 and  branch <> l_br0 ;
        update accounts set tobo = l_br0, dazs = null where acc = x.acc3801 and (branch <> l_br0 or dazs is not null) ;
        update accounts set tobo = l_br0, dazs = null where acc = x.acc6204 and (branch <> l_br0 or dazs is not null) ;
        update accounts set tobo = l_br0, dazs = null where acc = x.acc_rrr and (branch <> l_br0 or dazs is not null) ;
        update accounts set tobo = l_br0, dazs = null where acc = x.acc_rrs and (branch <> l_br0 or dazs is not null) ;
      end loop;
   end if;

end c_6204;
/
show err;

PROMPT *** Create  grants  C_6204 ***
grant EXECUTE                                                                on C_6204          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/C_6204.sql =========*** End *** ==
PROMPT ===================================================================================== 
