CREATE OR REPLACE procedure BARS.p_forex_netting (p_mode int )is

/*

20.06.2013 Qwa p_mode=2, при накоплении в архив вместо вьюшки v_forex_netting
               используем v_forex_a
29.04.2013 Sta Замена кода юзера      при изменении суммы докуметна на будущую отправку/получение денег
22.02.2013 Sta Замена подписи на null при изменении суммы докуметна на будущую отправку/получение денег
*/
  ---------------------------
  ro oper%rowtype           ;
  d1 v_forex_netting%rowtype;
  d2 v_forex_netting%rowtype;
  ff  V_FOR_NET_PRO%rowtype;

  kol_   int := 0           ;
  DAT1_  date;  DAT2_  date ;
  Detali_ varchar2(50)      ;
  nmk_   customer.nmk%type  ;
  ---------------------------

procedure ful_fx ( ref_  number, sr_  number ) is
  oo oper%rowtype;  SA_ NUMBER;
  -- Изменение(уменьшение или БЕК) будущих платежей на заход/отправку денег
begin
  If ref_ is NOT null then
     select * into oo from oper where ref =ref_;
     If oo.sos  in (1,3) then
        SA_ := OO.S - SR_;

        If    sr_ = 0    then  ful_bak(ref_);
        elsIf SR_ < oo.S then
/*
TODO: owner="vitalii.kyrychok" category="Vega2" priority="1 - High" created="02.07.2016"
text="Использование SIGN."
*/            update oper set s  = sr_,
                           s2 = sr_,
                           nazn = substr( nazn||'/нетт_нг '||Detali_, 1,160 ),
                           sign = null, ID_O = null ,
                           USERID =  gl.aUid
            where ref = ref_;
            update oper_visa set sign = null, KEYID = null where ref = ref_;


           for k in (select * from opldok where ref = ref_)
           loop
              update opldok set s  =  sr_, sq =  gl.p_icurval ( oo.kv, sr_, fdat)
                         where ref = ref_ and dk = k.dk and stmt = k.stmt;
              if  k.sos   = 1 and k.dk =0 then
                  update accounts set ostb = ostb + sA_ where acc = k.acc;
              elsif k.sos = 1 and k.dk =1 then
                  update accounts set ostb = ostb - sA_ where acc = k.acc;
              elsif k.sos = 3 and k.dk =0 then
                  update accounts set ostf = ostf + sA_ where acc = k.acc;
              elsif k.sos = 3 and k.dk =1 then
                  update accounts set ostf = ostf - sA_ where acc = k.acc;
              end if;
           end loop ;
        end if;
     end if;
   end if;
   RETURN;
end ful_fx;
-------------

procedure NET0  is
  -- неттинг 2-х сделок
