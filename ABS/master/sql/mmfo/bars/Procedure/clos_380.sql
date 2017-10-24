

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CLOS_380.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CLOS_380 ***

  CREATE OR REPLACE PROCEDURE BARS.CLOS_380 
 (Mod_ int,
  ob1 char  DEFAULT NULL,
  ob2 char  DEFAULT NULL,
  ob3 char  DEFAULT NULL,
  ob4 char  DEFAULT NULL
  )  IS

/*
  09.10.2016 испр ош.
  17.02.2016 Сухова.
     Разные манипуляции со счетами вал поз
     Посл.заявка COBUSUPABS-4272 = Згортання залишків 3800(між ОБ22-24 та ОБ22-27 - операції СВОП).
     exec clos_380 ( Mod_ =>3,  ob1 =>'27',  ob2 =>'27',    ob3 =>'24',    ob4 => '24' ); 
*/

 oo oper%rowtype;    
 aa accounts%rowtype;

 FV_OB char(2) ; -- From для вал  
 FM_OB char(2) ; -- From для БМ 
 TV_OB char(2) ; -- To   для вал
 TM_OB char(2) ; -- To   для БМ

 aaF accounts%rowtype;
 aaT accounts%rowtype;

BEGIN

 If mod_ = 3 then  -- перекрытие вал поз путем переброски остатков без получения 6204.

/*
    FV_OB := nvl( ob1, '03');   -- From для вал
    FM_OB := nvl( ob2, '03');   -- From для БМ 
    TV_OB := nvl( ob3, '10');   -- To   для вал
    TM_OB := nvl( ob4, '09');   -- To   для БМ 

*/


    FV_OB :=  ob1 ;   -- From для вал
    FM_OB :=  ob2 ;   -- From для БМ 
    TV_OB :=  ob3 ;   -- To   для вал
    TM_OB :=  ob4 ;   -- To   для БМ 

    If ob1 is null or    ob2 is null or   ob3 is null or  ob4 is null then 
      raise_application_error(-20333, '  - Не Задан всi вхідні параметри',TRUE);
    end if ;

    -- Згорнення 3800/3801
    if to_char (gl.bdate, 'mm') = '01' then  oo.vob := 96;
       select max(fdat) into oo.vdat   from fdat where fdat < trunc(gl.bdate,'MM');
    else                     oo.vdat := gl.bdate; oo.vob :=  6;
    end if;

   for F in (select a.nls NLS_3800, a.ostb OST_3800, a.OB22, a.branch, a.KV, substr(a.nms,1,38) NMS_3800,
                    b.nls NLS_3801, b.ostb OST_3801
             from accounts a, vp_list v , accounts b
             where a.nbs ='3800' and a.acc = v.acc3800 and v.acc3801 = b.acc and a.ostB <> 0 and b.kv = gl.baseval 
                and a.ob22 = CASE WHEN a.KV in (959,961,962) THEN FM_OB else FV_OB end             )
   loop
      for T in (select a.nls NLS_3800, substr(a.nms,1,38) NMS_3800,  b.nls NLS_3801, a.ob22
                from accounts a, vp_list v , accounts b
                where a.nbs ='3800' and a.acc = v.acc3800 and v.acc3801 = b.acc and a.dazs is null
                   and a.branch = F.branch and a.kv = F.kv and rownum = 1  and b.kv = gl.baseval 
                   and a.ob22 = CASE WHEN a.KV in (959,961,962) THEN TM_OB else TV_OB end           )
      loop
         oo.s  := abs(F.ost_3800);
         oo.s2 := abs(F.ost_3801);
         if F.ost_3800 > 0 then oo.dk := 1   ; else  oo.dk :=0 ;   end if;
 
         gl.ref (oo.REF);
         oo.nd   := substr(to_char(oo.ref),1,10); 
         oo.nazn := 'Згорнення 3800/3801 (' || F.ob22 || ') на 3800/3801 (' || T.ob22 || ')' ;
         gl.in_doc3(oo.REF, 'PS1', oo.vob , oo.nd, SYSDATE, oo.vdat, oo.dk, F.kv, oo.s, F.kv, oo.s, null, gl.BDATE, gl.bdate,
                     F.nms_3800, F.nls_3800, gl.aMfo , 
                     T.nms_3800, T.nls_3800, gl.aMfo , 
                     oo.nazn , null   , gl.aOkpo, gl.aOkpo, null, null, 1,null, null  );
        gl.payv(0,oo.REF, oo.vdat,'PS1', oo.dk, F.kv,       F.nls_3800, oo.s , F.kv,       T.nls_3800, oo.s  ) ;
        gl.payv(0,oo.REF, oo.vdat,'PS1', oo.dk, gl.baseval, T.nls_3801, oo.s2, gl.baseval, F.nls_3801, oo.s2 ) ;
        gl.pay (2,oo.REF, gl.bDATE);
        -----------------------------------------
      end loop; -- TO
   end loop;  -- FROM
   RETURN;
