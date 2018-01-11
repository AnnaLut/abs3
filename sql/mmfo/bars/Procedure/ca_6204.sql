

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CA_6204.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CA_6204 ***

  CREATE OR REPLACE PROCEDURE BARS.CA_6204 ( p_kf varchar2) is 
   -- 06.07.2017 Только для ЦА
   ---Зміни в плані рах  по 6204 (в Матриці) 
   n6 accounts%rowtype;   oo oper%rowtype ;   l_dazs  date ; p4_ int;
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------
begin 
   If p_kf is not  null  then bc.go( p_KF) ; end if ;   If gl.aMfo <> '300465' then  RETURN      ; end if ;

    -- рекомендации  от Миши2
   for k  in (select * from accounts where nbs = '6204'  and dazs  is null  and daos < gl.Bdate  )
   loop update accounts set opt = 0 where acc = k.acc; end loop;
   gl.paysos0;
   ----------------------

   l_dazs := DAT_NEXT_U( gl.bdate, 1) ;  
   oo.tt   := '024'  ;  
   oo.nd   := '13/1-07/20' ;  
   oo.nazn := 'Згорнення рах 6*** відповідно до змін в плані рах.НБУ'; 

   for o6 in (select * from accounts where nbs in ( '6204' , '6209' ) and NVL(dazs, l_dazs) >= l_dazs) 
   loop

      If    o6.nbs = '6204' and o6.ob22 = '05' then n6.nbs := '6214' ; n6.ob22 := '01'; --6204'05     6214'01 – РКР для простые М/В операции с вал
      ElsIf o6.nbs = '6204' and o6.ob22 = '06' then n6.nbs := '6214' ; n6.ob22 := '02'; --6204'06     6214'02 – РКР для простые М/В операции с БМ
      ElsIf o6.nbs = '6204' and o6.ob22 = '07' then n6.nbs := '6214' ; n6.ob22 := '03'; --6204'07     6214'03 – НКР для простые М/В операции с БМ
      ElsIf o6.nbs = '6204' and o6.ob22 = '08' then n6.nbs := '6214' ; n6.ob22 := '04'; --6204'08     6214'04 – НКР для простые М/В операции с вал
      ElsIf o6.nbs = '6204' and o6.ob22 = '19' then n6.nbs := '6214' ; n6.ob22 := '05'; --6204/19     6214/05--\ РКР для 3800/25 SPOT
      ElsIf o6.nbs = '6204' and o6.ob22 = '20' then n6.nbs := '6214' ; n6.ob22 := '06'; --6204/20     6214/06--/ НКР для 3800/25 SPOT
      ElsIf o6.nbs = '6204' and o6.ob22 = '21' then n6.nbs := '6214' ; n6.ob22 := '07'; --6204'21     6214'07--\ РКР для …  
      ElsIf o6.nbs = '6204' and o6.ob22 = '22' then n6.nbs := '6214' ; n6.ob22 := '08'; --6204'22     6214'08--/ НКР для …  
      ElsIf o6.nbs = '6204' and o6.ob22 = '28' then n6.nbs := '6214' ; n6.ob22 := '09'; --6204'28     6214'09--\ НКР для 3800/28
      ElsIf o6.nbs = '6204' and o6.ob22 = '29' then n6.nbs := '6214' ; n6.ob22 := '10'; --6204'29     6214'10--/ РКР для 3800/28
      -------------------------------------------------------------------------------
      ElsIf o6.nbs = '6209' and o6.ob22 = '05' then n6.nbs := '6216' ; n6.ob22 := '01'; --6209/05 6216/01 --\ РКР для 3800/26 FORWARD
      ElsIf o6.nbs = '6209' and o6.ob22 = '06' then n6.nbs := '6216' ; n6.ob22 := '02'; --6209/06 6216/02 --/ НКР для 3800/25 FORWARD
      ElsIf o6.nbs = '6209' and o6.ob22 = '04' then n6.nbs := '6206' ; n6.ob22 := '01'; --6209/04 6206/01 -- ДО СПР.стоимости FORWARD
      ElsIf o6.nbs = '6209' and o6.ob22 = '07' then n6.nbs := '6205' ; n6.ob22 := '01';
      ElsIf o6.nbs = '6209' and o6.ob22 = '08' then n6.nbs := '6215' ; n6.ob22 := '01';
      else  goto HET_ ; --                          n6.nbs := ob.nbs ; n6.ob22 :=  o6.ob22 ;
      end if; 

      begin select * into n6 from accounts where kv=o6.KV and NBS=n6.nbs and ob22=n6.ob22 and branch = o6.BRANCH and acc <> o6.acc;
            if n6.dazs is not null then  update accounts set dazs = null where acc = n6.acc ; end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN 
            n6.nls := n6.nbs||'_00'||n6.ob22||'01'||substr(o6.branch, 12,3) ;
            n6.nls := VKRZN( substr(gl.aMfo,1,5), n6.nls );
            op_reg (99,0,0, o6.GRP, p4_, o6.RNK, n6.NLS, o6.kv , o6.nms, o6.tip, o6.isp, n6.ACC);
            update accounts set tobo = o6.branch where acc = n6.acc ; 
            Accreg.setAccountSParam( n6.Acc, 'OB22', n6.ob22 ) ;  
            select * into n6 from accounts where acc = n6.acc  ;
      end;
      update accounts set dazs = l_dazs where acc = o6.acc;

      If o6.ostc <> 0  then    -- перебросить остаток
         oo.nam_a := substr(o6.nms,1,38);  oo.nlsa  :=   o6.nls  ;
         oo.nam_b := substr(n6.nms,1,38);  oo.nlsb  :=   n6.nls  ;
         If o6.ostc > 0 then oo.dk := 1 ;  oo.s     :=   o6.ostc ;
         else                oo.dk := 0 ;  oo.s     := - o6.ostc ;
         end if;
         gl.ref (oo.REF);
         gl.in_doc3
            (ref_=> oo.REF, tt_=> oo.tt, vob_=> 6   , nd_=> oo.nd, pdat_=>SYSDATE,  vdat_=>gl.bdate, dk_ =>oo.dk, kv_ => o6.kv ,
            s_   => oo.S  ,kv2_=> o6.kv, s2_ =>oo.S ,sk_ => null , data_=>gl.BDATE, datp_=>gl.bdate,
            nam_a_=> oo.nam_a, nlsa_ => oo.nlsA, mfoa_=> gl.aMfo , nam_b_=> oo.nam_b, nlsb_=> oo.nlsb, mfob_=> gl.aMfo,
            nazn_ => oo.nazn , d_rec_=> null   , id_a_=> gl.aOkpo, id_b_ => gl.aOkpo, id_o_=> null   , sign_=> null   , sos_ => 1, prty_ => null, uid_ =>1);
         gl.payv(0, oo.ref, gl.bdate, oo.tt , oo.dk, o6.kv, oo.nlsa, oo.s, o6.kv, oo.nlsb, oo.s );
         gl.pay (2, oo.ref, gl.bdate); 
         update accounts set dazs = l_dazs where acc = o6.acc;
      end if; 

      update  vp_list set acc_rrr = n6.acc , acc_rrd = n6.acc  where acc_rrr = o6.acc ;
      update  vp_list set acc_rrS = n6.acc                     where acc_rrS = o6.acc ;
      update accounts set opt = 1 where acc = n6.acc ;
     << HET_>> null;
   end loop ;   -- o6

end CA_6204;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CA_6204.sql =========*** End *** =
PROMPT ===================================================================================== 
