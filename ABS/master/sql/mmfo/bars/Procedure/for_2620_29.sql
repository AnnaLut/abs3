

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FOR_2620_29.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FOR_2620_29 ***

  CREATE OR REPLACE PROCEDURE BARS.FOR_2620_29 
(p_acc  nlk_ref.acc%type,
 p_ref1 nlk_ref.REF1%type)

/*
15.06.2011
Контакт центр регистрирует клиента в разных ТВБВ
и если у нас есть уже на этого клиента открытый счет на одно ТВБВ,
то при автоматической разноске - деньги реально пришедшие на этого клиента для второго ТВБВ
садятся на счет уже открытый (т.е. счет этого, клиента но другого ТВБВ).

Открываем другой счет 2620 !

12-05-2011 Если Дата рожд l_bday > l_PDATE Даты выдачи паспорта,
                то меняем дату ВЫДАЧИ паспорта l_PDATE := l_bday +1
           Согласовано с Шарадовым

26-04-2011 Подхватываем платежи прямые, т.е. постепившие прямо из СЕП
           а также те. которые прошли через картотеку невыясненных 3720
*/

Is
 -----------------------------------------------------------------------------------------
 l_nazn    oper.nazn%type    ; l_drec    oper.d_rec%type   ; l_nmk     customer.nmk%type ;
 l_kv      oper.kv%type      ; l_isp     oper.userid%type  ; l_nd      oper.nd%type      ;
 l_s       oper.s%type       ; l_nms29   accounts.nms%type ; l_nls29   accounts.nls%type ;
 l_branch  branch.branch%type;
 -----------------------------------------------------------------------------------------
 l_adr     customer.adr%type ; l_nbsR    ps.nbs%type       ; l_np      oper.s%type       ;
 l_okpo    customer.okpo%type; l_BDAY    person.BDAY%type  ; l_BPLACE  person.BPLACE%type;
 l_COUNTRY customer.COUNTRY%type; l_REZID rezid.rezid%type ; l_PASSP   person.PASSP%type ;
 l_SER     person.SER%type   ; l_NUMDOC  person.NUMDOC%type; l_ORGAN   person.ORGAN%type ;
 l_PDATE   person.PDATE%type ;
 -----------------------------------------------------------------------------------------
 l_rnk     person.rnk%type   ; l_VIDD dpt_deposit.VIDD%type; l_dptid dpt_deposit.DEPOSIT_ID%type := null;
 l_nls26   accounts.nls%type ; l_nms26   accounts.nms%type ; l_nls70   accounts.nls%type ;
 -----------------------------------------------------------------------------------------
 l_q       oper.sq%type      ; sTmp_  varchar2(160)        ; i_ int                      ;
 ref_      oper.REF%type     ; tt_   oper.TT%type  := '024'; vob_  oper.VOB%type   := 6  ;
 -----------------------------------------------------------------------------------------
 l_nbs7 accounts.nbs%type ;
 l_ob7  accounts.ob22%type;
---------------------------

begin

 begin
   -- чистые поступления из ВПС
   select o.nazn, o.d_rec,a.branch,o.nam_b, o.kv,o.userid,o.nd,o.s,substr(a.nms,1,38),a.nls
   into   l_nazn, l_drec, l_branch,  l_nmk, l_kv,  l_isp ,l_nd,l_s,l_nms29           ,l_nls29
   from oper o, accounts a
   where o.ref = p_REF1
     and a.kv  = o.kv
     and a.nls = o.nlsb
     and o.mfoa='300465'
     and o.mfob=gl.aMfo;

 EXCEPTION WHEN NO_DATA_FOUND THEN

   -- возможно из картотеки 3720 ("невыясненные")
   begin
     select o.nazn, o.d_rec,a.branch,o.nam_b, o.kv,o.userid,o.nd,o.s,substr(a.nms,1,38),a.nls
     into   l_nazn, l_drec, l_branch,  l_nmk, l_kv,  l_isp ,l_nd,l_s,l_nms29           ,l_nls29
     from oper o, accounts a, operw w
     where w.ref = p_REF1
       and w.tag = 'REF92'
       and o.ref = w.value
       and a.kv  = o.kv
       and a.nls = o.nlsb
       and o.mfoa='300465'
       and o.mfob=gl.aMfo;
   exception when others then RETURN;
   end;

 end;

 -- l_nmk    В поле Наимен.Б - ФИО клиента
 -- l_branch Код Бранча-3(получателя) он следует автоматически по счету получателя 2909/66

 --Адрес клиента
 l_adr  := trim( replace ( substr(l_drec,3), '#',' '));
