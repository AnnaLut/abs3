

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CLOS_380_C.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CLOS_380_C ***

  CREATE OR REPLACE PROCEDURE BARS.CLOS_380_C 
 (Mod_ int,
  ob1 char  DEFAULT NULL,
  ob2 char  DEFAULT NULL,
  ob3 char  DEFAULT NULL,
  ob4 char  DEFAULT NULL
  )  IS
 -- 31.12.2014 STA БЕРУ ЗАЛИШКИ НА 31.12.201* З КОРР.ОБОРОТАМИ
 -- МОЖНА ВИКОНУВАТИ СКІЛЬКИ ТРЕБА РАЗ.

 oo oper%rowtype;
 aa accounts%rowtype;
 L_DAT01 DATE ;
 l_dat31 DATE ;

BEGIN

 If mod_ = 3 then
    -- Згорнення 3800/3801(03)
   if to_char(gl.bdate,'MM')='01' then oo.vob:=96; L_DAT01:= TRUNC(gl.bdate,'MM'); select max(fdat) into oo.vdat from fdat where fdat<trunc(gl.bdate,'MM');
   else                                oo.vob:= 6; L_DAT01:= LAST_DAY(gl.bdate)+1;                       oo.vdat := gl.bdate;
   end if;
   l_dat31 := Dat_last (L_dat01-4, L_dat01-1) ;

   for k in (select * from accounts a where a.nbs in ('3800','3801') and a.ob22='03' )
   loop
--   oo.s  := abs(k.ostc);
     OO.S  := ost_korr ( p_acc => K.ACC  , -- ACC счета
                         p_dat => l_dat31, -- Дата типа 31 число          31.MM.YYYY
                         p_di  => NULL   , -- номер даты месячного снимка 01.MM.YYYY, за который делаем отчет
                         p_nbs => K.NBS    -- бал.счет - т.к. не все счета есть в мес.снимках
                       ) ;
       bars_audit.info('clos_380_C_1 k.nls = '||k.nls||' k.kv = '||k.kv||' OO.S= '||OO.S);
     if    OO.s > 0 then oo.dk := 1  ;
     elsiF OO.s < 0 then oo.dk := 0  ; OO.S := abs(OO.S);
     ELSE  goto RecNext  ;
     end if;

     begin 
          bars_audit.info('clos_380_C_2 k.nls = '||k.nls||' k.kv = '||k.kv||' OO.S= '||OO.S);
          select nls, substr(nms,1,38) into oo.nlsb, oo.nam_b      from accounts
           where dazs is null and branch = k.branch and nbs=k.nbs and kv=k.kv
             and ob22 = decode ( k.kv, 980,decode (substr(k.nls,-3), '959','09', '961', '09','962' , '09','10') ,
                                           decode (k.kv,              959 ,'09',  961  ,'09', 962  , '09','10')
                                )  and rownum = 1;
     exception when no_data_found then 
         bars_audit.info('clos_380_C_2_1 k.nls = '||k.nls||' k.kv = '||k.kv||' OO.S= '||OO.S||' oo.nlsb not found ');        
        goto RecNext;
     end;

     if oo.ref is null then      gl.ref (oo.REF);
        oo.nd  := '380*(03)';    oo.nam_a := substr(k.nms,1,38) ;
        oo.nazn:= 'Згорнення 3800/3801(03).';
        gl.in_doc3(oo.REF, 'PS1', oo.vob, oo.nd, SYSDATE, oo.vdat, oo.dk, k.kv, oo.s, k.kv, oo.s, null,gl.BDATE, gl.bdate,
                  oo.nam_a, k.nls, gl.aMfo, oo.nam_b, oo.nlsb , gl.aMfo , oo.nazn ,null,gl.aOkpo,gl.aOkpo,
                  null, null, 1,null, user_id );
     end if;
     gl.payv(0,oo.REF, oo.vdat,'PS1', oo.dk, k.kv,k.nls, oo.s, k.kv, oo.nlsb,oo.s );

     <<RecNext>> null;
   end loop;
   if oo.ref is not null then   gl.pay(2,oo.REF,gl.bDATE); end if;
   RETURN;