end if;
-------
 oo.tt  := '38V';
 oo.sk  :=  null;
 oo.vob :=  16  ;

--==============================================================
if mod_ = 0 and length(ob1)=2 and length(ob2)=2 then
----------------------------------------------------
  for k in (select a.ob22,a.branch,a.kv,a.nls,a.ostc,substr(a.nms,1,38) nms
            from accounts a   where a.nbs='3800' and a.ob22=ob1 and a.ostc<>0 and a.ostc=a.ostb   )
  loop
     begin
       select a.nls, Substr(a.nms,1,38),  b.nls, Substr(b.nms,1,38) into oo.Nlsa, oo.Nam_a, oo.Nlsb, oo.nam_b
       from accounts a, accounts b
       where a.kv=k.kv and a.nbs = '3739' and a.ob22='06'  and b.kv=980  and b.nbs = '3739' and b.ob22='06'
         and a.dazs is null and b.dazs is null and rownum=1;
     EXCEPTION when NO_DATA_FOUND THEN   raise_application_error(-20333, '  - Не вiдкрито рах. 3739/06',TRUE);
     end;
     ---------------------------
     If k.ostc >0 then     oo.dk := 0;      else  oo.dk := 1;      end if;
     oo.S  := abs(k.ostc);
     oo.s2 := gl.p_icurval(k.kv, oo.s, gl.bdate);
     ---------------------------
     PUL.Set_Mas_Ini( 'VP', k.NLS, 'Вал.Поз.' );
     GL.REF (oo.REF);
     GL.IN_DOC3 (oo.REF, oo.TT, oo.vob, oo.ref, SYSDATE, GL.BDATE,  oo.dk,  K.KV, oo.S, 980, oo.s2, oo.sk, GL.BDATE,GL.BDATE,
                 oo.nam_a,oo.nlsa,gl.AMFO, oo.nam_b,oo.nlsb, gl.AMFO,
                'Передача Вал.Поз.'||k.ob22||' зг.листа № 16/5-27/8142 вiд 04.12.2009',
                 NULL,null,null,null, null,0,null, 20094 );
     GL.PAYV(0,oo.REF, GL.BDATE, oo.TT, oo.dk, k.kv, oo.nlsa, oo.s, 980, oo.NLSb, oo.s2);
     GL.PAY( 2,oo.REF, GL.BDATE);
     ---------------------------
     if length(k.branch) = 8 then  oo.branch:= k.branch || '000000/';
     else                          oo.branch:= k.branch ;
     end if;
     aa.nls   := nbs_ob22_null('3800', ob2, oo.branch);
     PUL.Set_Mas_Ini( 'VP', aa.NLS, 'Вал.Поз.' );
     oo.ref := null;
     GL.REF (oo.REF);
     GL.IN_DOC3 (oo.REF, oo.TT, oo.vob, oo.REF, SYSDATE, GL.BDATE, 1-oo.dk, K.KV ,oo.S, 980, oo.s2, oo.sk, GL.BDATE,GL.BDATE,
                 oo.nam_a, oo.NLSa, gl.AMFO, oo.nam_b, oo.nlsb, gl.AMFO,
                'Прийом Вал.Поз.'||k.ob22||  ' зг.листа № 16/5-27/8142 вiд 04.12.2009',
                 NULL,null,null,null, null,0,null, 20094 );
     GL.PAYV(0, oo.REF, GL.BDATE , oo.TT, 1-oo.dk, k.kv, oo.NLSa, oo.s, 980, oo.NLSb, oo.s2 );
     GL.PAY( 2, oo.REF, GL.BDATE );
     ----------------------------
  end loop;

--==============================================================
elsif mod_ = 1 and (length(ob1)=2 or length(ob2)=2 or length(ob3)=2 or length(ob3)=2) then
--==============================================================

  for k in (select a.acc, dazs from accounts a  where a.nbs='3800'
               and a.ob22 in ( nvl(ob1,'**'), nvl(ob2,'**'), nvl(ob3,'**'), nvl(ob4,'**'))  and a.ostc=0 and a.ostc=a.ostb )
  loop
     if k.dazs is null then
        update accounts set dazs = gl.bdate+1 where acc=k.acc;
     end if;

     begin
        select a.* into aa from vp_list V , accounts a  where  v.acc3800 = k.ACC and v.acc3801=a.acc  and  a.ostc=0 and a.ostb=0;

        if aa.dazs is null then
           update accounts set dazs=gl.bdate+1 where acc=aa.acc;
        end if;

        delete from vp_list where acc3800=k.acc;

     EXCEPTION when NO_DATA_FOUND THEN null;
     end;
  end loop;

end if;

  suda;

   return;

end clos_380;
/
show err;

PROMPT *** Create  grants  CLOS_380 ***
grant EXECUTE                                                                on CLOS_380        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CLOS_380        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CLOS_380.sql =========*** End *** 
PROMPT ===================================================================================== 
