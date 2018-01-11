

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROV31.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view PROV31 ***

  CREATE OR REPLACE FORCE VIEW BARS.PROV31 ("BRANCH", "NBS", "OB22", "NLS", "KV", "NMS", "OSTC", "SOST", "DIFF", "CNT") AS 
  select i.branch                 ,
       i.nbs                    ,
       i.ob22                   ,
       a.nls                    ,
       i.kv                     ,
       a.nms                    ,
       a.ostc                   ,
       i.sost                   ,
       nvl(a.ostc,0)-i.sost diff,
       i.cnt
from   (select nbs||'*'||substr('00'||ob22,-2)||'*'||branch||'*'||to_char(kv) kl1 ,
               nbs                                                                ,
               branch                                                             ,
               kv                                                                 ,
               ob22                                                               ,
               sum(ost)                                                       sost,
               count(*)                                                       cnt
        from   (select branch                      ,
                       bsd                     nbs ,
                       substr('00'||ob22de,-2) ob22,
                       kv                          ,
                       ost
                from   asvo_immobile
                where  fl=-10        and
                       source='ภัยฮ' and
                       tvbv=SUBSTR(pul.Get_Mas_Ini_Val('FFF'),1,3))
        group by branch,nbs,ob22,kv)              i,
       (select nbs||'*'||ob22||'*'||branch||'*'||to_char(kv) kl2,
               kv                                               ,
               nls                                              ,
               nms                                              ,
               ostc
        from   accounts
        where  tip='ODB'    and
               dazs is null and
               ((nbs='2620' and ob22 IN ('08','09','11','12','05','16')) or
                (nbs='2630' and ob22 IN ('11','12','13','14','16'))      or
                (nbs='2635' and ob22 IN ('13','14','15','16'))           or
                (nbs='2628' AND ob22 IN ('05'))                          or
                (nbs='2638' AND ob22 IN ('17','16','02'))                or
                (nbs='2909' AND ob22 IN ('18')))) a
where  i.kl1=a.kl2(+)
order by 1,2,3;

PROMPT *** Create  grants  PROV31 ***
grant SELECT                                                                 on PROV31          to BARSREADER_ROLE;
grant SELECT                                                                 on PROV31          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROV31          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROV31.sql =========*** End *** =======
PROMPT ===================================================================================== 
