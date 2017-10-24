
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/norm_sdi.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NORM_SDI (p_ND number, p_dat date ) return number is
  l_RX   number ;
  l_EX   number ;
  l_dat31 date  := nvl(p_dat , gl.bdate) ;
  l_dat01 date  ;
  l_mdat  date  ;
  r_MDAT  date  ;
  l_tag  SPARAM_LIST.tag%type := 'IRR_ET';
  l_SPID SPARAM_LIST.SPID%type;
  DD cc_deal%rowtype ;
  A8 accounts%rowtype;
  l_SDI number       ;
  sTmp_ varchar2(200);
begin

  l_dat01 := l_dat31 + 1 ;

  -- Найти KD КД
  begin select   * into dd from cc_deal              where   nd =  p_nd and sdate <= l_dat31 ;
        select a.* into a8 from accounts a, nd_acc n where n.nd = dd.nd and a.tip = 'LIM' and a.acc = n.acc ;
  EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000,'Не знайдено КД nd = ' || p_nd );
  end;

  select max(bdat) into r_MDAT from int_ratn where acc=a8.acc and id = -2 and bdat <= l_dat31 ;
  l_RX   := NVL( acrn.fprocn(a8.acc,-2, r_MDAT), 0 ) / 100 ;
  l_EX   := nvl( dd.ir, 0 ) / 100 ;

  -- числовой код доп.рекв 'IRR_ET'
  begin select SPID into l_SPID from SPARAM_LIST where tag = l_tag ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20000,'Не встановлено ПЗ. Не описан рекв.'||l_tag  );
  end;

  -- Найти эталонную эф.ставку в архиве доп.рекв за ту же дату . что и реальная
  begin select to_number(val)/100 into l_EX from ACCOUNTSPV where acc = a8.acc and PARID = l_SPID and dat1 = r_MDAT ;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;
  sTmp_  := 'R_IRR='|| To_char( l_RX*100) || ', E_IRR=' || To_char( l_EX*100) || ' Вiд ' || to_char(r_MDAT,'dd.mm.yyyy');

  If l_EX > l_RX then    raise_application_error(-20000, 'НЕвідповідність ставок ! ' || sTmp_ );  End if;

  If l_dat31 < gl.bdate then
     select max(mdat) into l_MDAT from cc_lim_arc where nd = dd.nd and mdat <= l_dat01;
  end if;

  If l_dat31 >= gl.bdate OR l_MDAT is null then  -----------------------------------------------------  из тек ГПК
     select  NVL( sum( (sumo-nvl (sumk,0)) / power( (1+l_EX), (FDAT- (l_dat01) )/365 )  ), 0 )  -
             NVL( sum( (sumo-nvl (sumk,0)) / power( (1+l_RX), (FDAT- (l_dat01) )/365 )  ), 0 )
     into l_SDI from cc_lim    where nd = dd.nd and fdat > l_dat31 ;
  else                                          ------------------------------------------------------  ГПК из архива
     select  NVL( sum( (sumo-nvl (sumk,0)) / power( (1+l_EX), (FDAT- (l_dat01) )/365 )  ), 0 )  -
             NVL( sum( (sumo-nvl (sumk,0)) / power( (1+l_RX), (FDAT- (l_dat01) )/365 )  ), 0 )
     into l_SDI from cc_lim_ARC where nd = dd.nd and fdat > l_dat31 and mdat = l_MDAT ;
  end if;

  l_SDI := round( l_SDI,0);

  PUL.Set_Mas_Ini( 'NORM_SDI', sTmp_,  'NORM_SDI' );

  return l_SDI;

end NORM_SDI ;
/
 show err;
 
PROMPT *** Create  grants  NORM_SDI ***
grant EXECUTE                                                                on NORM_SDI        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NORM_SDI        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/norm_sdi.sql =========*** End *** =
 PROMPT ===================================================================================== 
 