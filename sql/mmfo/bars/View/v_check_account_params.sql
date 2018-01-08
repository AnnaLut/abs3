

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CHECK_ACCOUNT_PARAMS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CHECK_ACCOUNT_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CHECK_ACCOUNT_PARAMS ("BRANCH", "ISP", "NBS", "NLS", "KV", "RNK", "TAG", "VAL") AS 
  select  branch, isp,nbs, nls, kv, rnk,replace(tag,'_1','') tag, val
from
(
select a.isp,a.nbs, a.nls, a.kv, a.rnk, a.BRANCH,
       case when ((s.s080 is null) and k.r020 is not null and a.OSTC < 0)
            then 'Не заполнен параметр S080'
            else null
       end s080,
       case when ((s.s260 is null) and k.r020 is not null and a.OSTC < 0)
            then 'Не заполнен параметр S260'
            else null
       end s260,
       case when ((s.r013 is null) and k1.r020 is not null  and a.OSTC < 0)
            then 'Не заполнен параметр R013'
            else null
       end r013,
       case when (s.r013 is not null and k1.r020 is not null and a.OSTC < 0 and instr(k1.r013,s.r013) = 0)
            then 'Недопустимый параметр R013 - '||s.r013||' (Возможные - '|| k1.r013||')'
            else null
       end r013_1
       ,case when (s.s270 is not null and k3.r020 is not null and a.OSTC < 0 and instr(k3.s270,s.s270) = 0)
            then 'Недопустимый параметр S270 - '||s.s270||' (Возможные - '|| k3.s270||')'
            else null
       end s270
       ,case when (p.acc is not null and p.pawn is null)
            then 'Не заполнен параметр PAWN (вид обеспечения) '
            else null
       end pawn
       ,case when  (p.acc is not null and p.pawn is not null and instr(cp.pawn,p.pawn) = 0)
            then 'Недопустимый параметр PAWN (вид обеспечения) - '||p.pawn||' (Возможные - '|| cp.pawn||')'
            else null
       end pawn_1
    from accounts a
         left join specparam s on a.acc = s.acc
         left join (
            SELECT  r020
            FROM kod_r020
            WHERE a010 = '11' AND prem = 'КБ ' and nvl(d_close, to_date('01014000','ddmmyyyy')) > trunc(sysdate)
            group by r020
        ) k  on a.nbs = k.r020
        left join (select r020, ConcatStr(to_char(r013)) r013 from kl_r013 where nvl(d_close, to_date('01014000','ddmmyyyy')) > trunc(sysdate) group by r020) k1 on a.nbs = k1.r020
        left join (
            SELECT  r020, (select ConcatStr(to_char(s270)) from kl_s270) s270
            FROM kod_r020
            WHERE a010 = 'D5' AND prem = 'КБ ' and nvl(d_close, to_date('01014000','ddmmyyyy')) > trunc(sysdate)
            group by r020
        ) k3 on  a.nbs = k3.r020
        left join pawn_acc p on a.acc = p.acc
        left join
        (   SELECT  nbsz r020, ConcatStr(pawn) pawn
            FROM cc_pawn
            group by nbsz
        ) cp on a.nbs = cp.r020
    where  nvl(a.dazs,to_date('01014000','ddmmyyyy')) > bankdate and
         (
         ((s.s080 is null or s.s260 is null) and k.r020 is not null and a.OSTC < 0) or
         (s.r013 is null and k1.r020 is not null and a.OSTC < 0) or
         (s.r013 is not null and k1.r020 is not null and a.OSTC < 0 and instr(k1.r013,s.r013) = 0) or
         (s.s270 is not null and k3.r020 is not null and a.OSTC < 0 and instr(k3.s270,s.s270) = 0) or
        (p.acc is not null and p.pawn is null) or
        (p.acc is not null and p.pawn is not null and instr(cp.pawn,p.pawn) = 0)
        )
)
unpivot ( val FOR tag IN (s080, s260, r013,r013_1,s270,pawn,pawn_1))
union all
select nbuc, isp, substr(nls,1,4) nbs, nls, kv, rnk, '240' tag, 'Не заполнен параметр S240' val
from rnbu_trace where substr(kodp,8,1) = '0'

 ;

PROMPT *** Create  grants  V_CHECK_ACCOUNT_PARAMS ***
grant SELECT                                                                 on V_CHECK_ACCOUNT_PARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CHECK_ACCOUNT_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CHECK_ACCOUNT_PARAMS to RPBN002;
grant SELECT                                                                 on V_CHECK_ACCOUNT_PARAMS to TECH005;
grant SELECT                                                                 on V_CHECK_ACCOUNT_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CHECK_ACCOUNT_PARAMS.sql =========***
PROMPT ===================================================================================== 
