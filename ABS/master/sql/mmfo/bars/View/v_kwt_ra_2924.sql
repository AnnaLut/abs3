

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KWT_RA_2924.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KWT_RA_2924 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KWT_RA_2924 ("DAT01", "ACC", "KV", "NLS", "OB22", "OST31", "NMS", "DAPP", "DAOS", "OSTC", "DATVZ", "SR") AS 
  select x."DAT01",x."ACC",x."KV",x."NLS",x."OB22",x."OST31",x."NMS",x."DAPP",x."DAOS",x."OSTC",x."DATVZ",   (select sum(s)/100 from bars.kwt_rt_2924 where acc = x.acc )  SR
from (select d.dat31+1 dat01, a.acc, a.kv, a.nls, a.ob22, bars.fost(a.acc, d.dat31)/100 ost31, a.nms, a.dapp, a.daos,
             a.ostc/100 ostc,
            (select max(fdat) from saldoa where ostf=0 and dos<>kos and acc = a.ACC ) datvz
      from  (select aa.*
             from bars.accounts aa
             where aa.nbs = '2924' --------- and aa.ob22 in ('01','14','15','16','17','18','23','25','26','27','28')
               and not exists (select 1 from bars.accountsw  ww  where ww.acc = aa.acc and ww.tag = 'KWT_2924' )
               and not exists (select 1 from bars.kwt_a_2924 kk  WHERE kk.acc = aa.acc )
             ) a,
---------- (select to_date('01-03-2017','dd-mm-yyyy')-1  dat31 from dual ) d
           (select B -1  dat31 from V_SFDAT ) d
     ) x
where  x.datvz < x.dat01  and x.ost31 <> 0 ;

PROMPT *** Create  grants  V_KWT_RA_2924 ***
grant SELECT                                                                 on V_KWT_RA_2924   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KWT_RA_2924   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KWT_RA_2924.sql =========*** End *** 
PROMPT ===================================================================================== 
