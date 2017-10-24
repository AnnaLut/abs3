

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NLK_PAY2.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NLK_PAY2 ***

  CREATE OR REPLACE PROCEDURE BARS.NLK_PAY2 (p_tip varchar2, p_mode number, p_acc number, p_ref1 number, p_s number, p_id number) is
  o1 oper%rowtype;
  oo oper%rowtype;
  aa accounts%rowtype;

  --for NL$ ---------------------
  sTT7    tts.tt%type      := '024';
  sTT2    tts.tt%type      := 'C10';
  sTT1    tts.tt%type      := '019';
  sTT6    tts.tt%type      := 'D06';
  nVob7   oper.vob%type    := 6;
  nVob1   oper.vob%type    := 56;
  aKOD_B  operw.value%type := GetGlobalOption('1_PB');
  aKOD_N  operw.value%type := GetGlobalOption('NL$_KODN');
  aKOD_7  operw.value%type := GetGlobalOption('NL$_KOD7');

  PR_KOM  number;
  s_NB    banks.nb%type;
  l_LCV   tabval.lcv%type;

  NLS_1001     accounts.nls%type := '10012';
  NLS_1007     accounts.nls%type := '10070021';
  NLS_TRZ_GOU  accounts.nls%type := '37391806557';
  NLS6_GOU_RU  accounts.nls%type := '37200001';
  -----------------
  l_acc  number;
begin

logger.info('NLK_PAY2-1*p_tip=' || p_tip || '* p_mode=' || p_mode || '* p_acc=' || p_acc || '* p_ref1=' || p_ref1 || '* =' || p_s || '* p_id=' || p_id || '*');

  If p_mode = 0 then
     PUL.Set_Mas_Ini('P_NLS', p_tip         , '');
     PUL.Set_Mas_Ini('ACC'  , to_char(p_acc), '');
     RETURN;
  end if;
  l_acc := NVL(p_acc, TO_NUMBER (pul.Get_Mas_Ini_Val ('ACC') ) );

  --------------------------------------
  --ОБЩИЙ ДЛЯ ВСЕХ ТИПОВ КАРТОТЕК РЕЖИМ УДАЛЕНИЯ
  If p_mode = 1 then
     delete from nlk_ref where aCC = l_ACC AND REF1= p_REF1;
     RETURN;
  end if;

  begin select * into o1 from oper where ref = p_ref1 and sos >=4;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-(20203),'пробл.з вх.реф='||p_ref1);
  end;

  begin select * into aa from accounts where acc = l_acc and dazs is null ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-(20203),'пробл.з рах.фсс ='||l_acc );
  end;

-- CПЕЦИФИКА для  NL$
If p_tip = 'NL$' then
-- 1000 = З каси   1001 - комісія
-- 1001 = З каси   1001
-- 1007 = З дороги 1007

   If p_mode = 1000 and aa.KV = gl.baseval then raise_application_error(-(20203),'Дія НЕдопустима для нац.вал.'); end if;

   begin SELECT nb     into s_NB   FROM banks   WHERE  MFO = oo.mfoa ;  EXCEPTION WHEN NO_DATA_FOUND THEN null;   end;
   begin SELECT lcv    into l_LCV  FROM tabval  WHERE  kv  = aa.kv   ;  EXCEPTION WHEN NO_DATA_FOUND THEN null;   end;
   begin SELECT pr_kom into PR_KOM FROM NL$_kom WHERE  kv  = aa.kv   ;  EXCEPTION WHEN NO_DATA_FOUND THEN null;   end;
   PR_KOM := NVL(PR_KOM,0);

   oo.s := p_s*100;
   If aa.kv <> gl.baseval then oo.sq := gl.p_iCurval(aa.KV, oo.s, gl.bdate);
   else        oo.sk := 72 ;   oo.sq := oo.s ;
   end if;

   If p_mode   = 1007 then
      oo.nlsb := NLS_1007;
      oo.vob  := nVob7;
      oo.tt   := sTT7;
      oo.nazn := Substr('Списання коштів за підкріплення готівковою валютою ч/з ф.зв`зок ' || s_NB, 1, 160);
  else   -------------------------If nBob = ID_Yes or (nBob = ID_Kms and tb1.KV != n980) !!!  1001*
      oo.nlsb := NLS_1001;
      oo.TT   := sTT1;
      oo.Vob  := nVob1;
      oo.nazn := Substr ('Підкріплення готівковою валютою ' || s_NB ||' згідно заявки та доручення ', 1, 160 );
