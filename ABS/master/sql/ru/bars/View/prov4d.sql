

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROV4D.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view PROV4D ***

  CREATE OR REPLACE FORCE VIEW BARS.PROV4D ("FFF", "KV", "NLS", "OST", "SUM1", "DEL1") AS 
  select fff                      ,
         kv                       ,
         nls                      ,
         ost                      ,
         sum(sum1)            sum1,
         nvl(ost-sum(sum1),0) del1
  from   (SELECT SUBSTR(pul.get_mas_ini_val('FFF'),1,3) fff ,
                 acco.kv                                    ,
                 acco.nls                                   ,
                 -acco.ost                              ost ,
                 comp.ost                               sum1,
                 -acco.ost-comp.ost                     del1
          FROM   (SELECT a.kv ,
                         a.nls,
                         a.ostc ost
                  from   accounts                                              a,
                         (select  distinct
                                  substr(nd,1,instr(nd,'_')-1) nls,
                                  kv                              ,
                                  tvbv
                          from    asvo_compen
                          where   tvbv=SUBSTR(pul.get_mas_ini_val('FFF'),1,3)) n
                  where  a.kv=n.kv and
                         a.nls=n.nls)                       acco,
                 (select kv                              ,
                         substr(nd,1,instr(nd,'_')-1) nls,
                         sum(ost)                     ost
                  from   asvo_compen
                  where  tvbv=SUBSTR(pul.get_mas_ini_val('FFF'),1,3) AND
                         status=0
                  group by kv,substr(nd,1,instr(nd,'_')-1)) comp
          WHERE  comp.kv=acco.kv and
                 comp.nls=acco.nls)
  group  by fff,kv,nls,ost;

PROMPT *** Create  grants  PROV4D ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROV4D          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROV4D.sql =========*** End *** =======
PROMPT ===================================================================================== 