end if;
-------
 oo.tt  := '38V'; oo.sk  :=  null; oo.vob :=  16  ;
--==============================================================
if mod_ = 0 and length(ob1)=2 and length(ob2)=2 then
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
     If k.ostc >0 then    oo.dk := 0;
     else                 oo.dk := 1;
     end if;
     oo.S  := abs(k.ostc);
     oo.s2 := gl.p_icurval(k.kv, oo.s, gl.bdate);
     PUL.Set_Mas_Ini( 'VP', k.NLS, 'Вал.Поз.' ) ;
     GL.REF (oo.REF);
     GL.IN_DOC3 (oo.REF, oo.TT, oo.vob, oo.ref, SYSDATE, GL.BDATE,  oo.dk,  K.KV, oo.S, 980, oo.s2, oo.sk, GL.BDATE,GL.BDATE,
                 oo.nam_a,oo.nlsa,gl.AMFO, oo.nam_b,oo.nlsb, gl.AMFO,
                'Передача Вал.Поз.'||k.ob22||' зг.листа № 16/5-27/8142 вiд 04.12.2009',      NULL,null,null,null, null,0,null, user_id );
     GL.PAYV(0,oo.REF, GL.BDATE, oo.TT, oo.dk, k.kv, oo.nlsa, oo.s, 980, oo.NLSb, oo.s2);     GL.PAY( 2,oo.REF, GL.BDATE);
     if length(k.branch) = 8 then  oo.branch:= k.branch || '000000/';
     else                          oo.branch:= k.branch ;
     end if;
     aa.nls   := nbs_ob22_null('3800', ob2, oo.branch);
     PUL.Set_Mas_Ini( 'VP', aa.NLS, 'Вал.Поз.' );      oo.ref := null;    GL.REF (oo.REF);
     GL.IN_DOC3 (oo.REF, oo.TT, oo.vob, oo.REF, SYSDATE, GL.BDATE, 1-oo.dk, K.KV ,oo.S, 980, oo.s2, oo.sk, GL.BDATE,GL.BDATE,
                 oo.nam_a, oo.NLSa, gl.AMFO, oo.nam_b, oo.nlsb, gl.AMFO, 'Прийом Вал.Поз.'||k.ob22||  ' зг.листа № 16/5-27/8142 вiд 04.12.2009', NULL,null,null,null, null,0,null, user_id );
     GL.PAYV(0, oo.REF, GL.BDATE , oo.TT, 1-oo.dk, k.kv, oo.NLSa, oo.s, 980, oo.NLSb, oo.s2 );   GL.PAY( 2, oo.REF, GL.BDATE );
  end loop;
--==============================================================
elsif mod_ = 1 and (length(ob1)=2 or length(ob2)=2 or length(ob3)=2 or length(ob3)=2) then
  for k in (select a.acc, dazs from accounts a  where a.nbs='3800' and a.ob22 in ( nvl(ob1,'**'), nvl(ob2,'**'), nvl(ob3,'**'), nvl(ob4,'**'))  and a.ostc=0 and a.ostc=a.ostb )
  loop
     if k.dazs is null then      update accounts set dazs = gl.bdate+1 where acc=k.acc;   end if;
     begin
        select a.* into aa from vp_list V , accounts a  where  v.acc3800 = k.ACC and v.acc3801=a.acc  and  a.ostc=0 and a.ostb=0;
        if aa.dazs is null then       update accounts set dazs=gl.bdate+1 where acc=aa.acc;      end if;
        delete from vp_list where acc3800=k.acc;
     EXCEPTION when NO_DATA_FOUND THEN null;
     end;
  end loop;
end if;

end clos_380_c;
/
show err;

PROMPT *** Create  grants  CLOS_380_C ***
grant EXECUTE                                                                on CLOS_380_C      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CLOS_380_C.sql =========*** End **
PROMPT ===================================================================================== 