--logger.info('NLK l_adr='|| l_adr);

 --Вид договора в Родовид т.е 2620,2625,2630,2635
 l_nbsR := substr(l_nazn,1,4);
--logger.info('NLK l_nbsR='|| l_nbsR);

 --Сумма нач проц в <коп> без разделителей на триады
 l_nazn := substr(l_nazn,6);
 i_     := instr(l_nazn,';');
--logger.info('NLK i_='|| i_);
 sTmp_  := substr(l_nazn,1,i_-1);
--logger.info('NLK sTmp_='|| sTmp_);
 begin
   l_np := to_number(sTmp_);
 exception  when others then RETURN;
 end;
--logger.info('NLK l_np='|| l_np);

 -- Ид.код клиента
 l_nazn := substr(l_nazn, i_+1 );
 i_     := instr(l_nazn,';');
 l_okpo := substr(l_nazn,1,i_-1);
--logger.info('NLK l_okpo  ='|| l_okpo );

 --Дата рождения
 l_nazn := substr(l_nazn, i_+1 );
 sTmp_  := substr(l_nazn,1,10);
--logger.info('NLK sTmp_='|| sTmp_);
 begin
   l_bday := to_date(sTmp_,'dd.mm.yyyy');
 exception when others then RETURN;
 end;
--logger.info('NLK l_bday='|| l_bday);

 --Место рождения
 l_nazn   := substr(l_nazn, 12 );
 i_       := instr(l_nazn,';');
 l_BPLACE := substr(l_nazn,1,i_-1);
--logger.info('NLK l_BPLACE='|| l_BPLACE);

 --Код страны (гражданство)
 l_nazn := substr(l_nazn, i_+1 );
 i_     := instr(l_nazn,';');
 sTmp_  := substr(l_nazn,1,i_-1);
--logger.info('NLK sTmp_='|| sTmp_);
 begin
   l_COUNTRY := to_number(sTmp_);
 exception  when others then RETURN;
 end;
--logger.info('NLK l_COUNTRY='|| l_COUNTRY);

 -- резидентность
 if l_COUNTRY = 804 then l_REZID := 1; else l_REZID := 2; end if;
--logger.info('NLK l_REZID='|| l_REZID);

 --Вид документа, удостоверяющего личность
 l_nazn := substr(l_nazn, i_+1 );
 i_     := instr(l_nazn,';');
 sTmp_  := substr(l_nazn,1,i_-1);
--logger.info('NLK sTmp_='|| sTmp_);
 begin
   l_PASSP := to_number(sTmp_);
 exception  when others then RETURN;
 end;
--logger.info('NLK l_PASSP='|| l_PASSP);

 --Серия документв
 l_nazn := substr(l_nazn, i_+1 );
 i_      := instr(l_nazn,';');
 l_SER   := substr(l_nazn,1,i_-1);
--logger.info('NLK l_SER='|| l_SER);

 --№ документа
 l_nazn := substr(l_nazn, i_+1 );
 i_       := instr(l_nazn,';');
 l_NUMDOC := substr(l_nazn,1,i_-1);
--logger.info('NLK l_NUMDOC='|| l_NUMDOC);

 --Место видачи документа
 l_nazn := substr(l_nazn, i_+1 );
 i_       := instr(l_nazn,';');
 l_ORGAN  := substr(l_nazn,1,i_-1);
--logger.info('NLK l_ORGAN='|| l_ORGAN);

 --Дата выдачи документа
 l_nazn := substr(l_nazn, i_+1 );
 sTmp_  := substr(l_nazn,1,10);
