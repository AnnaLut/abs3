

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROV49.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view PROV49 ***

  CREATE OR REPLACE FORCE VIEW BARS.PROV49 ("FFF", "KV", "NLS", "OST", "SUM1", "DEL1", "KK") AS 
  select fff                      ,
         kv                       ,
         nls                      ,
         ost                      ,
         sum(sum1)            sum1,
         ost-nvl(sum(sum1),0) del1,
         kk
  from   (SELECT SUBSTR(pul.get_mas_ini_val('FFF'),1,3) fff ,
                 acc.kv                                     ,
                 acc.nls                                    ,
                 -acc.ost                               ost ,
--               SUM(nvl(deals.saldo_dep,0))            sum1,
                 SUM(deals.saldo_dep)                   sum1,
--               -acc.ost-SUM(deals.saldo_dep)          del1,
                 SUBSTR(f_comma('asvo_nls',
                                'kk',
                                'nls0_depo='''||acc.nls||''' and
                                 kv='||acc.kv||'             and
                                 tvbv='''||SUBSTR(pul.get_mas_ini_val('FFF'),1,3)||'''',
                                'order by kk'),1,254)   kk
          FROM   (SELECT kk,
                         kv,
                         SUM(saldo_dep) saldo_dep
                  FROM   (SELECT n.kk,
                                 n.kv,
                                 d.ost saldo_dep
                          FROM   asvo_compen     d,
                                 accounts        a,
                                 asvo_fff_branch b,
                                 asvo_nls        n
                          WHERE  n.kk=SUBSTR(d.nd,1,instr(d.nd,'_')-1)        AND
                                 n.kv=980                                     AND
                                 n.kv=d.kv                                    AND
                                 a.kv=d.kv                                    AND
--                               a.kf=f_ourmfo_g                              AND
                                 n.nls0_DEPO=a.nls                            AND
                                 a.branch=d.branch                            AND
                                 b.branch=d.branch                            AND
                                 b.fff=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) AND
                                 n.tvbv=b.fff                                 AND
                                 d.tvbv=b.fff                                 AND
                                 d.status=0)
                          GROUP  BY kk, kv)               deals,
                         (SELECT n.kk             ,
                                 n.kv             ,
                                 n.nls0_depo   nls,
                                 NVL(a.ostc,0) ost
                          FROM   asvo_nls n,
                                 accounts a
                          WHERE  n.kv=980                                      AND
                                 n.tvbv=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) AND
                                 n.nls0_depo=a.nls(+)                          AND
                                 n.kv=a.kv(+)                                  AND
                                 n.nls0_depo IS NOT NULL) acc
                  WHERE  deals.kk(+)=acc.kk AND
                         deals.kv(+)=acc.kv
                  GROUP  BY acc.kv, acc.nls, acc.ost)
  group  by fff,kv,nls,ost,kk
  order  by kk,kv;

PROMPT *** Create  grants  PROV49 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROV49          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROV49.sql =========*** End *** =======
PROMPT ===================================================================================== 
