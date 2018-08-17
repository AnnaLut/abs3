PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/prov31.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view prov31 ***

create or replace view prov31 as
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
        from   (select ai.branch                      ,
                       ai.bsd                     nbs ,
                       substr('00'||ai.ob22de,-2) ob22,
                       ai.kv                          ,
                       ai.ost
                from   bars.asvo_immobile ai,bars.sk_asvo_fdep af
                  where  ai.fl=-10        
                  and ai.tvbv = af.kod_otd
                  and ai.branch = af.branch
                  and af.num_load = bars.sk_test.get_flag_name()
                  and ai.nls = af.nls
                  and ai.source='ภัยฮ' 
                  and ai.tvbv=SUBSTR(bars.sk_test.get_tvbv(),1,3)
                )
        group by branch,nbs,ob22,kv)              i,
       (select nbs||'*'||ob22||'*'||branch||'*'||to_char(kv) kl2,
               kv                                               ,
               nls                                              ,
               nms                                              ,
               ostc
        from   bars.accounts
        where  tip='ODB'    and
               dazs is null and
               ((nbs='2620' and ob22 IN ('08','09','11','12','05','16')) or
                (nbs='2630' and ob22 IN ('11','12','13','14','16','B6','B7','B8','B9'))      or
                (nbs='2628' AND ob22 IN ('05'))                          or
                (nbs='2638' AND ob22 IN ('17','16','02'))                or
                (nbs='2909' AND ob22 IN ('18')))) a
where  i.kl1=a.kl2(+)
order by 1,2,3;



PROMPT *** Create  grants  prov31 ***
grant SELECT                                                                 on prov31 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on prov31 to BARSR;
grant SELECT                                                                 on prov31 to BARSREADER_ROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/prov31.sql =========**
PROMPT ===================================================================================== 