--logger.info('NLK sTmp_='|| sTmp_);
 begin
   l_PDATE := to_date(sTmp_,'dd.mm.yyyy');
 exception when others then RETURN;
 end;

 -- 12-05-2011
 If l_bday > l_PDATE then   l_PDATE := l_bday +1 ; end if;


--logger.info('NLK l_PDATE='|| l_PDATE);

  bc.subst_branch(l_branch);

  -- Регистрация клиента
  dpt_web.p_open_vklad_rnk( p_clientname     => l_nmk,
                            p_country        => l_COUNTRY,
                            p_index          => null,
                            p_obl            => null,
                            p_district       => null,
                            p_settlement     => null,
                            p_adress         => l_adr,
                            p_fulladdress    => l_adr,
                            p_clientcodetype => null,
                            p_clientcode     => l_okpo,
                            p_doctype        => l_passp,
                            p_docserial      => l_ser,
                            p_docnumber      => l_numdoc,
                            p_docorg         => l_organ,
                            p_docdate        => l_pdate,
                            p_clientbdate    => l_bday,
                            p_clientbplace   => l_bplace,
                            p_clientsex      => null,
                            p_clienthomeph   => null,
                            p_clientworkph   => null,
                            p_clientname_gc  => null,
                            p_resid_code     => l_REZID,
                            p_resid_index    => null,
                            p_resid_obl      => null,
                            p_resid_district => null,
                            p_resid_settlement => null,
                            p_resid_adress   => l_adr,
                            p_clientid       => l_RNK
                            );
--logger.info('NLK l_RNK='|| l_RNK);
  -- Открытие договора
  If    l_kv = 980 then  l_VIDD := 846; --508 Поточний в гривнях
  elsIf l_kv = 840 then  l_VIDD := 847; --526 Поточний в доларах США
  elsIf l_kv = 978 then  l_VIDD := 848; --526 Поточний в Євро
  elsIf l_kv = 643 then  l_VIDD := 849; --507 Поточний в рублях
  else RETURN ;
  end if ;

--logger.info('NLK l_VIDD='|| l_VIDD);

  begin
    select a.nls, substr(a.nms,1,38) into l_NLS26, l_nms26
    from accounts a, dpt_deposit d
    where a.nbs  = '2620'
      and a.kv   = l_kv
      and a.ob22 = '29'
      and a.dazs is null
      and a.rnk  = l_RNK
      and a.acc  = d.acc
      and d.rnk  = a.rnk
      and d.vidd = l_vidd
      and a.branch = l_branch  -- 15.06.2011
      and rownum = 1;
--logger.info('NLKol_NLS26='|| l_NLS26);
  EXCEPTION  WHEN NO_DATA_FOUND THEN

    dpt_web.create_deposit(l_VIDD,  --p_vidd         IN  dpt_deposit.vidd%type,   вклад АСВО
                           l_rnk ,  --p_rnk          IN  dpt_deposit.rnk%type,
            '2620/29'||'_'||l_RNK,  --p_nd           IN  dpt_deposit.nd%type,     idkart_tvbv_(nsc)
                           0    ,  --p_sum           IN  dpt_deposit.limit%type,  ost
                           0    ,  --p_nocash        IN  number,                  0
                           null ,  --p_datz          IN  dpt_deposit.datz%type,   DATO
                           null ,  --p_namep         IN  dpt_deposit.name_p%type,
                           null ,  --p_okpop         IN  dpt_deposit.okpo_p%type,
                           null ,  --p_nlsp          IN  dpt_deposit.nls_p%type,
                           null ,  --p_mfop          IN  dpt_deposit.mfo_p%type,
                           0    ,  --p_fl_perekr     IN  dpt_vidd.fl_2620%type,
                           null ,  --p_name_perekr   IN  dpt_deposit.nms_d%type,
                           null ,  --p_okpo_perekr   IN  dpt_deposit.okpo_p%type,
                           null ,  --p_nls_perekr    IN  dpt_deposit.nls_d%type,
                           null ,  --p_mfo_perekr    IN  dpt_deposit.mfo_d%type,
         'Для виплат по Родовiд',  --p_comment       IN  dpt_deposit.comments%type,
                         l_dptid,  --p_dpt_id        OUT dpt_deposit.deposit_id%type,
                        gl.bdate,  --p_datbegin      IN  dpt_deposit.dat_begin%type default gl.bdate
                           null ,  --p_duration      IN  dpt_vidd.duration%type default null
                           null,--p_duration_days IN  dpt_vidd.duration_days%type default null
						   'N'); -- признак веббанкинга

    select a.nls, substr(a.nms,1,38) into l_NLS26, l_nms26
    from accounts a, dpt_deposit d
    where a.acc = d.acc and d.DEPOSIT_ID = l_dptid;
