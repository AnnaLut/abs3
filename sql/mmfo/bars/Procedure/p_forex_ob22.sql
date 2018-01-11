

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FOREX_OB22.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FOREX_OB22 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FOREX_OB22 ( p_kf varchar2) is 
  -- 3)   21.06.2017 Для 300465 - Зміни по ФОРЕКС
   a0 accounts%rowtype; 
   a1 accounts%rowtype; 
   bn accounts%rowtype;
   br accounts%rowtype;
   b9 accounts%rowtype;
   p4_ int;  
   oo oper%rowtype ; l_dazs date;
begin If p_kf is not null then bc.go( p_KF) ; end if;

   If gl.aMfo <> '300465' then   raise_application_error(-20203, 'Недопустимо для '||gl.aMfo );  end if;

   l_dazs  := DAT_NEXT_U( gl.bdate, 1) ;  

   -- Вставка новых вал.поз.
   for k in (select a.*, v.acc6204  from accounts a, vp_list v
             where a.acc= v.acc3800 and a.ob22 in ('24',  '27') and dazs is null
            )
   loop
      If k.ob22='24' then a0.ob22:='29'; bn.nbs:='6218'; bn.ob22:='07';  br.nbs:= '6218'; br.ob22:='08';  b9.nbs:='6208'; b9.ob22:='04';
      else                a0.ob22:='30'; bn.nbs:='6218'; bn.ob22:='03';  br.nbs:= '6218'; br.ob22:='04';  b9.nbs:='6208'; b9.ob22:='02';
      end if;

      a0.nls := VKRZN( substr( gl.aMfo,1,5) , '3800_0010'||a0.ob22 );
      op_reg( 99,0,0,k.grp,p4_,k.RNK, a0.nls, k.kv, k.nms, 'ODB', k.isp, a0.acc );

      a1.nls := vkrzn( Substr( gl.aMfo,1,5) , '3801_0010'||a0.ob22 || k.kv );
      op_reg( 99,0,0,k.grp,p4_,k.RNK, a1.nls, 980, 'ЕВП:'||k.nms, 'ODB', k.isp,a1.acc );
 
      bn.nls := VKRZN( substr( gl.aMfo,1,5) , bn.nbs||'_0010'||bn.ob22 );
      op_reg( 99,0,0,k.grp,p4_,k.RNK, bn.nls, 980, 'НКР:'||k.nms, 'ODB', k.isp, bn.acc );

      br.nls := VKRZN( substr( gl.aMfo,1,5) , br.nbs||'_0010'||br.ob22 );
      op_reg( 99,0,0,k.grp,p4_,k.RNK, br.nls, 980, 'PКР:'||k.nms, 'ODB', k.isp, br.acc );

      b9.nls := VKRZN( substr( gl.aMfo,1,5) , b9.nbs||'_0010'||b9.ob22 );
      op_reg( 99,0,0,k.grp,p4_,k.RNK, b9.nls, 980, Substr('Переоц.до спр.вар:'||k.nms,1,50),  'ODB', k.isp, b9.acc );

      Accreg.setAccountSParam ( a0.acc, 'OB22', a0.ob22 )  ;  
      Accreg.setAccountSParam ( a1.acc, 'OB22', a0.ob22 )  ;  
      Accreg.setAccountSParam ( bn.acc, 'OB22', bn.ob22 )  ;  
      Accreg.setAccountSParam ( br.acc, 'OB22', br.ob22 )  ;  
      Accreg.setAccountSParam ( b9.acc, 'OB22', b9.ob22 )  ;  


      update accounts set tobo = k.branch  where acc  = a0.acc;
      update accounts set tobo = k.branch  where acc  = a1.acc;
      update accounts set tobo = k.branch  where acc  = bn.acc;
      update accounts set tobo = k.branch  where acc  = br.acc;
      update accounts set tobo = k.branch  where acc  = b9.acc;

      --вставить в VP_LIST
      update vp_list set COMM = substr(a0.nms,1,30) , ACC3801 = a1.acc , ACC6204 = k.acc6204  , ACC_RRR = bn.acc , 
                         ACC_RRD = bn.acc           , ACC_RRS = br.acc    where ACC3800 = a0.acc ;
      if SQL%rowcount = 0 then  insert into vp_list ( ACC3800,COMM,ACC3801,ACC6204,ACC_RRR,ACC_RRD,ACC_RRS )
                                values (a0.acc, substr(a0.nms,1,30),  a1.acc, k.acc6204, bn.acc, bn.acc,br.acc);
      end if;
      update forex_ob22 set s62 = b9.nls where s38 = '3800/'|| a0.ob22 ;

   end loop; -- k

   -- обновление существующих
   for k in (select rowid RI, x.* from forex_ob22 x where s62 like '62__/__')
   loop
      b9.nbs  := substr(k.s62,1,4);
      b9.ob22 := substr(k.s62,6,2);
      begin select * into b9 from accounts where nbs = b9.nbs  and ob22 = b9.ob22 ;
         if b9.dazs is not null then
            update accounts set dazs = null where acc = b9.acc ;
         end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN 
         b9.nls := VKRZN( substr( gl.aMfo,1,5) , b9.nbs||'_0010'||b9.ob22 );
         op_reg( 99,0,0, 18, p4_, 101, b9.nls, 980, 'Переоц.до спр.вар.',  'ODB',21001, b9.acc );
--logger.info('ZZZ*'|| k.s38||'*'||k.s62||'*'|| b9.nbs||'*'|| b9.ob22||'*');
         Accreg.setAccountSParam ( b9.Acc, 'OB22', b9.ob22 )  ;  
      end;
      update forex_ob22 set s62 = b9.nls where rowid = k.RI ;
   end loop;

end p_forex_ob22 ;
/
show err;

PROMPT *** Create  grants  P_FOREX_OB22 ***
grant EXECUTE                                                                on P_FOREX_OB22    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FOREX_OB22.sql =========*** End 
PROMPT ===================================================================================== 