begin
  ro.tt := 'NET';
  kol_  := 0    ;

  for k in (select  * from tmp_irr_user where userid=user_id)
  loop
    kol_ := kol_ + 1;
    if kol_ = 1 then
       select * into d1 from v_forex_netting where deal_tag = k.n;
       RO.KV  := k.S;
    elsIf kol_ = 2 then
       If k.S <>  RO.KV then raise_application_error(-20100, '    \Отмечены сделки разных валют.' || RO.KV || '<>' || k.S );
       end if;
       select * into d2 from v_forex_netting where deal_tag = k.n;
    end if;
  end loop;

  If kol_ <>2 then           raise_application_error(-20100, '    \Отмечено ' || kol_ || ' сделок. Д.б. ровно ДВЕ' );
  end if;

  If nvl(d1.rnk,-1) <> nvl(d2.rnk,-2) then   raise_application_error(-20100, '    \Отмечены сделки разных кл.' || d1.rnk || ' и ' || d2.rnk );
  end if;

  ro.nlsa := D1.NLSA; ro.nlsb := D2.NLSB ;

  Detali_ := 'тiк.' || trim (nvl(d1.detali, d2.detali) )|| ' вiд ' || to_char(gl.bdate,'dd.mm.yy');

  If    RO.KV = d1.kva and RO.KV=d2.kvb then
        ro.s    := least(d1.sa,d2.sb)*100;
        DAT1_   := d1.DAT_a;
        ful_fx ( ref_ => d1.refa, sr_ => (d1.sa*100 - ro.s) );
        ful_fx ( ref_ => d2.refb, sr_ => (d2.sb*100 - ro.s) );

  elsIf RO.KV = d1.kvb and RO.KV = d2.kva then
        ro.s    := least(d1.sb,d2.sa)*100;
        DAT1_   := d1.DAT_b;
        ful_fx ( ref_ => d1.refb, sr_ => (d1.sb*100 - ro.s) );
        ful_fx ( ref_ => d2.refa, sr_ => (d2.sa*100 - ro.s) );
  else                       raise_application_error(-20100, '    \Пары валют нет '|| d1.kva || '-' || d2.kvb || ' , ' || d1.KVb ||'-'|| d2.kva );
  end if;

  If DAT1_ <> DAT2_ then
     raise_application_error(-20100, '    \Отмечены сделки разных дат.' || DAT1_ || ' и ' || DAT2_ );
  end if;

  update fx_deal set neta = null, netb = null, detali=null where deal_tag in (d1.deal_tag, d2.deal_tag);

  select trim(nmk) into nmk_ from customer where rnk = d1.rnk;

  ro.nazn := substr('Netting('|| Detali_ || ')' || RO.KV    || ' угод  ' || nmk_||':' || d1.ntik  || ' вiд ' || to_char( d1.dat,'dd.mm.yyyy') ||
             ' та '    || d2.ntik  || ' вiд '   || to_char( d2.dat,'dd.mm.yyyy'), 1,160) ;

  IF RO.S >0 THEN
     gl.ref (ro.REF);
     ro.nd  := nvl(substr(to_char(ro.REF),-10),'1');
     ro.dk  := 0    ;
     ro.kv2 := ro.KV;
     begin
       select substr(a.nms,1,38), ca.okpo, substr(b.nms,1,38), cb.okpo
       into ro.nam_a, ro.id_a,  ro.nam_b, ro.id_b
       from accounts a, customer ca, accounts b, customer cb
       where a.dazs is null and a.nls=ro.nlsa and a.rnk=ca.rnk and a.kv=ro.kv
         and b.dazs is null and b.nls=ro.nlsb and b.rnk=cb.rnk and b.kv=ro.kv;
     exception when NO_DATA_FOUND THEN
       raise_application_error(-20100, 'не знайдено рах '||  ro.nlsa ||'/'||ro.kv  || ', '||  ro.nlsb ||'/'||ro.kv2 );
     end;

     gl.in_doc3(
        ref_  =>ro.REF  , tt_   =>ro.tt   , vob_ =>6  ,
        nd_   =>ro.nd   , pdat_ =>SYSDATE , vdat_=>GL.BDATE, dk_   =>ro.dk   , kv_   =>ro.kv   , s_    =>ro.s   ,
        kv2_  =>ro.kv2  , s2_   =>ro.s    , sk_  =>NULL    , data_ =>gl.BDATE, datp_ =>gl.bdate,
        nam_a_=>ro.nam_a, nlsa_ =>ro.nlsa , mfoa_=>gl.aMfo , nam_b_=>ro.nam_b, nlsb_ =>ro.nlsb , mfob_=>gl.aMfo ,
        nazn_ =>ro.nazn , d_rec_=>null    ,id_a_ =>ro.id_a ,
        id_b_ =>ro.id_b , id_o_ =>null    , sign_=>null    , sos_  =>1       , prty_ =>null    , uid_ =>null    );

     gl.payv(0, ro.REF, gl.bDATE, ro.tt, ro.dk, ro.kv , ro.nlsa, ro.s, ro.kv2, ro.nlsb, ro.s2);

     insert into FX_DEAL_REF (deal_tag,ref ) values (d1.deal_tag, ro.ref);
     insert into FX_DEAL_REF (deal_tag,ref ) values (d2.deal_tag, ro.ref);

  end if;

  delete from tmp_irr_user where userid=user_id;

end NET0;
-----------------------------

procedure NET1  is
  -- неттинг по сделкам RNK+DATA+ВАЛ
  ff  V_FOR_NET_PRO%rowtype;
begin
  for k in (select rowid RI, rnk, kv, sdate, cc_id from TMP_FX_NETTING where name =  'V_FOR_NET_PRO')
  loop
     WHILE TRUE
     loop
        begin
          select * into ff from  V_FOR_NET_PRO                  where rnk= k.rnk and dat_a=k.sdate and kva=k.kv  and s = 1    ;
          select * into d1 from  v_forex_netting                where rnk= k.rnk and dat_a=k.sdate and kva=k.kv  and rownum=1 ;
          select * into d2 from  v_forex_netting                where rnk= k.rnk and dat_b=k.sdate and kvb=k.kv  and rownum=1 ;
          delete from tmp_irr_user where userid=user_id;
          --update v_forex_netting set neta = 1, detali = k.cc_id where deal_tag = d1.deal_tag;
         -- update v_forex_netting set netb = 1, detali = k.cc_id where deal_tag = d2.deal_tag;
          p_forex_netting_row_update(k.rnk,
                            d1.deal_tag,
                            k.kv,
                            k.kv,
                            1,
                            d1.netb,
                            k.cc_id);
                            
         p_forex_netting_row_update(k.rnk,
                            d2.deal_tag,
                            k.kv,
                            k.kv,
                            d2.neta,
                            1,
                            k.cc_id);
          
          net0;
        exception when NO_DATA_FOUND THEN
          delete from TMP_FX_NETTING where rowid= k.RI;
          exit;
        end;
     end loop;
  end loop;
  delete TMP_FX_NETTING where userid=user_id;
end NET1;

-----
--- Главная процедура
begin
  If    p_mode  = 0 then NET0;
  ElsIf p_mode  = 1 then NET1;

  ElsIf p_mode  = 2 then
        delete from FOREX_A where fdat = gl.bdate ;
        insert into FOREX_A
              (NTIK,DAT,RNK,DEAL_TAG,REFA,DAT_A,ACCA,KVA,NLSA,NETA,SA,DETALI,REFB,DAT_B,ACCB,KVB,NLSB,NETB,SB,FDAT)
        select NTIK,DAT,RNK,DEAL_TAG,REFA,DAT_A,ACCA,KVA,NLSA,NETA,SA,DETALI,REFB,DAT_B,ACCB,KVB,NLSB,NETB,SB,
        to_date(to_char(gl.bd,'dd-mm-yyyy'),'dd-mm-yyyy')
        from V_FOREX_A ;

  else  null;
  end if;

end p_forex_netting;
/