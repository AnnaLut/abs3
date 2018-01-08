

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROV45.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view PROV45 ***

  CREATE OR REPLACE FORCE VIEW BARS.PROV45 ("COMM", "FFF", "KV", "NLS", "OST", "SUM1", "DEL1", "KK") AS 
  select decode(depr,' ÄÅÏ ',' ÄÅÏ ','ÏÐÎÖ') comm,
         fff                                     ,
         kv                                      ,
         nls                                     ,
         ost                                     ,
         sum(sum1)                           sum1,
         sum(sum1)-ost                       del1,
         kk
  from   (SELECT ' ÄÅÏ '                                depr,
                 SUBSTR(pul.get_mas_ini_val('FFF'),1,3) fff ,
                 acc.kv                                     ,
                 acc.nls                                    ,
                 acc.ost                                    ,
                 SUM(deals.saldo_dep)                   sum1,
                 SUM(deals.saldo_dep)-acc.ost           del1,
                 SUBSTR(f_comma('asvo_nls',
                                'kk',
                                'nls0_depo='''||acc.nls||''' and
                                 kv='||acc.kv||'             and
                                 tvbv='''||SUBSTR(pul.get_mas_ini_val('FFF'),1,3)||'''',
                                'order by kk'),1,254)   kk
          FROM   (SELECT kk                                     ,
                         kv                                     ,
                         SUM(saldo_dep) saldo_dep
                  FROM   (SELECT SUBSTR(d.nd,1,instr(d.nd,'_')-1) kk,
                                 a.kv                               ,
                                 a.ostc                           saldo_dep
                          FROM   dpt_deposit     d,
                                 accounts        a,
                                 asvo_fff_branch b
                          WHERE  d.acc=a.acc                                  AND
                                 d.branch=b.branch                            AND
                                 b.fff=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) AND
                                 substr(d.nd,INSTR(d.nd,'_')+1,3)=b.fff       AND
                                 d.comments LIKE '*Imported from ASVO6._')
                          GROUP   BY kk, kv)               deals,
                          (SELECT n.kk             ,
                                  n.kv             ,
                                  'DEP'         typ,
                                  n.nls0_depo   nls,
                                  NVL(a.ostc,0) ost
                           FROM   (select distinct
                                          kk       ,
                                          nls0_depo,
                                          kv       ,
                                          tvbv
                                   from   asvo_nls) n,
                                  accounts          a
                           WHERE  n.nls0_depo=a.nls(+)                          AND
                                  n.kv=a.kv(+)                                  AND
                                  n.tvbv=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) AND
                                  n.nls0_depo IS NOT NULL) acc
                  WHERE  deals.kk=acc.kk AND
                         deals.kv=acc.kv
                  GROUP  BY acc.kv, acc.nls, acc.ost
                  UNION ALL                                         /* çà÷èñëåíí */
                  SELECT 'ÇÀÐ'                             ,
                         detali.fff                        ,
                         kotel.kv                          ,
                         kotel.nls                         ,
                         kotel.ost                         ,
                         NVL(SUM(detali.zpr_d),0)          ,
                         NVL(SUM(detali.zpr_d),0)-kotel.ost,
                         SUBSTR(f_comma('asvo_nls'                 ,
                                        'kk'                       ,
                                        'nls0_procz='''||kotel.nls||''' and
                                         kv='||kotel.kv||'              and
                                         tvbv='''||detali.fff||'''',
                                        'order by kk'),1,254)
                  FROM   (SELECT SUBSTR(d.nd,1,instr(d.nd,'_')-1) kk,
                                 b.fff                              ,
                                 a.kv                               ,
                                 TO_NUMBER(w.VALUE)               zpr_d
                          FROM   dpt_deposit     d,
                                 asvo_fff_branch b,
                                 accounts        a,
                                 accountsw       w
                          WHERE  d.acc=a.acc                                  AND
                                 d.branch=b.branch                            AND
                                 w.acc=a.acc                                  AND
                                 b.fff=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) AND
                                 substr(d.nd,INSTR(d.nd,'_')+1,3)=b.fff       AND
                                 d.comments LIKE '*Imported from ASVO6._'     AND
                                 w.tag='ZPR_D')            detali,
                         (SELECT n.kk             ,
                                 n.kv             ,
                                 n.nls0_procz  nls,
                                 NVL(a.ostc,0) ost
                          FROM   (select distinct
                                         kk        ,
                                         nls0_procz,
                                         kv        ,
                                         tvbv
                                  from   asvo_nls) n,
                                 accounts          a
                          WHERE  n.nls0_procz=a.nls(+)                         AND
                                 n.kv=a.kv(+)                                  AND
                                 n.tvbv=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) AND
                                 n.nls0_procz IS NOT NULL) kotel
                  WHERE  detali.kk=kotel.kk AND
                         detali.kv=kotel.kv
                  GROUP  BY detali.fff,kotel.kv,kotel.nls,kotel.ost
                  UNION ALL                                         /* íà÷èñëåíí */
                  SELECT 'ÍÀÐ'                             ,
                         detali.fff                        ,
                         kotel.kv                          ,
                         kotel.nls                         ,
                         kotel.ost                         ,
                         NVL(SUM(detali.npr_d),0)          ,
                         NVL(SUM(detali.npr_d),0)-kotel.ost,
                         SUBSTR(f_comma('asvo_nls'                 ,
                                        'kk'                       ,
                                        'nls0_procn='''||kotel.nls||''' and
                                         kv='||kotel.kv||'              and
                                         tvbv='''||detali.fff||'''',
                                        'order by kk'),1,254)
                  FROM   (SELECT SUBSTR(d.nd,1,instr(d.nd,'_')-1) kk,
                                 b.fff                              ,
                                 a.kv                               ,
                                 TO_NUMBER(w.VALUE)               npr_d
                          FROM   dpt_deposit     d,
                                 asvo_fff_branch b,
                                 accounts        a,
                                 accountsw       w
                          WHERE  d.acc=a.acc                                  AND
                                 d.branch=b.branch                            AND
                                 w.acc=a.acc                                  AND
                                 b.fff=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) AND
                                 substr(d.nd,INSTR(d.nd,'_')+1,3)=b.fff       AND
                                 d.comments LIKE '*Imported from ASVO6._'     AND
                                 w.tag='NPR_D')            detali,
                         (SELECT n.kk             ,
                                 n.kv             ,
                                 n.nls0_procn  nls,
                                 NVL(a.ostc,0) ost
                          FROM   (select distinct
                                         kk        ,
                                         nls0_procn,
                                         kv        ,
                                         tvbv
                                  from   asvo_nls) n,
                                 accounts          a
                          WHERE  n.nls0_procn=a.nls(+)                         AND
                                 n.kv=a.kv(+)                                  AND
                                 n.tvbv=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) AND
                                 n.nls0_procn IS NOT NULL) kotel
                  WHERE  detali.kk=kotel.kk AND
                         detali.kv=kotel.kv
                  GROUP  BY detali.fff,kotel.kv,kotel.nls,kotel.ost)
  group  by decode(depr,' ÄÅÏ ',' ÄÅÏ ','ÏÐÎÖ'),fff,kv,nls,ost,kk
  union all
  select 'ÏÐÎÖ'                                ,
         SUBSTR(pul.get_mas_ini_val('FFF'),1,3),
         kv                                    ,
         null                                  ,
         null                                  ,
         sum(to_number(value))                 ,
         sum(to_number(value))                 ,
         kk
  from   (select SUBSTR(d.nd,1,instr(d.nd,'_')-1) kk,
                 w.tag                              ,
                 w.value                            ,
                 d.nd                               ,
                 n.kv                               ,
                 d.acc
          from   accountsw   w,
                 dpt_deposit d,
                 accounts    a,
                 asvo_nls    n
          where  (w.tag='NPR_D'                                 and
                  w.value<>'0'                                  and
                  d.acc=w.acc                                   and
                  d.comments LIKE '*Imported from ASVO6._'      and
                  substr(d.nd,INSTR(d.nd,'_')+1,3)=n.tvbv       and
                  a.acc=w.acc                                   and
                  n.tvbv=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) and
                  n.kk=SUBSTR(d.nd,1,instr(d.nd,'_')-1)         and
                  nullif(n.nls0_procn,'0') is null)             or
                 (w.tag='ZPR_D'                                 and
                  w.value<>'0'                                  and
                  d.acc=w.acc                                   and
                  d.comments LIKE '*Imported from ASVO6._'      and
                  substr(d.nd,INSTR(d.nd,'_')+1,3)=n.tvbv       and
                  a.acc=w.acc                                   and
                  n.tvbv=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) and
                  n.kk=SUBSTR(d.nd,1,instr(d.nd,'_')-1)         and
                  nullif(n.nls0_procz,'0') is null)             and
                 n.kk not in (select kk
                              from   asvo_nls
                              where  tvbv=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) and
                                     (nullif(nls0_procz,'0') is not null or
                                      nullif(nls0_procn,'0') is not null))
         )
  group  by kk,kv
  order  by kk,kv;

PROMPT *** Create  grants  PROV45 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROV45          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROV45.sql =========*** End *** =======
PROMPT ===================================================================================== 
