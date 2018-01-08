CREATE OR REPLACE function BARS.Stop_KK ( p_ref  number )  RETURN NUMBER IS
--28.10.2015 Сухова  Дополнение к cck.CC_STOP ( ref_  int )
  l_nd number;
begin
  l_nd := cck.cc_stop ( p_REF );  -- общая функция проверки
  ----------------------------------------- Для ОСББ первая выдача
  -- Для продукту (2062/19 та 2063/09)  необхідно забезпечити контроль щодо наявності разової комісії на рахунку дисконту (SDI/S36) при видачі ПЕРШИХ кредитних коштів.
  begin
     select n.nd into l_ND   from accounts  a, nd_acc n, oper o   where o.ref = p_REF  and a.nls = o.NLSA and a.kv = o.kv
       and ( a.nbs='2063' and a.ob22='09'   OR  a.nbs=decode(NEWNBS.GET_STATE,0,'2062','2063') and a.ob22=decode(NEWNBS.GET_STATE,0,'19','26')
-------- OR  a.nbs='2063' and a.ob22='10'   OR  a.nbs='2062' and a.ob22='20' -------
           )   and a.dapp is null and a.dos = 0 and a.kos = 0 and a.ostc =0  and a.acc = n.acc ;

     begin select n.nd into l_ND  from accounts a, nd_acc n where a.tip in ('SDI','S36')   and  a.ostc > 0  and n.nd = l_nd  and a.acc = n.acc  and rownum = 1;
     EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-(20203),'\8999 - cck_OSBB: КД '||l_ND|| ' Не внесено початкову комсію' ) ;
     end ;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end ;
  RETURN 0 ;
end Stop_KK;
/