--logger.info('NLKnl_NLS26='|| l_NLS26);
  end;

  bc.set_context;

  tuda;
  -- оплата
  gl.ref (REF_);
  gl.in_doc3(ref_  => REF_,
            tt_    => TT_ ,
            vob_   => VOB_,
            nd_    => l_nd,
            pdat_  => SYSDATE ,
            vdat_  => gl.BDATE,
            dk_    => 1,
            kv_    => l_kv,
            s_     => l_S,
            kv2_   => l_kv,
            s2_    => l_S ,
            sk_    => null,
            data_  => gl.BDATE,
            datp_  => gl.bdate,
            nam_a_ => l_nms29,
            nlsa_  => l_nls29,
            mfoa_  => gl.aMfo,
            nam_b_ => l_nms26,
            nlsb_  => l_nls26,
            mfob_  => gl.aMfo,
            nazn_  => 'Зарахування на поточний рахунок по дог.РОДОВIД банку',
            d_rec_ => null,
            id_a_  => null,
            id_b_  => null,
            id_o_  => null,
            sign_  => null,
            sos_   => 1,
            prty_  => null,
            uid_   => l_isp);
--logger.info('NLK REF_='|| REF_);

  gl.payv(flg_  => 0,
          ref_  => REF_ ,
          dat_  => gl.bDATE ,
          tt_   => TT_  ,
          dk_   => 1    ,
          kv1_  => l_kv ,
          nls1_ => l_nls29,
          sum1_ => l_s  ,
          kv2_  => l_kv ,
          nls2_ => l_nls26,
          sum2_ => l_S  );
--logger.info('NLK l_S='|| l_S);

  if l_nP > 0 then

     If l_kv <> gl.baseval  then
        l_q  := gl.p_icurval(l_kv, l_np, gl.bdate);

        If    l_nbsR='2630' then l_nbs7 := '7041'; l_ob7 := 'I8';
        elsIf l_nbsR='2635' then l_nbs7 := '7041'; l_ob7 := 'J1';
        else                     l_nbs7 := '7040'; l_ob7 := '33';
        end if;

     else
        l_q := l_np;

        If    l_nbsR='2630' then l_nbs7 := '7041'; l_ob7 := 'I7';
        elsIf l_nbsR='2635' then l_nbs7 := '7041'; l_ob7 := 'I9';
        else                     l_nbs7 := '7040'; l_ob7 := '32';
        end if;

     end if;

     l_nls70 := nbs_ob22_null( l_nbs7, l_ob7,l_branch);

     If l_nls70 is null then

        raise_application_error(-20100,
         'Не вiдкрито рах ' ||  l_NBS7 || '/' || l_ob7 || ' для '|| substr(l_branch,1,15)
          );

     end if;

     gl.payv(flg_  => 0,
             ref_  => REF_ ,
             dat_  => gl.bDATE ,
             tt_   => '%%1',
             dk_   => 0    ,
             kv1_  => l_kv ,
             nls1_ => l_nls26,
             sum1_ => l_np ,
             kv2_  => gl.baseval,
             nls2_ => l_nls70,
             sum2_ => l_Q  );
--logger.info('NLK l_np='|| l_np || ' l_Q='||l_Q );
  end if;

  gl.pay(2, REF_, gl.bDATE);

  update nlk_ref set ref2 = REF_ where acc = p_acc and ref1=p_ref1;

--logger.info('NLK OK');

end for_2620_29;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FOR_2620_29.sql =========*** End *
PROMPT ===================================================================================== 
