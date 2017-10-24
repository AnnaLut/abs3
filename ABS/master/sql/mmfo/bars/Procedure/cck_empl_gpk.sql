

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_EMPL_GPK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_EMPL_GPK ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_EMPL_GPK (p_nd decimal, p_mode number) is

/*
       Процедура для специфічної побудови графіка платежів:
       1. Побудова графіка для співробітників банка на основі базової відсоткової ставки
       2. Перебудова графіка при настанні дати дії ринкової відсоткової ставки
*/
  is_employee number;
  l_cc_deal cc_deal%rowtype;
  l_rate decimal;
  l_rate_next decimal;
  l_rate_market number(5,2);
  l_datert_market date;
  l_dat_nxtrate date;
  l_aa8 accounts%rowtype;
  l_ii1 int_accn%rowtype;
  l_sumr number;
  l_sump number;
  l_mode number;
  s_GRAC1 varchar2(10);
  d_GRAC1 date;
begin
  bars_audit.info('Start cck_empl_gpk nd = '||p_nd);

  begin
    select 1
      into is_employee
      from dual
     where cck_app.Get_ND_TXT(p_nd,'INTRT') is not null
       and cck_app.Get_ND_TXT(p_nd,'DTRTB') is not null
       and rownum = 1;
  exception
    when no_data_found then
      is_employee := 0;
  end;

  select * into l_cc_deal from cc_deal where nd = p_nd;
  select a.* into l_aa8 from accounts a, nd_acc n where a.tip='LIM' and a.acc= n.acc and n.nd = l_cc_deal.nd;
  select * into l_ii1 from int_accn where id= 0 and acc = l_aa8.acc and s >=1;

  if p_mode = 1 and is_employee = 1 then
    --CCK.CC_LIM_NULL(p_nd);

    /*begin
      select rate
        into l_rate
        from v_brates
       where br_id = 9999
         and dat <= l_cc_deal.sdate
         and dat = (select max(dat)
                      from v_brates
                     where br_id = 9999
                       and dat <= l_cc_deal.sdate);
    exception
      when no_data_found then
        l_rate := cck_app.Get_ND_TXT(p_nd,'INTRT');
    end;*/

    select decode(l_aa8.vid,2,1,4,3,1) into l_mode from dual;

    cck.CC_TMP_GPK(ND_      => p_nd,
                   nVID_    => l_aa8.vid,
                   ACC8_    => l_aa8.acc,
                   DAT3_    => l_cc_deal.sdate,
                   DAT4_    => l_cc_deal.wdate,
                   Reserv_  => null,
                   SUMR_    => null,
                   gl_BDATE => null);

    /*CCK.CC_GPK (MODE_ => l_mode        , --- int ,
                 ND_   => p_nd    , -- int ,
                 ACC_  => l_aa8.acc  , -- int,
                 BDAT_1=> gl.bdate , -- date,
                 DATN_ => cck.f_dat (l_ii1.s, trunc(add_months(gl.bdate,1),'MM')  ),   -- ii1.APL_DAT, --- date,
                 DAT4_ => l_cc_deal.wdate, --  date,
                 SUM1_ => l_cc_deal.sdog , -- number,
                 FREQ_ => 5        , -- int,
                 RATE_ => l_rate     , ----number,
                 DIG_  => 0) ;

    begin
      insert into cc_lim (ND, FDAT, LIM2, ACC, SUMG, SUMO, SUMK)
      values(p_nd, l_cc_deal.sdate, 0, l_aa8.acc, 0, 0, 0);
    exception
      when dup_val_on_index then
        null;
    end;

    begin
      select rate,
             dat
        into l_rate_next,
             l_dat_nxtrate
        from v_brates
       where br_id = 9999
         and dat > l_cc_deal.sdate
         and dat = (select max(dat)
                      from v_brates
                     where br_id = 9999
                       and dat > l_cc_deal.sdate);

      if l_aa8.vid = 4 then
        l_dat_nxtrate := cck.f_dat(l_ii1.s, trunc(l_dat_nxtrate));
      end if;
  ----- добавить прогноз-график для части-2    -------------------------RETURN ;
      select lim2 into l_sumr from cc_lim where nd = p_nd and fdat = l_dat_nxtrate;
      cck.UNI_GPK_FL (p_lim2  => l_sumr  ,  -- новый лимит
                     p_gpk   => l_aa8.vid     ,  -- 1-Ануитет. 0 - Класс
                     p_dd    => l_ii1.s  ,  -- <Платежный день>, по умол = DD от текущего банк.дня
                     p_datn  => l_dat_nxtrate,  -- дата нач КД
                     p_datk  => l_cc_deal.wdate,   -- дата конца КД
                     p_ir    => l_rate_next   ,    -- проц.ставка
                     p_pl1   => cck.f_pl1(0, l_sumr, l_aa8.vid, l_ii1.s, l_dat_nxtrate, l_cc_deal.wdate, l_rate_next,0),        -- сумма 1 пл
                     p_ssr   => 0      ,     -- признак =0= "с сохранением срока"
                     p_ss    => 0      ,     -- остаток по норм телу
                     p_acrd  => l_dat_nxtrate,     -- с какой даты начислять % acr_dat+1
                     p_basey => 2             -- база для нач %%;
                          );
     select nvl(sum(sumo-sumg),0) into l_sump from cc_lim where nd = p_nd and fdat >= l_dat_nxtrate;
     delete from cc_lim where nd = p_nd and fdat > l_dat_nxtrate;
     --update cc_lim set sumg = 0, sumo = l_sump, lim2 = l_sumr where nd = p_nd and fdat  = l_dat_nxtrate;
     insert into cc_lim (ND,FDAT,LIM2,ACC,SUMG,SUMO,SUMK) select p_nd,fdat,lim2,l_aa8.acc,sumg,sumo,nvl(sumk,0) from tmp_gpk where fdat > l_dat_nxtrate;
    exception
      when no_data_found then
        null;
    end;*/
  elsif p_mode = 2 and is_employee = 1 then
    l_datert_market := to_date(cck_app.Get_ND_TXT(p_nd,'DTRTB'),'dd.mm.yyyy');
    if l_datert_market = gl.bd then
      l_rate_market := wcs_register.to_number2(cck_app.Get_ND_TXT(p_nd,'INTRT'));
      select lim2
        into l_sumr
        from cc_lim
       where fdat = to_date(lpad(to_char(extract(DAY from fdat)),2,'0')||to_char(l_datert_market,'mmyyyy'),'dd.mm.yyyy')
         and nd = p_nd
         and rownum = 1;

      cck.UNI_GPK_FL (p_lim2  => l_sumr  ,  -- новый лимит
                     p_gpk   => l_aa8.vid     ,  -- 1-Ануитет. 0 - Класс
                     p_dd    => l_ii1.s  ,  -- <Платежный день>, по умол = DD от текущего банк.дня
                     p_datn  => l_datert_market,  -- дата нач КД
                     p_datk  => l_cc_deal.wdate,   -- дата конца КД
                     p_ir    => l_rate_market   ,    -- проц.ставка
                     p_pl1   => cck.f_pl1(0, l_sumr, l_aa8.vid, l_ii1.s, l_datert_market, l_cc_deal.wdate, l_rate_market,0),        -- сумма 1 пл
                     p_ssr   => 0      ,     -- признак =0= "с сохранением срока"
                     p_ss    => 0      ,     -- остаток по норм телу
                     p_acrd  => l_datert_market,     -- с какой даты начислять % acr_dat+1
                     p_basey => 2             -- база для нач %%;
                          );
     select nvl(sum(sumo-sumg),0) into l_sump from cc_lim where nd = p_nd and fdat >= l_datert_market;
     delete from cc_lim where nd = p_nd and fdat >= l_datert_market;
     --update cc_lim set sumg = 0, sumo = l_sump, lim2 = l_sumr where nd = p_nd and fdat  = l_dat_nxtrate;
     insert into cc_lim (ND,FDAT,LIM2,ACC,SUMG,SUMO,SUMK) select p_nd,fdat,lim2,l_aa8.acc,sumg,sumo,nvl(sumk,0) from tmp_gpk where fdat > l_datert_market;
     begin
       insert into int_ratn(acc,id,bdat,ir,idu,kf) values (l_aa8.acc,0,l_datert_market,l_rate_market,user_id,f_ourmfo);
     exception
       when dup_val_on_index then
         update int_ratn set ir = l_rate_market where acc = l_aa8.acc and id = 0 and bdat = l_datert_market;
     end;
    end if;
  end if;
  bars_audit.info('Finish cck_empl_gpk nd = '||p_nd);
end cck_empl_gpk;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_EMPL_GPK.sql =========*** End 
PROMPT ===================================================================================== 
