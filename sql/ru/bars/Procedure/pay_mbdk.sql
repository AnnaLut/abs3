create or replace procedure pay_mbDk (p_nd number, p_stp int, p_npp int) is 
  xx V_PAY_MBDK%rowtype;  
  dd cc_deal%rowtype ; 
  d1 cc_add%rowtype  ; 
  bb custbank%rowtype; 
  cc customer%rowtype; 
  pp V_MBDK_PORTFOLIO%rowtype;
  oo oper%rowtype;
  l_nazn varchar2 (360);
  k980 int;
begin

  k980 := NVL(gl.baseval,980);
  select * into xx from V_PAY_MBDK        where nd  = p_nd and npp= p_npp;
  select * into dd from cc_deal           where nd  = p_nd ;
  select * into pp from V_MBDK_PORTFOLIO  where nd  = p_nd ;
  select * into d1 from cc_add            where nd  = p_nd and adds = 0 ;
  select * into bb from custbank          where rnk = dd.rnk;
  select * into cc from customer          where rnk = dd.rnk;
  pp.S_1819 :='37397005523';
  oo.vdat   := gl.bdate ;

  If    p_npp = 12 then --- Нарахувати %%/доходы
        pul_dat (to_char( dd.wdate, 'dd.mm.yyyy') , '' );
        Interest  (p_dat0 => xx.ACR_DAT, p_acc =>d1.accs, p_id => 0 ) ;
        RETURN;

  elsIf p_npp = 22 then --- 'Нарахувати %%/расходы'
        pul_dat (to_char( dd.wdate, 'dd.mm.yyyy') , '' );
        Interest  (p_dat0 => xx.ACR_DAT, p_acc =>d1.accs, p_id => 1 ) ;
        RETURN;

  ElsIf p_npp = 10 then --  Отправить на размещение ОСНОВНУЮ сумму
        l_nazn  := substr(MBK.F_GetNazn('RO',p_ND),1,360) ;             oo.nazn := substr(l_nazn,1,160);
        oo.nlsa := xx.nls ;     oo.nam_a := substr(cc.nmk ,1,38);       oo.id_a := cc.okpo ; oo.mfoa := gl.aMfo;
        oo.nlsb := d1.acckred;  oo.nam_b := oo.nam_a      ;             oo.id_b := oo.id_a ; oo.mfob := bb.Mfo ;
        if p_stp = 1 then oo.tt := 'KV7'; else oo.tt := 'KV2'; end if ; oo.s    := dd.limit * 100; 

  Elsif p_npp = 11 then  -- Принять погашение ОСНОВНОЙ суммы
        l_nazn  := substr(MBK.F_GetNazn('RP',p_ND),1,360) ;             oo.nazn := substr(l_nazn,1,160);
        oo.nlsa := pp.S_1819;   oo.nam_a := 'Транзит для розр.по МБДК'; oo.id_a := gl.aOkpo ; oo.mfoa := gl.aMfo;
        oo.nlsb := xx.nls   ;   oo.nam_b := substr(cc.nmk ,1,38)      ; oo.id_b := cc.okpo  ; oo.mfob := gl.aMfo;
        oo.tt   := 'KV1'    ;   oo.s     := - xx.ostc_A *100 ;   

  Elsif p_npp = 13 then  -- 'Прийняти погашення %%'  
        l_nazn  := substr(MBK.F_GetNazn('RPP',p_ND),1,360) ;            oo.nazn := substr(l_nazn,1,160);
        oo.nlsa := pp.S_1819;   oo.nam_a := 'Транзит для розр.по МБДК'; oo.id_a := gl.aOkpo ; oo.mfoa := gl.aMfo;
        oo.nlsb := xx.nlsN  ;   oo.nam_b := substr(cc.nmk ,1,38)      ; oo.id_b := cc.okpo  ; oo.mfob := gl.aMfo;
        oo.tt   := 'KV1'    ;   oo.s     := - xx.ostc_B *100 ;   

  Elsif p_npp = 20 then  -- Прийняти на залучення осн.суму
        l_nazn  := substr(MBK.F_GetNazn('PP',p_ND),1,360) ;             oo.nazn := substr(l_nazn,1,160);
        oo.nlsa := pp.S_1819;   oo.nam_a := 'Транзит для розр.по МБДК'; oo.id_a := gl.aOkpo ; oo.mfoa := gl.aMfo;
        oo.nlsb := xx.nls   ;   oo.nam_b := substr(cc.nmk ,1,38)      ; oo.id_b := cc.okpo  ; oo.mfob := gl.aMfo;
        oo.tt   := 'KV1'    ;   oo.s     := dd.limit * 100; 

  ElsIf p_npp = 21 then --  Повернути залучену осн.суму
        l_nazn  := substr(MBK.F_GetNazn('PO',p_ND),1,360) ;             oo.nazn := substr(l_nazn,1,160);
        oo.nlsa := xx.nls ;     oo.nam_a := substr(cc.nmk ,1,38);       oo.id_a := cc.okpo ; oo.mfoa := gl.aMfo;
        oo.nlsb := d1.acckred;  oo.nam_b := oo.nam_a      ;             oo.id_b := oo.id_a ; oo.mfob := bb.Mfo ;
        if p_stp = 1 then oo.tt := 'KV7'; else oo.tt := 'KV2'; end if ; oo.s    := xx.ostc_A * 100; 

  ElsIf p_npp = 23 then --  Перерахувати нарах %%
        l_nazn  := substr(MBK.F_GetNazn('PPO',p_ND),1,360) ;            oo.nazn := substr(l_nazn,1,160);
        oo.nlsa := xx.nlsN;     oo.nam_a := substr(cc.nmk ,1,38);       oo.id_a := cc.okpo ; oo.mfoa := gl.aMfo;
        oo.nlsb := d1.acckred;  oo.nam_b := oo.nam_a      ;             oo.id_b := oo.id_a ; oo.mfob := bb.Mfo ;
        if p_stp = 1 then oo.tt := 'WD7'; else oo.tt := 'WD2'; end if ; oo.s    := xx.ostc_b * 100; 

  Else RETURN;
  end if;

  gl.ref (oo.REF) ;
  oo.kv   := xx.kv  ;  
  oo.s2   := oo.s ;
  oo.kv2  := oo.kv;
  oo.dk   := 1;
  oo.nd   := Substr(dd.cc_id,1,10);
  oo.mfoa := gl.aMfo;
  gl.in_doc3 (ref_=>oo.REF  ,  tt_ =>oo.tt  , vob_=>6 , nd_  =>oo.nd   ,pdat_=>SYSDATE, vdat_=>oo.vdat , dk_ =>oo.dk,
               kv_=>oo.kv   ,  s_  =>oo.S   , kv2_=>oo.kv2 , s2_  =>oo.S2   ,sk_  => null  , data_=>gl.BDATE,datp_=>gl.bdate,
            nam_a_=>oo.nam_a, nlsa_=>oo.nlsa,mfoa_=>oo.mfoa,nam_b_=>oo.nam_b,nlsb_=>oo.nlsb, mfob_=>oo.mfob,
             nazn_=>oo.nazn ,d_rec_=>null   ,id_a_=>oo.id_a,id_b_=>oo.id_b  ,id_o_=>null   , sign_=>null, sos_=>1, prty_=>null, uid_=>null );
  paytt(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2,  oo.nlsb, oo.s2);

  RETURN;

end pay_mbDk;
/
show err;

grant execute on  pay_mbDk to bars_access_defrole ;