--    If SalModalDialog(dlg_PODOT, hWndForm, tb1.NLS, sFIO, sPASP, sPASPN, sATRT, sDOVIR) = 0
  end if;

  begin select substr(nms,1,38) into oo.nam_b from accounts where nls = oo.nlsb and kv = aa.kv;
  EXCEPTION WHEN NO_DATA_FOUND THEN oo.nam_b := 'Каса';
  end;

  oo.dk := 1;
  gl.ref (oo.REF);
  OO.ND    := Substr(to_char(oo.ref), 1, 10);
  oo.nam_a := substr(aa.nms, 1, 38) ;
  gl.in_doc3(ref_ =>oo.ref  , tt_ => oo.tt, vob_ =>OO.VOB , nd_  => oo.nd  , pdat_=> SYSDATE, vdat_=>gl.bdate, dk_  => oo.dk  ,
             kv_  =>aa.kv   , s_  => oo.S , kv2_ =>aa.kv  , s2_  => oo.s   , sk_  => oo.sk  , data_=>gl.bdate, datp_=>gl.bdate,
            nam_a_=>oo.nam_a,nlsa_=>aa.nls, mfoa_=>gl.aMfo,nam_b_=>oo.nam_b, nlsb_=>oo.nlsb ,mfob_=>gl.aMfo  ,
            nazn_ =>oo.nazn ,
            d_rec_=> null  ,id_a_=>gl.aOkpo, id_b_=>gl.aOkpo,id_o_ =>null, sign_=> null , sos_=>1, prty_=>null, uid_ => null );
  paytt ( 0, oo.ref, gl.bdate,oo.tt, oo.dk, aa.kv, aa.nls, oo.s, aa.kv, oo.nlsb, oo.s);
  ------------------------------------------------
  UPDATE nlk_ref  SET ref2 = oo.ref ,  ref2_state = 'P'   WHERE ref1 = p_REF1  and acc = l_ACC ;

  If p_mode in ( 1001, 1000 ) then -- натуральная касса
     for k in (select * from PODOTC where id = p_id and tag in ('FIO','PASP','PASPN','ATRT','DOVIR' ) )
     loop      set_operw  ( oo.ref, k.tag, k.val ); end loop;
     set_operw  ( oo.ref, 'KOD_N' , aKOD_N);
     Else --дорога  1007*
        set_operw  ( oo.ref, 'KOD_N' , aKOD_7);
     end if;

  set_operw  ( oo.ref, 'KOD_B' , aKOD_B);
  set_operw  ( oo.ref, 'KOD_G' , '804'   );

  -- ---! 2-й документ = проводка по комиссии, только для вал из кассы
  If  aa.kv = gl.baseval then RETURN; end if;
  -----------------------------------------------------------

  if p_mode = 1000 then oo.Nazn := Substr('Комісія за підкріплення гот. для компенсаційних виплат' , 1, 160 );
  Else                  oo.Nazn := Substr('Комісія за підкріплення гот.вал. '||p_s||' '||l_LCV||' '||PR_KOM||' %. Підлягає віднесенню на 7180*', 1, 160) ;
  end if;

  oo.s  := ROUND(oo.S  * PR_KOM / 100,0 );
  If oo.s >=1 then
     oo.s2 := round(oo.sq * PR_KOM / 100,0 );
     begin select nls, substr(nms,1,38) into oo.nlsa, oo.nam_a from accounts where nls = NLS_TRZ_GOU and kv = aa.kv and dazs is null;
     EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-(20203),'Проблеми з рах.'||NLS_TRZ_GOU ||'/'|| aa.kv);
     end  ;

    BEGIN
       SELECT NLS_GTD, NLS6_GOU_GT
         INTO oo.nlsb, NLS6_GOU_RU
         FROM alegro
        WHERE NLS_CHD IS NOT NULL AND NLS6_GOU_CH IS NOT NULL AND MFO = o1.MFOA;

       IF oo.nlsb IS NULL OR NLS6_GOU_RU IS NULL
       THEN
          raise_application_error (-(20203), 'Для МФОА=' || o1.MFOA || ' не заповнено позиції NLS_GTD, NLS6_GOU_GT в АЛЕГРО.');
       END IF;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN
          oo.nlsb := o1.nlsa;
    END;
    gl.ref (oo.REF);
    gl.in_doc3(ref_ =>oo.ref, tt_ => sTT2  , vob_ =>2 , nd_  => oo.nd  , pdat_=> SYSDATE, vdat_=>gl.bdate, dk_  => 0  ,
             kv_  =>aa.kv   ,  s_  => oo.S  , kv2_ =>aa.kv  , s2_  => oo.s   , sk_  => null, data_=>gl.bdate, datp_=>gl.bdate,
            nam_a_=>oo.nam_a, nlsa_=>oo.nlsa, mfoa_=>gl.aMfo,
            nam_b_=>o1.nam_a, nlsb_=>oo.nlsb, mfob_=>o1.MfoA,
            nazn_=>oo.nazn,
            d_rec_=> null  ,id_a_=>gl.aOkpo, id_b_=>o1.id_a,id_o_ =>null, sign_=> null , sos_=>1, prty_=>null, uid_ => null );
    paytt  (0, oo.ref, gl.bdate, sTT2, 0, aa.kv, oo.nlsa, oo.s, aa.kv     , oo.nlsb    , oo.s);
    gl.payv(0, oo.ref, gl.bdate, sTT6, 1, aa.kv, oo.nlsa, oo.s, gl.baseval, NLS6_GOU_RU, oo.s2);
  end if;

end if; --- NL$

end nlk_pay2 ;
/
show err;

PROMPT *** Create  grants  NLK_PAY2 ***
grant EXECUTE                                                                on NLK_PAY2        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NLK_PAY2        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NLK_PAY2.sql =========*** End *** 
PROMPT ===================================================================================== 
