

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_INTCAP2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_INTCAP2 ***

  CREATE OR REPLACE PROCEDURE BARS.P_INTCAP2 (dat_ date) is
  acc1_  accounts.acc%type;
  nlsk_  oper.nlsb%type   ;
  s2_    oper.s2%type     ;
  ref_   oper.ref%type    ;
  tt_    oper.tt%type     ;
  l_s    oper.s%type      ;
  s_ostc oper.s2%type     ;
----------------------------------------------------------------------------
---
---                        В Н И М А Н И Е !
---                        =================
---
---   ВЫПЛАТА работает только тогда, когда в проводках по начислению %%
---   (операция %%1) текст "Призначення платежу" начинается так:
---
---                    %% по рах. ХХХХХХХХХХХ              ,
---
---   а не             %% по счету ХХХХХХХХХХХ
---
---   Для этого раб.место, которое начисляет %%, должно быть настроено
---   "Режими"/"Налаштування"/"Мовнi установки":
---
---        ID мови iнтерфейсу      =          UKR       (не RUS !!!)
---
----------------------------------------------------------------------------
begin

 ACC1_ := null;
 -- цикл k1 по документам по начислению %%
 for k in (select o.ref, a.acc, i.acra, a.nls, ia.nls nlsa, ia.nms nama, c.okpo okpoa,
                  least(o.s, abs(ia.ostb)) s,
                  ia.kv,
                  nvl(i.mfob, a.kf) mfob,
                  nvl(i.nlsb, a.nls) nlsb,
                  nvl(i.kvb, a.kv) kvb,
                  nvl(i.namb, ia.nms) namb,
                  nvl(i.okpo, c.okpo) okpob,
                  case when nvl(i.mfob, ia.kf) = gl.kf() then '024' else 'PS2' end tt, o.nazn
           from   oper o
           join   int_reckoning r on r.oper_ref = o.ref
           join   accounts a on a.acc = r.account_id and exists (select 1 from int_cap f
                                                                 where  f.nbs = a.nbs and
                                                                        ( f.ob22 like '%*%' or f.ob22 = a.ob22))
           join   int_accn i on i.acc = a.acc and i.id = 1 -- and (i.apl_dat is null or i.apl_dat < :dat_)
           join   accounts ia on ia.acc = i.acra
           join   customer c on c.rnk = a.rnk
           left join accounts ra on ra.nls = i.nlsb and ra.kv = i.kvb and ra.kf = i.kf
           where  -- o.ref in (90049791601, 90049969101) and
                  r.reckoning_id = '53335630FB15025AE0530A076206C772' and
                  o.kf = '322669' and
                  o.tt = '%%1' and
                  o.sos = 5 and
                  o.vdat = dat_ and
                  o.dk = 0 and
                  substr(o.nlsb, 1, 1) = '7' and
                  not exists (select 1 from dpu_deal d where d.acc = a.acc)) loop

    SAVEPOINT DO_OPL;  -- точка отката-1. Оплата по ПЛАНУ

       select sum(s*decode(dk,1,1,-1))
       into   l_s
       from   opldok
       where  ref = k.ref
         and  acc = k.acra;

       l_s := least(l_s, k.s);

       if (l_s > 0) then

           if k.kv = k.kvb then s2_ := l_s;                              -- в1 - в1
           elsif k.kv=980 then  s2_ := gl.p_ncurval(k.kvb,l_s,gl.bdate); -- грн-вал
           else                 s2_ := gl.p_icurval(k.kv, l_s,gl.bdate); -- вал-грн
           end if;

           gl.ref (ref_);

           -----------------
           begin
              gl.in_doc3(ref_   => REF_,
                         tt_    => k.tt,
                         vob_   => 6,
                         nd_    => substr(to_char(REF_),1,10),
                         pdat_  => SYSDATE ,
                         vdat_  => gl.BDATE,
                         dk_    => 1,
                         kv_    => k.kv,
                         s_     => l_s,
                         kv2_   => k.kvb,
                         s2_    => S2_,
                         sk_    => null,
                         data_  => gl.BDATE,
                         datp_  => gl.bdate,
                         nam_a_ => substr(k.nama, 1, 38),
                         nlsa_  => k.nlsa,
                         mfoa_  => gl.aMfo,
                         nam_b_ => substr(k.NAMB, 1, 38),
                         nlsb_  => k.nlsb,
                         mfob_  => k.MfoB,
                         nazn_  => substr('Виплата ' || replace(k.nazn, 'Нарах.'), 1, 160),
                         d_rec_ => null,
                         id_a_  => k.okpoa,
                         id_b_  => k.okpob,
                         id_o_  => null,
                         sign_  => null,
                         sos_   => 1,
                         prty_  => null);

              paytt(flg_  => 0,
                    ref_  => REF_ ,
                    datv_ => gl.bDATE,
                    tt_   => k.tt,
                    dk0_  => 1,
                    kva_  => k.kv,
                    nls1_ => k.nlsa,
                    sa_   => l_s,
                    kvb_  => k.kvb,
                    nls2_ => k.nlsb,
                    sb_   => S2_);
/*
              If tt_ = '024'  then   ---<-- Внутрення выплата
                 ------------------
                 SAVEPOINT DO_fakt;  -- точка отката-2 . Оплата по ФАКТУ
                 ------------------
                 begin
                   gl.PAY (2, ref_, gl.bdate);  --<-  sопытка оплаты по факту (без виз)
                 EXCEPTION  WHEN OTHERS THEN  ROLLBACK TO DO_fakt;
                 END;
              end if;
*/
           EXCEPTION
               WHEN OTHERS THEN
                    bars_audit.log_error('p_intcap2', sqlerrm || dbms_utility.format_error_backtrace());
                    ROLLBACK TO DO_OPL;
           END;
    end if;

    If acc1_ is not null and  acc1_  <> k.acc then
       update int_accn set apl_dat = dat_   where acc = acc1_ and id = 1;
    end if;
    acc1_ := k.acc;

  end loop;

  If acc1_ is not null then
     update int_accn set apl_dat = dat_   where acc = acc1_ and id = 1;
  end if;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_INTCAP2.sql =========*** End ***
PROMPT ===================================================================================== 
